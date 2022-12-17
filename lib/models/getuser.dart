class GetUser {
  late String uid;
  GetUser.fromJson(Map<String, dynamic> json) {
    uid = json["uid"];
  }
}
