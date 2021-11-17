// import 'dart:html';
import 'dart:typed_data';
import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_law_enforcement_system/login_signup/routes/router.gr.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dart:convert';

class Violators extends StatefulWidget {
  const Violators({Key? key}) : super(key: key);

  @override
  _ViolatorsState createState() => _ViolatorsState();
}

class _ViolatorsState extends State<Violators> with SingleTickerProviderStateMixin{

  String LocationChoosed = "Bangalore";

  PageController pageViewController = PageController(viewportFraction: 0.8);

  late Stream<dynamic> Slides;
  int Currentpage = 0;

  late TransformationController transformationController;
  late AnimationController animationController;
  Animation<Matrix4>? animation;

  @override
  void initState() {
    super.initState();

    transformationController=TransformationController();
    animationController=AnimationController(vsync: this,duration: Duration(milliseconds: 200))..addListener(() {transformationController.value = animation!.value;});
    // FirebaseFirestore.instance.collection("XYZ").add(
    //   {
    //     "Name":"Yash"
    //   }
    // );

    pageViewController.addListener(() {
      int Next = pageViewController.page!.round();
      if (Currentpage != Next) {
        setState(() {
          Currentpage = Next;
        });
      }
    });
  }

  @override
  void dispose() {

    transformationController.dispose();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    LocationChoosed = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: buildAppBar(),
      body: SafeArea(
        child: StreamBuilder(
          stream:FirebaseFirestore.instance.collection("Violators").
          where('Road',isEqualTo: LocationChoosed.toString()).
          where('Verified',isEqualTo: "No").
          where('Seen',isEqualTo: 'No').snapshots(),

          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {

            // if (snapshot.connectionState == ConnectionState.active)
            // {
            //   if(snapshot.data == null)
              if(snapshot.data?.docs.isEmpty ?? true)
              {
                return Container(
                  padding: EdgeInsets.all(15),
                  child: Center(
                      child: Text(
                        "No Violators Found In Current Location.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 2.0,
                          wordSpacing: 2.0,
                        ),
                      )
                  ),
                );
              }
              else if (snapshot.hasData)
              {
                // print("Data Coming Here");
                List SlideList = snapshot.data!.docs.toList();

                return PageView.builder(
                  controller: pageViewController,
                  itemCount: SlideList.length,
                  itemBuilder: (context, int CurrentIndex) {
                    bool Active = CurrentIndex == Currentpage;
                    return _buildStoryPage(SlideList[CurrentIndex], Active);
                  },
                );
              }
              else if (snapshot.hasError)
              {
                return Text("Error");
              }
              else {
                return Text("Not Available");
              }
            // }
            // else {
            //   return Scaffold(
            //     body: Center(
            //       child: CircularProgressIndicator(),
            //     ),
            //   );
            // }
          },
        ),
      ),
    );
  }

  _buildStoryPage(QueryDocumentSnapshot data, bool active) {
    // Animated Properties
    // final double blur = active ? 20 : 0;
    // final double offset = active ? 10 : 0;
    // final double top = active ? 40 : 80;

    final double blur = active ? 20 : 0;
    final double offset = active ? 10 : 0;
    final double top = active ? 40 : 40;

    Uint8List bytes = Base64Decoder()
        .convert(data['image'].toString().replaceAll(RegExp('\\s+'), ''));

    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      curve: Curves.easeOutQuint,
      margin: EdgeInsets.only(top: top, bottom: 10, right: 10, left: 10),
      child: Column(
        children: [
          Container(
            height: 250,
            width: 250,
            child: InteractiveViewer(
              // clipBehavior: Clip.none,
              transformationController: transformationController,
              minScale: 1,
              maxScale: 4,
              panEnabled: false,
              onInteractionEnd: (details)
              {
                animation=Matrix4Tween(
                  begin: transformationController.value,
                  end: Matrix4.identity(),
                ).animate(
                  CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
                );

                animationController.forward(from: 0);
              },
              child: AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.memory(
                    bytes,
                    gaplessPlayback: true,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 40, 10, 0),
                  child: Text(
                    'RC Plate No : ${data['RC_plate']}',
                    // '${data['RC_plate']} : ${data['Road']}' ,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF1A237E),
                      fontSize: 20,
                    ),
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 40, 10, 0),
                  child: Text(
                    'Date : ${data['Date and Time']}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF1A237E),
                      fontSize: 20,
                    ),
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            // margin: EdgeInsets.only(top: top, bottom: 50, right: 30),
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 40, 0, 0),
                  child: IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.checkCircle,
                      color: Color(0xFF00C853),
                      size: 40.0,
                    ),
                    onPressed: () {
                      FirebaseFirestore.instance.collection("Violators").doc(data.id.toString())
                          .update({"Verified":"Yes","Seen":"Yes"})
                          .then((value) => print("Violators Detail Updated"))
                          .catchError((error) => print("Failed to update violators detail: $error"));
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 40, 10, 0),
                  child: IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.timesCircle,
                      color: Color(0xFFE20808),
                      size: 40.0,
                    ),
                    onPressed: () {
                      FirebaseFirestore.instance.collection("Violators").doc(data.id.toString())
                          .update({"Verified":"No","Seen":"Yes"})
                          .then((value) => print("Violators Detail Updated"))
                          .catchError((error) => print("Failed to update violators detail: $error"));
                    },
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Color.fromRGBO(91, 90, 98, 1),
      leading: IconButton(
        tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        icon: const Icon(FeatherIcons.arrowLeft),
        onPressed: () {
          Navigator.pop(context);
          // ExtendedNavigator.root.push(Routes.Masterpage);
        },
      ),
      title: GestureDetector(
        onTap: () async {},
        child: Center(
          child: Row(
            children: [
              // SizedBox(width: 12),
              Center(
                child: IconButton(
                  tooltip: "Search",
                  icon: const Icon(
                    FeatherIcons.mapPin,
                    size: 20,
                  ),
                  onPressed: () {},
                ),
              ),
              Center(
                child: Text(
                  LocationChoosed,
                  style: TextStyle(
                      color: Color.fromRGBO(248, 248, 247, 1),
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
