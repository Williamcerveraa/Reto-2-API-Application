import 'package:api_application/utils/responsive.dart';
import 'package:api_application/widgets/input_text.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  _submit() {
    final isOk = _formkey.currentState!.validate();
    // print('Form is Ok $isOk');
    if (isOk) {}
  }

  final GlobalKey<FormState> _formkey = GlobalKey();
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Positioned(
      bottom: 30,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: responsive.isTablet ? 430 : 330,
        ),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              InputText(
                keyboardType: TextInputType.emailAddress,
                label: 'Email Address',
                fontSize: responsive.dp(responsive.isTablet ? 1.2 : 1.5),
                onChanged: (text) {
                  email = text;
                },
                validator: (text) {
                  if (!text!.contains('@')) {
                    return 'invalid email';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: responsive.dp(1),
              ),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black12,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: InputText(
                        label: 'Password',
                        obscureText: true,
                        borderEnabled: false,
                        fontSize:
                            responsive.dp(responsive.isTablet ? 1.2 : 1.5),
                        onChanged: (text) {
                          password = text;
                        },
                        validator: (text) {
                          if (text!.trim().isEmpty) {
                            return 'invalid password';
                          }
                          return null;
                        },
                      ),
                    ),
                    FloatingActionButton.extended(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      elevation: 0,
                      label: Text(
                        'Forgot password',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize:
                              responsive.dp(responsive.isTablet ? 1.2 : 1.5),
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: responsive.dp(5),
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: FloatingActionButton.extended(
                    backgroundColor: Colors.pinkAccent,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    label: Text(
                      'Sign In',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize:
                            responsive.dp(responsive.isTablet ? 1.2 : 1.5),
                      ),
                    ),
                    onPressed: _submit,
                  ),
                ),
              ),
              SizedBox(
                height: responsive.dp(2),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'New to Friendly Desi?',
                    style: TextStyle(
                      fontSize: responsive.dp(responsive.isTablet ? 1.2 : 1.5),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: FloatingActionButton.extended(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.pinkAccent,
                      elevation: 0,
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          'register',
                        );
                      },
                      label: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize:
                              responsive.dp(responsive.isTablet ? 1.2 : 1.5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: responsive.dp(10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
