# Generated by Django 5.0.6 on 2024-06-29 14:40

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('task', '0004_task_due_date'),
    ]

    operations = [
        migrations.RenameField(
            model_name='task',
            old_name='Completed',
            new_name='completed',
        ),
        migrations.RenameField(
            model_name='task',
            old_name='Date_created',
            new_name='date_created',
        ),
        migrations.RenameField(
            model_name='task',
            old_name='Description',
            new_name='description',
        ),
        migrations.RenameField(
            model_name='task',
            old_name='Title',
            new_name='title',
        ),
    ]