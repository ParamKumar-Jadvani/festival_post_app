import 'package:festival_post_app/routes/app_routes.dart';
import 'package:festival_post_app/utils/my_fonts.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Festival Post App',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        fontFamily: MyFonts.Archivo.name,
      ),
      routes: AppRoutes.routes,
    );
  }
}
