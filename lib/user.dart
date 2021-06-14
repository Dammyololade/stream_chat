class ChatUser {
  late String name;
  late String id;
  late String image;

  ChatUser({required this.name, required this.id, required this.image});
}

class UserProvider {
  static late ChatUser user;
}
