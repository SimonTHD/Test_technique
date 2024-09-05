from django.contrib import admin
from django.urls import path, include
from rest_framework import routers
from runserver.views import ArticleViewSet

router = routers.DefaultRouter()
router.register(r'articles', ArticleViewSet)

urlpatterns = [
    path('admin/', admin.site.urls),
]