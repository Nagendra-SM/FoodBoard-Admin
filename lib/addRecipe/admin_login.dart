import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodboard_admin_application/home.dart';
import 'package:foodboard_admin_application/utils/admin_model.dart';
import 'package:foodboard_admin_application/utils/colors.dart';
import 'package:foodboard_admin_application/widgets/app_btn.dart';
import 'package:foodboard_admin_application/widgets/big_text.dart';
import 'package:foodboard_admin_application/widgets/textField_widget.dart';
import 'package:passwordfield/passwordfield.dart';

// ignore: camel_case_types
class Admin_Login extends StatefulWidget {
  const Admin_Login({Key? key}) : super(key: key);

  @override
  State<Admin_Login> createState() => _Admin_LoginState();
}

// ignore: camel_case_types
class _Admin_LoginState extends State<Admin_Login> {
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return AppColors.mainColor;
  }

  bool isChecked = false;
  String? errorMessage;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  AdminModel loggedInUser = AdminModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  height: 250,
                  child: Center(
                    child: Image.asset("assets/Logo.png"),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Field_Widget(
                  type: TextInputType.emailAddress,
                  control: email,
                  hint: "Email",
                  valid: (value) {
                    if (value!.isEmpty) {
                      return ("Please Enter your Email");
                    }
                    //reg expression for email
                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                        .hasMatch(value)) {
                      return ("Please Enter the valid Email");
                    }
                    return null;
                  },
                  size: 15,
                  text: 'Email *',
                  fontWeight: FontWeight.w400,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 40, bottom: 13),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Password *',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
                Container(
                  width: 315,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4), //shadow color
                        blurRadius: 7, // shadow blur radius
                        offset:
                            const Offset(0, 4), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: PasswordField(
                    backgroundColor: Colors.white,
                    controller: password,
                    color: Colors.blue,
                    passwordConstraint: r'.*[@$#.*].*{8}',
                    inputDecoration: PasswordDecoration(
                        inputStyle: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 15)),
                    hintText: 'Password',
                    border: PasswordBorder(
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2,
                            color: Color.fromARGB(255, 203, 201, 201)),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2, color: AppColors.lightGreyColor),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      focusedErrorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(
                            width: 2, color: Color.fromARGB(255, 6, 135, 199)),
                      ),
                    ),
                    errorMessage:
                        'must contain special character either . * @ # \$',
                  ),
                ),
                // Field_Widget(
                //   type: TextInputType.visiblePassword,
                //   control: password,
                //   hint: "Password",
                //   valid: (value) {
                //     RegExp regex = RegExp(r'^.{6,}$');

                //     if (value!.isEmpty) {
                //       return ("Password is required for login");
                //     }
                //     if (!regex.hasMatch(value)) {
                //       return ("Enter Valid Password(Min. 6 Character)");
                //     }
                //     return null;
                //   },
                //   size: 15,
                //   text: 'Password *',
                //   fontWeight: FontWeight.w400,
                // ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 25),
                      child: Checkbox(
                        checkColor: Colors.white,
                        fillColor: MaterialStateProperty.resolveWith(getColor),
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    BigText(
                        text: "Remember me",
                        size: 15,
                        fontWeight: FontWeight.bold)
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                AppBtn(
                  fun: () {
                    if (_formKey.currentState!.validate()) signIn();
                  },
                  name: 'Sign in',
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Login Function
  static Future<User?> loginusingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        Fluttertoast.showToast(msg: "No user Found with this Email Address");
      }
    }
    return user;
  }

  Future<void> signIn() async {
    if (_formKey.currentState!.validate()) {
      User? user = await loginusingEmailPassword(
          email: email.text, password: password.text, context: context);

      if (user != null) {
        try {
          CollectionReference db =
              FirebaseFirestore.instance.collection('admins');
          FirebaseFirestore.instance
              .collection('admins')
              .doc(user.uid)
              .get()
              .then((value) {
            loggedInUser = AdminModel.fromMap(value.data());
            if (loggedInUser.uid == []) {
              Fluttertoast.showToast(msg: "Malpractice found");
            } else {
              Fluttertoast.showToast(msg: "Login Successful");
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const Home()));
            }
          });
        } on FirebaseAuthException catch (e) {
          print(e.message);
        }
      } else {
        // User not found, display an error message
        Fluttertoast.showToast(msg: "User does not exist");
      }
    }
  }
}
