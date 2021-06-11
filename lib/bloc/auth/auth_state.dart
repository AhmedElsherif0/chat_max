part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {}

class AuthInitial extends AuthState {
   AuthInitial();

   @override
   List<Object> get props => [];
}

class AuthLoading extends AuthState {
  AuthLoading();

  @override
  List<Object> get props => [];
}

class AuthSuccess extends AuthState {
  final AuthModel authModel;

  AuthSuccess(this.authModel);

  @override
  List<Object> get props => [authModel];

}
class AuthError extends AuthState {
  final String error;
  AuthError(this.error);

  @override
  List<Object?> get props => [error];
}

