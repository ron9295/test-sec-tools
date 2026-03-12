from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    # הכללת כתובות ה-URL של האפליקציה myapp תחת הנתיב 'api/'
    # כתובת ה-API הסופית תהיה: http://127.0.0.1:8000/api/tasks/
    path('api/', include('myapp.urls')),
]
