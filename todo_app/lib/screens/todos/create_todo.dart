import 'package:flutter/material.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/services/api_service.dart';
import 'package:todo_app/widgets/custom_scaffold.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class CreateTaskScreen extends StatefulWidget {
  @override
  _CreateTaskScreenState createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime _dueDate = DateTime.now();

  Future<void> _createTask() async {
    if (_formKey.currentState!.validate()) {
      Task newTask = Task(
        id: 0, // Will be set by the backend
        title: _titleController.text,
        description: _descriptionController.text.isEmpty ? null : _descriptionController.text,
        completed: false,
        dueDate: _dueDate,
        dateCreated: DateTime.now(),
      );

      try {
        Task createdTask = await ApiService.createTask(newTask);
        if (createdTask != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Task created successfully'),
            backgroundColor: Colors.blue,
            ),
          );
          Navigator.pop(context, true); // Pass true to indicate a new task was created
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to create task'),
            backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Feather.chevron_left,
            size: 30,
          ),
          color: Colors.blue,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: null,  // Set title to null to use flexibleSpace for centering
        flexibleSpace: Center(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Create ',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: 'Task',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.blue,  // Change the color for part of the text
                  ),
                ),
              ],
            ),
          ),
        ),
        
      ),

      child: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              elevation: 4.0,
              child: Padding(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: 'Title',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the task title';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the task description';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Due Date: ${_dueDate.toLocal().toString().split(' ')[0]}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        DateTime? selectedDate = await showDatePicker(
                          context: context,
                          initialDate: _dueDate,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                        );

                        if (selectedDate != null && selectedDate != _dueDate) {
                          setState(() {
                            _dueDate = selectedDate;
                          });
                        }
                      },
                      child: Text('Select Due Date'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,

                        iconColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _createTask,
                        child: Text('Create Task'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue,
                          // iconColor: Theme.of(context).primaryColor,
                          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                          textStyle: TextStyle(fontSize: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
