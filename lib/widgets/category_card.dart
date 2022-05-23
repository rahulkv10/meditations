import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meditation/pages/subCategories.dart';
import 'package:meditation/utils/app_colors.dart';

//import 'package:meditation_app/constants.dart';

class CategoryCard extends StatelessWidget {
  final String svgSrc;
  final String title;
  final String des;
  final Function press;
  final String id;
  // ignore: use_key_in_widget_constructors
  const CategoryCard({
    required this.svgSrc,
    required this.title,
    required this.des,
    required this.press,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Container(
        margin: const EdgeInsets.all(3.5),
        decoration: BoxDecoration(
          color:  AppColors.darkAppcolor,
          //Color.fromARGB(255, 132, 182, 127),
                                       // .withOpacity(0.5),
          //borderRadius: BorderRadius.circular(50),
          shape: BoxShape.circle,
          boxShadow:const  [
            BoxShadow(
                color: Colors.grey,
                offset: Offset(0, 5),
                blurRadius: 10,
                spreadRadius: 1),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return MeditationList(
                    title: title,
                    description: des,
                    thumbnail: svgSrc,
                    id: id,
                  );
                }),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 5,
                  ),
                  // SvgPicture.asset(svgSrc),
                  SizedBox(
                    height: size.height*0.1,
                    width:size.width*0.18,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        svgSrc,
                        fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
            return Container(
              
              alignment: Alignment.center,
              child: Image.asset('assets/images/placeholder.jpg',fit: BoxFit.contain,)
            );
          },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style:const  TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 25, 28, 53),
                        fontSize: 12),
                  ),
                  // Text(
                  //   des,
                  //   textAlign: TextAlign.center,
                  //   style: TextStyle(fontSize: 13),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
