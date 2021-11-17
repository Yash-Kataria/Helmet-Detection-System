import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:smart_law_enforcement_system/login_signup/routes/router.gr.dart';
import 'package:smart_law_enforcement_system/login_signup/values/values.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  final List<String> DevelopersImages = [
    'assets/images/lynford.jpeg',
    'assets/images/sumi.jpeg',
    'assets/images/yash.jpg',
  ];

  final List<String> DevelopersNames = [
    'Lynford V. D\'souza',
    'Sumi Thomas',
    'Yash H. Kataria',
  ];

  final List<String> DevelopersDescription = [
    'Researcher',
    'Back-End Developer',
    'Front-End Developer',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SizedBox(height: 15,),
        Center(
          child: Ink.image(
            image: AssetImage("assets/images/aboutus.jpg"),
            fit: BoxFit.cover,
            width: 170,
            height: 170,
          ),
        ),
        ListView.builder(
          physics: BouncingScrollPhysics(),
          itemBuilder: (BuildContext, index) {
            return Card(
              elevation: 8,
              margin: EdgeInsets.all(10),
              color: AppColors.whiteShade2,
              shadowColor: AppColors.blackShade1,
              child: ListTile(
                leading: CircleAvatar(
                  radius: 25.0,
                  backgroundImage: AssetImage(DevelopersImages[index]),
                ),
                title: Text('${DevelopersNames[index]}',style: TextStyle(color: Colors.black)),
                subtitle: Text(
                  '${DevelopersDescription[index]}',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            );
          },
          itemCount: 3,
          shrinkWrap: true,
          padding: EdgeInsets.all(20),
          scrollDirection: Axis.vertical,
        ),
      ],
    )
    );
  }
}
