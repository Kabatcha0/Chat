class FireStoreRegister {
  late String email;
  late String user;
  late String password;
  late String country;
  late String phone;
  late String uid;
  FireStoreRegister({
    required this.email,
    required this.user,
    required this.password,
    required this.country,
    required this.phone,
    required this.uid,
  });
  FireStoreRegister.fromJson(Map<String, dynamic> json) {
    email = json["email"];
    user = json["user"];
    password = json["password"];
    country = json["country"];
    phone = json["phone"];
    uid = json["uid"];
  }
  Map<String, dynamic> toMap() {
    return {
      "email": email,
      "user": user,
      "password": password,
      "country": country,
      "phone": phone,
      "uid": uid,
    };
  }
}
