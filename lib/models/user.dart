class User {
  final String name;
  final String image;
  const User({required this.name, required this.image});
}

class UserList {
  static List<User> users = const [
    User(
        name: "Perry Cooper",
        image: "https://randomuser.me/api/portraits/men/33.jpg"),
    User(
        name: "Audrey Thomas",
        image: "https://randomuser.me/api/portraits/women/71.jpg"),
    User(
        name: "Cody Stevens",
        image: "https://randomuser.me/api/portraits/men/11.jpg"),
    User(
        name: "Eloides Mendes",
        image: "https://randomuser.me/api/portraits/women/36.jpg"),
    User(
        name: "Albert Hayes",
        image: "https://randomuser.me/api/portraits/men/47.jpg"),
    User(
        name: "Naomi Chevalier",
        image: "https://randomuser.me/api/portraits/women/76.jpg"),
    User(
        name: "Dwight Roberts",
        image: "https://randomuser.me/api/portraits/men/36.jpg"),
    User(
        name: "Anna Chambers",
        image: "https://randomuser.me/api/portraits/women/49.jpg"),
  ];
}
