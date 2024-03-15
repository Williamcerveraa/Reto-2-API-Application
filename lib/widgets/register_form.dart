import 'dart:convert';

import 'package:api_application/Api/authentication_api.dart';
import 'package:api_application/pages/home_page.dart';
import 'package:api_application/pages/login_page.dart';

import 'package:api_application/utils/dialogs.dart';
import 'package:api_application/utils/responsive.dart';
import 'package:api_application/widgets/input_text.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final Logger _logger = Logger();
  final GlobalKey<FormState> _formkey = GlobalKey();
  String _email = '';
  String _password = '';
  String _username = '';

  Future<void> _submit() async {
    final isOk = _formkey.currentState!.validate();
    // print('Form is Ok $isOk');
    if (isOk) {
      ProgressDialog.show(context);
      final authenticationAPI = GetIt.instance<AuthenticationAPI>();
      final response = await authenticationAPI.register(
        username: _username,
        email: _email,
        password: _password,
      );
      ProgressDialog.dissmiss(context);
      if (response.data != null) {
        _logger.i('register ok::: ${response.data}');
        Navigator.pushNamedAndRemoveUntil(
          context,
          HomePage.routeName,
          (_) => false,
        );
      } else {
        _logger.e('register error status code ${response.error!.statusCode}');
        _logger.e('register error message ${response.error!.message}');
        _logger.e('register error data ${response.error!.data}');
        String message = response.error!.message;
        if (response.error!.statusCode == -1) {
          message = 'Bad network';
        } else if (response.error!.statusCode == 409) {
          message =
              'Duplicated user ${jsonEncode(response.error!.data['duplicatedFields'])}';
        }

        Dialogs.alert(
          context,
          title: 'Error',
          description: message,
        );
      }
    }
  }

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
                label: 'User Name',
                fontSize: responsive.dp(responsive.isTablet ? 1.2 : 1.5),
                onChanged: (text) {
                  _username = text;
                },
                validator: (text) {
                  if (text!.trim().length < 5) {
                    return 'invalid username';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: responsive.dp(1),
              ),
              InputText(
                keyboardType: TextInputType.emailAddress,
                label: 'Email Address',
                fontSize: responsive.dp(responsive.isTablet ? 1.2 : 1.5),
                onChanged: (text) {
                  _email = text;
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
              InputText(
                keyboardType: TextInputType.emailAddress,
                label: 'Password',
                obscureText: true,
                fontSize: responsive.dp(responsive.isTablet ? 1.2 : 1.5),
                onChanged: (text) {
                  _password = text;
                },
                validator: (text) {
                  if (text!.trim().length < 4) {
                    return 'invalid password';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: FloatingActionButton.extended(
                    backgroundColor: Colors.pinkAccent,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    label: Text(
                      'Sign Up',
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
                    'Already have an account?',
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
                          LoginPage.routeName,
                        );
                      },
                      label: Text(
                        'Sign In',
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
                height: responsive.dp(5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
