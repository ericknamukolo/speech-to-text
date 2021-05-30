import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:speech_to_text_conversion/constants.dart';
import 'package:speech_to_text_conversion/password_validator.dart';
import 'package:speech_to_text_conversion/screens/home_screen.dart';
import 'package:speech_to_text_conversion/screens/sign_up.dart';
import 'package:speech_to_text_conversion/widgets/error_message.dart';
import 'package:speech_to_text_conversion/widgets/input_text_field.dart';
import 'package:speech_to_text_conversion/widgets/main_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool isHidden = true;
  bool showSpinner = false;
  String error = '';

  GlobalKey<FormState> key = GlobalKey<FormState>();

  void validate() async {
    if (key.currentState.validate()) {
      setState(() {
        showSpinner = true;
      });
      try {
        final existingUser = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        if (existingUser != null) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        }
        setState(() {
          showSpinner = false;
        });
      } catch (e) {
        setState(() {
          showSpinner = false;
          error = e.message.toString();
        });
        print(e);
      }
    } else {
      print('error');
    }
  }

  PasswordValidator pwv = PasswordValidator();
  String passwordValidator(val) {
    return pwv.passwordValidator(val);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 50, left: 20, right: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Hero(
                      tag: 'icon',
                      child: Icon(
                        FontAwesomeIcons.microphone,
                        size: 100.0,
                        color: Color(0xff48C9B0),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Log In',
                          style: kTextStytle.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                          ),
                        ),
                        Text(
                          'Welcome Back',
                          style: kTextStytle.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: 40,
                  ),
                  child: Form(
                    autovalidateMode: AutovalidateMode.always,
                    key: key,
                    child: Column(
                      children: [
                        InputTextField(
                          obs: false,
                          type: TextInputType.emailAddress,
                          hint: 'Email',
                          icon: Icons.email,
                          input: (val) {
                            email = val;
                          },
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: 'An email address is required'),
                            EmailValidator(errorText: 'Enter a valid email'),
                          ]),
                        ),
                        SizedBox(height: 20),
                        InputTextField(
                          eyeClick: () {
                            setState(() {
                              isHidden = !isHidden;
                            });
                          },
                          eye: isHidden
                              ? FontAwesomeIcons.eyeSlash
                              : FontAwesomeIcons.eye,
                          obs: isHidden,
                          type: TextInputType.visiblePassword,
                          hint: 'Password',
                          icon: Icons.lock,
                          input: (val) {
                            password = val;
                          },
                          validator: passwordValidator,
                        ),
                      ],
                    ),
                  ),
                ),
                ErrorMessage(error: error),
                MainButton(
                  text: 'Log In',
                  click: () {
                    validate();
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Don\'t have an account?',
                  style: kTextStytle.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpScreen()));
                  },
                  child: Text(
                    'Sign Up',
                    style: kTextStytle.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color(0xff2980B9),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
