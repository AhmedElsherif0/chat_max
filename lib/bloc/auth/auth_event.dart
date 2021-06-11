part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {
  const AuthEvent();
}
class LoginEvent extends AuthEvent{
  final String? email;
  final String? password;


  const LoginEvent(this.email, this.password);

  @override
  List<Object?> get props => [email,password];
}

class RegisterEvent extends AuthEvent{
  final String? email;
  final String? name;
  final String? password;
  final File? image;

  const RegisterEvent( this.email, this.name,this.password, this.image,);
  @override
  List<Object?> get props => [email,name,password,image];
}

