import 'dart:io';
import 'package:chat_max/widgets/picker/user_image_packer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthForm extends StatefulWidget {
  final bool isLoading;

  final void Function(String email, String password, String name, File image,
      bool isLogin, BuildContext ctx) submit;

  const AuthForm({required this.submit, this.isLoading = false});

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  String? _password;
  String? _email;
  String? _name;
  var _isLogin = true;
  File? _userImageFile;

  final _formKey = GlobalKey<FormState>();

  void _trySubmit() {
    try {
      final isValid = _formKey.currentState!.validate();
      FocusScope.of(context).unfocus();
      if (_userImageFile == null && !_isLogin) {
        snackBar('please pick an Image');
      }
      if (isValid && _userImageFile != null) {
        _formKey.currentState?.save();
        widget.submit(_email!.toString().trim(), _password!.toString().trim(),
            _name!.trim(), _userImageFile ?? File('/'), _isLogin, context);
      }
    } on PlatformException catch (error) {
      snackBar(error.message.toString());
    } catch (err) {
      snackBar(err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Card(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!_isLogin) UserImagePicker(_imagePicker),
                    TextFormField(
                      key: const ValueKey('Email Address'),
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(labelText: 'Email address'),
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'please enter your valid Email';
                        }
                        return null;
                      },
                      onSaved: (value) => _email = value,
                    ),
                    if (!_isLogin)
                      TextFormField(
                        key: const ValueKey('User Name'),
                        decoration:
                            const InputDecoration(labelText: 'User Name'),
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty || value.length < 4) {
                            return 'enter your name';
                          }
                          return null;
                        },
                        onSaved: (value) => _name = value,
                      ),
                    TextFormField(
                        key: const ValueKey('password'),
                        decoration: const InputDecoration(labelText: 'Password'),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty || value.length < 6) {
                            return 'enter your password';
                          }
                          return null;
                        },
                        onSaved: (value) => _password = value),
                    const SizedBox(
                      height: 20,
                    ),
                    if (widget.isLoading) const CircularProgressIndicator(),
                    if (!widget.isLoading)
                      ElevatedButton(
                        onPressed: _trySubmit,
                        child: Text(_isLogin ? 'Login' : 'Sign Up'),
                      ),
                    if (!widget.isLoading)
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                        child: Text(
                            _isLogin ? 'Create New Account' : 'Lets Sign In'),
                      )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

   File _imagePicker(File image) {
  return  _userImageFile = image;
  }

  void snackBar(String content) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(content),
      backgroundColor: Theme.of(context).errorColor,
      duration: const Duration(seconds: 2),
    ));
    return;
  }
}
