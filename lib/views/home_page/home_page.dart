import 'package:festival_post_app/routes/app_routes.dart';
import 'package:festival_post_app/utils/festival_post_data.dart';
import 'package:festival_post_app/utils/my_fonts.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Festivals",
          style: TextStyle(
            fontFamily: MyFonts.Archivo.name,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.deepOrange,
        elevation: 4,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
        itemCount: festivalPostDataList.length,
        itemBuilder: (context, index) {
          final festival = festivalPostDataList[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(AppRoutes.detailPage, arguments: festival);
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              elevation: 6,
              shadowColor: Colors.deepOrangeAccent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 160,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                      image: DecorationImage(
                        image: AssetImage(festival['thumbnail']),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      festival['name'],
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w600,
                        fontFamily: MyFonts.Archivo.name,
                        color: Colors.deepOrange,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 8.0),
                    child: Text(
                      "Slogan: ${festival['slogan']}",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: MyFonts.Archivo.name,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 12),
      ),
    );
  }
}
