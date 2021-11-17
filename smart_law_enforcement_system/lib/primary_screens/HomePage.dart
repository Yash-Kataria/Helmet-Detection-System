import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'Violators.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String LocationChoosed = "Select Location";
  bool showImage = true;

  List<String> RoadLocations = [];

  // Kormanagala , HSR Layout, MG Road, Shivaji Nagar

  final List<String> BangaloreLocations = [
    'assets/images/kormanagala.jpg',
    'assets/images/hsr_layout.jpg',
    'assets/images/mg_road.jpg',
    'assets/images/shivaji_nagar.jpg',
  ];

  // Bambolim Road, St. Inez Road, St. Thomas Road, TB Cunha Road

  final List<String> PanjimLocations = [
    'assets/images/bambolim_road.jpg',
    'assets/images/st_inez_road.jpg',
    'assets/images/st_thomas_road.jpg',
    'assets/images/tB_cunha_road.jpg',
  ];

  // VIP Road,  Ghoddod Road, Udhana Road, Sahara Road

  final List<String> SuratLocations = [
    'assets/images/vip_road.jpg',
    'assets/images/ghoddod_road.jpg',
    'assets/images/udhana_road.jpg',
    'assets/images/sahara_road.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromRGBO(245, 245, 245, 1),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          // padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 40),
              Center(
                child: GestureDetector(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(
                            FeatherIcons.mapPin,
                            color: Color.fromRGBO(91, 90, 98, 1),
                          ),
                        ),
                        WidgetSpan(child: SizedBox(width: 10)),
                        TextSpan(
                          text: LocationChoosed,
                          style: TextStyle(
                              color: Color.fromRGBO(91, 90, 98, 1),
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  onTap: () async {
                    final LocationSelection? LocName =
                        await _asyncSimpleDialog(context);
                    print("Selected Location Selection is $LocName");
                    String TempLocname = LocName.toString().split(".")[1];

                    setState(() {
                      LocationChoosed = TempLocname;
                      RoadLocations.clear();

                      if (TempLocname == "Bangalore")
                      {
                        setState(() {
                          showImage=false;
                        });

                        RoadLocations = List.from(BangaloreLocations);
                      }
                      else if (TempLocname == "Panjim")
                      {
                        setState(() {
                          showImage=false;
                        });

                        RoadLocations = List.from(PanjimLocations);
                      }
                      else if (TempLocname == "Surat")
                      {
                        setState(() {
                          showImage=false;
                        });

                        RoadLocations = List.from(SuratLocations);
                      }
                    });
                  },
                ),
              ),
              SizedBox(height: 50),
              Expanded(
                child: showImage
                    ? Center(
                        child: Image.asset(
                          'assets/images/homepageGIF3.gif',
                          fit: BoxFit.cover,
                          colorBlendMode: BlendMode.softLight,
                          gaplessPlayback: true,
                          height: 300,
                        ),
                      )
                    : GridView.count(
                        crossAxisCount: 2,
                        padding: EdgeInsets.all(20),
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 10,
                        children: RoadLocations.map((item) => GestureDetector(
                              onTap: () {
                                String Loc = item
                                    .toString()
                                    .substring(14)
                                    .split(".")[0]
                                    .replaceAll("_", " ")
                                    .toUpperCase();

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Violators(),
                                      settings: RouteSettings(
                                        arguments: Loc,
                                      )),
                                );
                              },
                              child: Card(
                                color: Colors.transparent,
                                elevation: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Color.fromRGBO(91, 90, 98, 1)),
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        image: AssetImage(item),
                                        fit: BoxFit.cover),
                                  ),
                                  child: Transform.translate(
                                    offset: Offset(0, 55),
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(top: 55, bottom: 55),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.zero,
                                            topRight: Radius.zero,
                                            bottomLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(20)),
                                        border: Border.all(
                                            color:
                                                Color.fromRGBO(91, 90, 98, 1)),
                                        color: Colors.white,
                                      ),
                                      child: Center(
                                        child: Text(
                                          item
                                              .toString()
                                              .substring(14)
                                              .split(".")[0]
                                              .replaceAll("_", " ")
                                              .toUpperCase(),
                                          style: TextStyle(
                                              color:
                                                  Color.fromRGBO(91, 90, 98, 1),
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )).toList(),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum LocationSelection { Bangalore, Panjim, Surat }

Future<LocationSelection?> _asyncSimpleDialog(BuildContext context) async {
  return await showDialog<LocationSelection>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text(
            'Select a Location',
            style: TextStyle(
                color: Color.fromRGBO(91, 90, 98, 1),
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, LocationSelection.Bangalore);
              },
              child: const Text(
                'Bangalore',
                style: TextStyle(
                  color: Color.fromRGBO(91, 90, 98, 1),
                  fontSize: 16,
                ),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, LocationSelection.Panjim);
              },
              child: const Text(
                'Panjim',
                style: TextStyle(
                  color: Color.fromRGBO(91, 90, 98, 1),
                  fontSize: 16,
                ),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, LocationSelection.Surat);
              },
              child: const Text(
                'Surat',
                style: TextStyle(
                  color: Color.fromRGBO(91, 90, 98, 1),
                  fontSize: 16,
                ),
              ),
            ),
          ],
        );
      });
}
