from rest_framework import viewsets
from .models import Article
from .serializers import ArticleSerializer
from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.decorators import permission_classes
from .serializers import UserSerializer
from .serializers import ProjectSerializer
from rest_framework.permissions import IsAuthenticated, AllowAny
from .models import Project

class ArticleViewSet(viewsets.ModelViewSet):
    queryset = Article.objects.all()
    serializer_class = ArticleSerializer

class CreateUserView(APIView):
    permission_classes = [AllowAny]
    def post(self, request):
        serializer = UserSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class CreateProject(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        print("Request data:", request.data)
        serializer = ProjectSerializer(data=request.data)
        if serializer.is_valid():
            print("Valid data:", serializer.validated_data)
            serializer.save(user=request.user)
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        print("Errors:", serializer.errors)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    

class UserProjects(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        user_projects = Project.objects.filter(user=request.user)
        serializer = ProjectSerializer(user_projects, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)
    
class DeleteProject(APIView):
    permission_classes = [IsAuthenticated]

    def delete(self, request, project_id):
        try:
            project = Project.objects.get(id=project_id, user=request.user)
        except Project.DoesNotExist:
            return Response({"error": "Project not found or you don't have permission to delete it."}, 
                            status=status.HTTP_404_NOT_FOUND)
        
        project.delete()
        return Response({"message": "Project deleted successfully."}, status=status.HTTP_204_NO_CONTENT)

class UpdateProject(APIView):
    permission_classes = [IsAuthenticated]

    def put(self, request, project_id):
        try:
            project = Project.objects.get(id=project_id, user=request.user)
        except Project.DoesNotExist:
            return Response({"error": "Project not found or you don't have permission to modify it."}, 
                            status=status.HTTP_404_NOT_FOUND)
        
        serializer = ProjectSerializer(project, data=request.data, partial=True)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)