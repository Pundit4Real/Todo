import 'package:flutter/material.dart';
import 'package:todo_app/screens/auth/login.dart';
import 'package:todo_app/screens/auth/registration.dart';
import 'package:todo_app/screens/todos/list_todo.dart' as list;
import 'package:todo_app/screens/todos/create_todo.dart' as create;
import 'package:todo_app/screens/profile/profile.dart' as profile;
import 'package:todo_app/screens/todos/update_todo.dart' as update;
import 'package:todo_app/screens/todos/todo_detail.dart' as detail;
import 'package:todo_app/screens/todos/delete_todo.dart' as delete;
import 'package:todo_app/screens/profile/update_profile.dart' as update_profile;
import 'package:todo_app/models/task.dart';
import 'package:todo_app/screens/auth/welcome.dart';
import 'package:todo_app/screens/auth/email_verification.dart';
import 'package:todo_app/screens/auth/reset_password.dart';
import 'package:todo_app/screens/auth/forgot_password.dart';
import 'package:todo_app/screens/splash/splash_screen.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primaryColor: Color(0xFF0E9FEF),
        scaffoldBackgroundColor: Color(0xFF0E9FEF),
        textTheme: const TextTheme(
          displayLarge: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (context) => SplashScreen());
          case '/welcome':
            return MaterialPageRoute(builder: (context) => WelcomeScreen());
          case '/register':
            return MaterialPageRoute(builder: (context) => RegisterScreen());
          case '/login':
            return MaterialPageRoute(builder: (context) => LoginScreen());
          case '/todo-list':
            return MaterialPageRoute(builder: (context) => list.TodoListScreen());
          case '/create-task':
            return MaterialPageRoute(builder: (context) => create.CreateTaskScreen());
          case '/update-task':
            final task = settings.arguments as Task;
            return MaterialPageRoute(builder: (context) => update.UpdateTaskScreen(task: task));
          case '/task-detail':
            final task = settings.arguments as Task;
            return MaterialPageRoute(builder: (context) => detail.TaskDetailScreen(task: task));
          case '/delete-task':
            final task = settings.arguments as Task;
            return MaterialPageRoute(builder: (context) => delete.DeleteTaskScreen(task: task));
          case '/profile':
            return MaterialPageRoute(builder: (context) => profile.ProfileScreen());
          case '/update-profile':
            return MaterialPageRoute(builder: (context) => update_profile.UpdateProfileScreen());
          case '/verify-email':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) => EmailVerificationScreen(email: args['email']),
            );
          case '/reset-password':
            final email = settings.arguments as String;
            return MaterialPageRoute(builder: (context) => ResetPasswordScreen(email: email));
          case '/forgot-password':
            return MaterialPageRoute(builder: (context) => ForgotPasswordScreen());
          default:
            return MaterialPageRoute(builder: (context) => WelcomeScreen());
        }
      },
    );
  }
}