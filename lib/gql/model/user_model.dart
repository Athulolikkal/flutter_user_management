class UserModel {
  final String? id;
  final String name;
  final String password;
  final String username;

  UserModel({
    this.id,
    required this.name,
    required this.password,
    required this.username,
  });

  static UserModel fromMap({required Map map}) => UserModel(
        id: map['id'],
        name: map['name'],
        password: map['password'],
        username: map['username'],
      );
}
