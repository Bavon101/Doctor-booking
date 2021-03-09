import 'dart:convert';

import 'package:flutter/cupertino.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  final bool doctor;
  final String userId;
  final String password;
  final String name;
  final String data;
  User(
      {@required this.doctor,
      @required this.password,
      @required this.userId,
     @required this.name,
     this.data
     });

  factory User.fromJson(Map<String, dynamic> json) => User(
        password: json['pass'],
        doctor: json['type'],
        userId: json['id'],
        name: json['name'],
        data: json['data']
      );

  Map<String, dynamic> toJson() =>
      {'pass': this.password, 'type': this.doctor, 'id': this.userId,'data':this.data,'name':this.name};
}
