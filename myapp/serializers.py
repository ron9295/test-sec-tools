from rest_framework import serializers


from .models import Task

class TaskSerializer(serializers.ModelSerializer):
    description = serializers.CharField(required=False, allow_blank=True, write_only=True)
    completed = serializers.BooleanField(write_only=True)

    class Meta:
        model = Task
        fields = ['title', 'description', 'completed']
