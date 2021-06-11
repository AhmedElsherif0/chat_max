import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chat_max/model/auth_model.dart';
import 'package:chat_max/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    yield AuthLoading();
    if (event is LoginEvent) {
      try {
         final authLogin = await AuthRepository()
            .userLogin(event.email ?? '@gmail.com', event.password ?? '');
        yield AuthSuccess(authLogin);
      // ignore: avoid_catching_errors
      } on NetworkError {
        yield AuthError('Network an Occurred Error');
      }
    } else if (event is RegisterEvent) {
      try {
        final authRegister = await AuthRepository().userRegister(
            event.email ?? '@gmail.com',
            event.name ?? 'Unknown',
            event.password ?? '',
            event.image ?? File('/'));
        yield AuthSuccess(authRegister);
      // ignore: avoid_catching_errors
      } on NetworkError {
        yield AuthError('Network an Occurred Error');
      }
    }
  }
}
