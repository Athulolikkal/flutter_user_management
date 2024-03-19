class UserModel {
  final String? id;
  final String name;
  final String? password;
  final String email;

  UserModel({
    this.id,
    this.password,
    required this.name,
    required this.email,
  });

  static UserModel fromMap({required Map map}) => UserModel(
        id: map['id'],
        name: map['name'],
        password: map['password'],
        email: map['email'],
      );
}
