import 'package:dummy_users/dummy_users_library.dart';

class DummyUserUI extends StatefulWidget {
  const DummyUserUI({super.key});

  @override
  State<StatefulWidget> createState() => _DummyUserUIState();
}

class _DummyUserUIState extends State<DummyUserUI> {
  int userIndex = 0;
  List<Users?>? users;
  String requestState = 'loading';

  final String baseUrl = 'https://dummyjson.com';

  Future<void> makeRequest() async {
    try {
      RequestMaker<Users?> request = RequestMaker<Users?>(
        baseUrl,
        convert: Users.convert(),
        convertList: Users.convertList(),
      );

      users = await request.get("/users");
      if (users != null) {
        if (users![userIndex] != null) {
          setState(() {
            requestState = "user";
          });
        }
      }
    } on HttpUrlException catch (e) {
      requestState = e.message;
    } on JsonDecodeException catch (e) {
      requestState = e.message;
    } on HttpStatusCodeException catch (e) {
      requestState = e.message;
    } on HttpRequstException catch (e) {
      requestState = e.message;
    }
  }

  @override
  void initState() {
    super.initState();
    makeRequest();
  }

  void nextUser() {
    setState(() {
      userIndex++;
      if (userIndex == users!.length) {
        userIndex = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget screenWidget = const RequestStateScaffold(
      title: "Loading...",
      info: "Loading...",
    );
    if (requestState == "user") {
      screenWidget = UserScaffold(
        user: users![userIndex]!,
        next: nextUser,
      );
    } else if (requestState == 'loading') {
      screenWidget = const RequestStateScaffold(
        title: "Loading...",
        info: "Loading...",
      );
    } else {
      screenWidget = RequestStateScaffold(
        title: "Error",
        info: requestState,
      );
    }
    return MaterialApp(
      title: "Dummy Users",
      debugShowCheckedModeBanner: false,
      home: screenWidget,
    );
  }
}
