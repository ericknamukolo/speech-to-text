import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:speech_to_text_conversion/constants.dart';
import 'package:speech_to_text_conversion/widgets/error_message.dart';
import 'package:speech_to_text_conversion/widgets/input_text_field.dart';
import 'package:speech_to_text_conversion/widgets/main_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../password_validator.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
        final newUser = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        if (newUser != null) {
          Navigator.pop(context);
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sign Up',
                          style: kTextStytle.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                          ),
                        ),
                        Text(
                          'Make an account',
                          style: kTextStytle.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Hero(
                      tag: 'icon',
                      child: Icon(
                        FontAwesomeIcons.microphone,
                        size: 100.0,
                        color: Color(0xff48C9B0),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: 60,
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
                  text: 'Sign Up',
                  click: () {
                    validate();
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Alread have an account?',
                  style: kTextStytle.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Log In',
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
