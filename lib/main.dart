import 'package:flutter/material.dart';
import 'package:last_test/models/lanuage_model.dart';
import 'package:last_test/pages/translet_page.dart';
import 'package:last_test/utils/connection_manager.dart';
import 'package:last_test/utils/response.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  List<Language> languages= [];
  bool isLoading = false;

  void getData() async {
    try {
      setState(() {
        isLoading = true;
      });
      Response result = await getLanguageFromApi();
      if (result.statusCode == 200) {
        languages = result.body;
        //print(languages.length);
        //print(languages);
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    getData();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Google Translate", style:TextStyle(fontSize: 26,fontWeight: FontWeight.bold) ,)),
      body: TranslatePage(languages: languages,),

    );
  }
}
