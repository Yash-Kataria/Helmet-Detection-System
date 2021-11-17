import 'package:auto_route/auto_route.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:smart_law_enforcement_system/login_signup/bloc/theme_bloc.dart';
import 'package:smart_law_enforcement_system/login_signup/routes/router.gr.dart';
import 'package:smart_law_enforcement_system/login_signup/values/values.dart';

class UserProfile extends StatefulWidget {

  final String UserMobileNo;
  const UserProfile({Key? key,required this.UserMobileNo}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  TextEditingController Fullname = TextEditingController();
  TextEditingController EmailId = TextEditingController();
  TextEditingController MobileNumber = TextEditingController();
  TextEditingController PoliceStationName = TextEditingController();
  TextEditingController District = TextEditingController();
  TextEditingController State = TextEditingController();
  TextEditingController Pincode = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  String FinalUserMobileNo="";
  String UniqueRecordID = "";

  final FbDatabase=FirebaseDatabase.instance.reference();

  @override
  void initState() {
    super.initState();

    FinalUserMobileNo=widget.UserMobileNo.toString();

    FbDatabase.child("PoliceOfficerRegistration").orderByChild("MobileNo").equalTo(FinalUserMobileNo)
        .once().then((snapshot){

      if(snapshot.value == null)
      {
        print("--> Could not connect to the server.");

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Could not connect to the server.")));
      }
      else
      {
        Map<dynamic,dynamic> Records=snapshot.value;
        // print(Records.keys.toList()[0]);
        setState(() {
          UniqueRecordID=Records.keys.toList()[0];

          Fullname.text=Records.values.toList()[0]["OfficerFullName"].toString();
          EmailId.text=Records.values.toList()[0]["EmailID"].toString();
          MobileNumber.text=Records.values.toList()[0]["MobileNo"].toString();
          PoliceStationName.text=Records.values.toList()[0]["PoliceStationName"].toString();
          Pincode.text=Records.values.toList()[0]["PinCode"].toString();
          District.text=Records.values.toList()[0]["District"].toString();
          State.text=Records.values.toList()[0]["State"].toString();

        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      // backgroundColor: Color.fromRGBO(245, 245, 245, 1),
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 32),
        physics: BouncingScrollPhysics(),
        children: [
          const SizedBox(
            height: 15,
          ),
          Center(
            child: ClipOval(
              child: Material(
                color: Colors.black,
                child: Ink.image(
                  image: AssetImage("assets/images/police_badge.png"),
                  fit: BoxFit.fill,
                  width: 100,
                  height: 100,
                  // child: InkWell(onTap: onClicked),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          //Full Name
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Full Name
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  "Full Name",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              const SizedBox(height: 5),
              Container(
                height: 40,
                child: TextField(
                  controller: Fullname,
                  style: TextStyle(color: AppColors.pink, fontSize: 16.5),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    prefixIcon: Icon(
                      FeatherIcons.user,
                      color: AppColors.pink,
                      size: Sizes.ICON_SIZE_20,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              // Email Id
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  "Email ID",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              const SizedBox(height: 5),
              Container(
                height: 40,
                child: TextField(
                  controller: EmailId,
                  style: TextStyle(color: AppColors.pink, fontSize: 16.5),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    prefixIcon: Icon(
                      FeatherIcons.mail,
                      color: AppColors.pink,
                      size: Sizes.ICON_SIZE_20,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  readOnly: true,
                ),
              ),

              // Mobile No.
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  "Mobile Number",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              const SizedBox(height: 5),
              Container(
                height: 40,
                child: TextField(
                  controller: MobileNumber,
                  style: TextStyle(color: AppColors.pink, fontSize: 16.5),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    prefixIcon: Icon(
                      FeatherIcons.phone,
                      color: AppColors.pink,
                      size: Sizes.ICON_SIZE_20,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  readOnly: true,
                  keyboardType: TextInputType.phone,
                ),
              ),

              // Police Station Ward
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  "Police Station Ward",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              const SizedBox(height: 5),
              Container(
                height: 40,
                child: TextField(
                  controller: PoliceStationName,
                  style: TextStyle(color: AppColors.pink, fontSize: 16.5),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    prefixIcon: Icon(
                      FeatherIcons.shield,
                      color: AppColors.pink,
                      size: Sizes.ICON_SIZE_20,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              // Pin Code
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  "Pin Code",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              const SizedBox(height: 5),
              Container(
                height: 40,
                child: TextField(
                  controller: Pincode,
                  style: TextStyle(color: AppColors.pink, fontSize: 16.5),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    prefixIcon: Icon(
                      FeatherIcons.mapPin,
                      color: AppColors.pink,
                      size: Sizes.ICON_SIZE_20,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onChanged: (PinCodeValue)
                  {
                    GetCityAndState(PinCodeValue);
                  },
                ),
              ),

              // District
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  "District",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              const SizedBox(height: 5),
              Container(
                height: 40,
                child: TextField(
                  controller: District,
                  style: TextStyle(color: AppColors.pink, fontSize: 16.5),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    prefixIcon: Icon(
                      FeatherIcons.map,
                      color: AppColors.pink,
                      size: Sizes.ICON_SIZE_20,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              // State
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  "State",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              const SizedBox(height: 5),
              Container(
                height: 40,
                child: TextField(
                  controller: State,
                  style: TextStyle(color: AppColors.pink, fontSize: 16.5),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    prefixIcon: Icon(
                      FeatherIcons.map,
                      color: AppColors.pink,
                      size: Sizes.ICON_SIZE_20,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Save Profile
                  ElevatedButton.icon(
                    icon: Icon(FeatherIcons.download,size: 18,),
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      onPrimary: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                    label: Text("Save Profile"),
                    onPressed: () {
                      final UpdatePoliceOfficer=<String,dynamic>
                      {
                        'OfficerFullName' : Fullname.text,
                        'EmailID' : EmailId.text,
                        'MobileNo' : MobileNumber.text,
                        'PoliceStationName' : PoliceStationName.text,
                        'PinCode' : Pincode.text,
                        'District' : District.text,
                        'State' : State.text,
                      };

                      FbDatabase
                          .child("PoliceOfficerRegistration")
                          .child(UniqueRecordID)
                          .update(UpdatePoliceOfficer)
                          .then((_){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Profile Saved.")));

                      }).catchError((error) => print("Error Message : $error"));
                    },
                  ),

                  const SizedBox(width: 30,),
                  // Logout
                  ElevatedButton.icon(
                    icon: Icon(FeatherIcons.logOut,size: 18,),
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      onPrimary: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                    label: Text("Logout"),
                    onPressed: ()
                    {
                      ExtendedNavigator.root.push(Routes.loginScreen,
                          arguments: LoginScreenArguments(
                              themeBloc: ThemeBloc()));
                    },
                  ),
                ],
              ),

              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void GetCityAndState(String PinCode) async {
    String URL = "http://www.postalpincode.in/api/pincode/" + PinCode;

    http.Response _Response = await http.get(URL);

    if (_Response.statusCode != 200) {
      // return new Text('Could not connect to weather service.');
    } else {
      Map Data = jsonDecode(_Response.body);
      if (Data['Status'].toString() == "Success") {
        setState(() {
          print(Data);
          District.text = Data['PostOffice'][0]['District'];
          State.text = Data['PostOffice'][0]['State'];
        });
      } else {
        // return new Text('Weather service error: $json.');
        setState(() {
          District.text = "";
          State.text = "";
        });
      }
    }
  }
}
