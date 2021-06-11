import 'dart:io';

import 'package:equatable/equatable.dart';

 class AuthModel extends Equatable {
  final String email;
  final String name;
  final String password;
  final bool isLogin ;
  final File image;

  const AuthModel(this.email, this.name, this.password, this.image, this.isLogin);

  @override
  List<Object?> get props => [email,name,password,image,isLogin];
}
