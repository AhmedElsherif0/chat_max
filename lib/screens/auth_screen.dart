import 'dart:io';

import 'package:chat_max/bloc/auth/auth_bloc.dart';
import 'package:chat_max/screens/chat_screen.dart';
import 'package:chat_max/widgets/auth/auth_widget.dart';
import 'package:chat_max/widgets/custom/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var _isLoading = false;

  void _submitAuthForm(String email, String password, String name, File image,
      bool isLogin, BuildContext ctx) async {
    try {
      _isLoadingMounted(true);
      final blocProvider = BlocProvider.of<AuthBloc>(context);

      if (isLogin) {
        await blocProvider.authRepository.userLogin(email, password);
      } else {
        await blocProvider.authRepository
            .userRegister(email, name, password, image);
      }
    } on PlatformException catch (error) {
      var message = 'An error occurred';
      if (error.message != null) {
        message = error.message ?? 'an error occurred';
      }
      print(message.toString());
    } catch (error) {
      print(error.toString());
    }
    _isLoadingMounted(false);
  }

  @override
  Widget build(BuildContext context) {
    final blocProvider = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              return customSnackBar(context, 'content', state.error.toString());
            }
          },
          builder: (context, state) {
            return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
              if (state is AuthInitial) {
                return AuthForm(
                  submit: _submitAuthForm,
                  isLoading: _isLoading,
                );
              } else if (state is AuthLoading) {
                return const CustomLoading();
              } else if (state is AuthSuccess) {
                if (state.authModel.isLogin) {
                  blocProvider.authRepository.userLogin(
                      state.authModel.email, state.authModel.password);
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => ChatScreen()));
                } else if (!state.authModel.isLogin) {
                  blocProvider.authRepository.userRegister(
                      state.authModel.email,
                      state.authModel.name,
                      state.authModel.password,
                      state.authModel.image);
                }
              }
              return AuthForm(
                submit: _submitAuthForm,
                isLoading: _isLoading,
              );
            });
          },
        ));

    /* AuthForm(
        submit: _submitAuthForm,
        isLoading: _isLoading,
      ),*/
  }

  bool _isLoadingMounted(bool value) {
    if (this.mounted) {
      setState(() {
        _isLoading = value;
      });
    }
    return false;
  }

  void customSnackBar(BuildContext ctx, String content, String logError) {
    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        backgroundColor: Colors.pink[300],
        content: Text(
          content,
          textAlign: TextAlign.center,
        ),
        duration: const Duration(seconds: 3)));
    print(logError);
  }
}
