import 'package:dummy_users/dummy_users_library.dart';

class UserScaffold extends StatelessWidget {
  final Users user;
  final Function() next;

  const UserScaffold({
    required this.user,
    required this.next,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${user.firstName} ${user.lastName} ${user.maidenName}"),
        actions: [
          OutlinedButton.icon(
            onPressed: next,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            icon: const Icon(
              Icons.arrow_right_alt,
            ),
            label: const Text("Next"),
          )
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 51, 5, 115),
              Color.fromARGB(255, 25, 3, 56),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Image.network(user.image!),
        ),
      ),
    );
  }
}
