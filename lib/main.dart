import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart' as Trans;
import 'package:resep/detail_page.dart';
import 'package:resep/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Digunakan untuk memaksa potrait
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(App());
}

final ThemeData appThemeData = ThemeData(
  scaffoldBackgroundColor: Color(0xFFF8F8F8),
  primaryColor: Colors.blueAccent,
  primarySwatch: Colors.blue,
  appBarTheme: AppBarTheme(color: Colors.transparent, elevation: 0),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  fontFamily: 'Roboto',
  textTheme: TextTheme(
    headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
  ),
);

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: "Resep 100",
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        theme: appThemeData,
        defaultTransition: Trans.Transition.native,
        getPages: [
          GetPage(name: "/", page: () => HomePage()),
          GetPage(name: "/detail", page: () => DetailPage()),
        ]);
  }
}
