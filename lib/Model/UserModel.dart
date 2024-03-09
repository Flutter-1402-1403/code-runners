class UserModel {
  String? user_name;
  String? email;
  String? password;
  UserModel(this.user_name, this.password);
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{'user_name': user_name, 'password': password};
    return map;
  }

  UserModel.fromMap(Map<String, dynamic> map) {
    user_name = map['user_name'];
    email = map['email'];
    password = map['password'];
  }
}
