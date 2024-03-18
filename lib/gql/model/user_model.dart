class UserModel {
  final String? id;
  final String name;
  final String password;
  final String userName;

  UserModel({
    this.id,
    required this.name,
    required this.password,
    required this.userName,
  });

  static UserModel fromMap({required Map map}) => UserModel(
        id: map['id'],
        name: map['name'],
        password: map['password'],
        userName: map['userName'],
      );
}
