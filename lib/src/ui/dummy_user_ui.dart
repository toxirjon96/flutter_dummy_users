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

  void changeRequestState(String state) {
    setState(() {
      requestState = state;
    });
  }

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
            changeRequestState("user");
          });
        }
      }
    } on HttpUrlException catch (e) {
      changeRequestState(e.message);
    } on JsonDecodeException catch (e) {
      changeRequestState(e.message);
    } on HttpStatusCodeException catch (e) {
      changeRequestState(e.message);
    } on HttpRequstException catch (e) {
      changeRequestState(e.message);
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
    Widget? screenWidget;

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
