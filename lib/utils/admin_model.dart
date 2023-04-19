class AdminModel {
  String? uid;
  String? name;
  String? password;
  String? email;

  AdminModel({
    this.uid,
    this.name,
    this.password,
    this.email,
  });

  // recieving data from the server

  factory AdminModel.fromMap(map) {
    return AdminModel(
      uid: map['uid'],
      name: map['name'],
      password: map['password'],
      email: map['email'],
    );
  }

  //sending data to server

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'password': password,
      'email': email,
    };
  }
}
