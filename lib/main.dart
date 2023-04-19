import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodboard_admin_application/addRecipe/admin_login.dart';
import 'package:foodboard_admin_application/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FoodBoard Admin',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const Admin_Login(),
    );
  }
}

// StreamBuilder<User?>(
//           stream: FirebaseAuth.instance.authStateChanges(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const CircularProgressIndicator();
//             } else if (snapshot.hasError) {
//               return Center(child: Text(snapshot.error.toString()));
//             } else if (snapshot.hasData) {
//               return const RecipeDetails();
//             } else {
//               return const User_Login();
//             }
//           }),
