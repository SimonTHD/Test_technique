from django.contrib import admin
from django.urls import path, include
from rest_framework_simplejwt.views import (
    TokenObtainPairView,
    TokenRefreshView,
)
from drf_yasg.views import get_schema_view
from drf_yasg import openapi
from rest_framework import permissions
from runserver.views import CreateUserView, CreateProject, UserProjects, DeleteProject, UpdateProject

schema_view = get_schema_view(
    openapi.Info(
        title="Test Technique API",
        default_version='v1',
        description="Documentation de l'API",
    ),
    public=True,
    permission_classes=(permissions.AllowAny,),
)

urlpatterns = [ 
    path('api/token/', TokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('api/token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
    path('api/', include('runserver.urls')),
    path('swagger/', schema_view.with_ui('swagger', cache_timeout=0), name='schema-swagger-ui'),
    path('redoc/', schema_view.with_ui('redoc', cache_timeout=0), name='schema-redoc'),
    path('api/create-user/', CreateUserView.as_view(), name='create_user'),
    path('projects/', CreateProject.as_view(), name='create_project'),
    path('projects/user/', UserProjects.as_view(), name='user_projects'),
    path('projects/delete/<int:project_id>/', DeleteProject.as_view(), name='delete_project'),
    path('projects/update/<int:project_id>/', UpdateProject.as_view(), name='update_project'),
]
