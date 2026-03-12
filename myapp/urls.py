from django.urls import path, include

from rest_framework.routers import DefaultRouter
from .views import TaskViewSet

# יצירת Router: זה מטפל אוטומטית ביצירת כתובות URL עבור כל הפעולות (list, retrieve, create, update, destroy)
router = DefaultRouter()
# רישום ה-ViewSet ל-Router
router.register(r'tasks', TaskViewSet)

urlpatterns = [
    # כל הכתובות של ה-Router יהיו נגישות תחת '/api/'
    path('', include(router.urls)),
]
