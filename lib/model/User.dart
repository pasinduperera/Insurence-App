class User {
  final String telephone;
  final String name;
  final String password;
  final String image;
  final String email;

  User({this.telephone, this.name, this.password, this.image, this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return new User(
      name: json['name'],
      telephone: json['telephone'],
      password: json['password'],
      image: json['image'],
      email: json['email'],
    );
  }
}
