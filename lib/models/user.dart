import 'package:agora_rtc_engine/rtc_engine.dart';

class UserModel{
  static const EMAIL = "name";
  static const PASSWORD = "passWord";
  // static const ClientRole = "role";

  // bool? role;
  String? email;
  String? passWord;

  UserModel(this.email,this.passWord);

  UserModel.fromMap(Map<String,dynamic> data){
    email= data[EMAIL];
  }
}

