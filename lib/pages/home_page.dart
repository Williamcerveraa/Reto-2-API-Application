import 'package:api_application/Api/account_api.dart';
import 'package:api_application/data/authentication_client.dart';
import 'package:api_application/models/user.dart';
import 'package:api_application/pages/login_page.dart';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class HomePage extends StatefulWidget {
  static const routeName = 'home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthenticationClient _authenticationClient =
      GetIt.instance<AuthenticationClient>();
  final AccountAPI _accountAPI = GetIt.instance<AccountAPI>();
  User? _user;

  Future<void> _signOut() async {
    await _authenticationClient.signOut();
    Navigator.pushNamedAndRemoveUntil(
      context,
      LoginPage.routeName,
      (route) => false,
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUser();
    });
  }

  Future<void> _loadUser() async {
    final response = await _accountAPI.getUserInfo();
    if (response.data != null) {
      _user = response.data!;
      setState(() {});
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker imagePicker = ImagePicker();

    final image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final bytes = await image.readAsBytes();
      final filename = path.basename(image.path);
      final response = await _accountAPI.updateAvatar(bytes, filename);
      if (response.data != null) {
        _user = _user!.copyWith(avatar: response.data);
        setState(() {});
        // final String imageUrl = 'http://192.168.0.98:9000${response.data}';
        // Logs.p.i(imageUrl);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_user == null) const CircularProgressIndicator(),
            if (_user != null)
              Column(
                children: [
                  ClipOval(
                    child: Image.network(
                      "http://192.168.0.98:9000${_user!.avatar}",
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(_user!.id),
                  Text(_user!.email),
                  Text(_user!.username),
                  Text(_user!.createdAt.toIso8601String()),
                ],
              ),
            const SizedBox(
              height: 30,
            ),
            TextButton(
              onPressed: _pickImage,
              child: const Text('Update avatar'),
            ),
            TextButton(
              onPressed: _signOut,
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
