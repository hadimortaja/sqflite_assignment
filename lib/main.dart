import 'package:flutter/material.dart';

import 'TabBarPage.dart';
import 'constants.dart';
import 'db/db_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
      DBHelper.myDatabase.initDb();
   getAllTask().whenComplete(() =>
       runApp(MyApp())
   );

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TabBarPage(),
    );
  }
}
