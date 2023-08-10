import 'package:dummy_users/dummy_users_library.dart';

class RequestStateScaffold extends StatelessWidget {
  final String info;
  final String title;

  const RequestStateScaffold({
    required this.title,
    required this.info,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
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
          child: Text(
            info,
          ),
        ),
      ),
    );
  }
}
