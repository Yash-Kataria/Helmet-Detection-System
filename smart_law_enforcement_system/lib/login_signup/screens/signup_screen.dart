import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_law_enforcement_system/login_signup/bloc/theme_bloc.dart';
import 'package:smart_law_enforcement_system/login_signup/themes/login_signup_design_theme.dart';
import 'package:smart_law_enforcement_system/login_signup/values/values.dart';
import 'package:smart_law_enforcement_system/login_signup/widgets/custom_shape_clippers.dart';
import 'package:smart_law_enforcement_system/login_signup/routes/router.dart';
import 'package:smart_law_enforcement_system/login_signup/routes/router.gr.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUpScreen extends StatefulWidget {

  SignUpScreen({required this.themeBloc});

  final ThemeBloc themeBloc;

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey cardKey = GlobalKey();
  double buttonOffset = 40.0;

  late ThemeBloc _themeBloc;

  final UserFromMobileScreen=FirebaseAuth.instance;

  TextEditingController Fullname=TextEditingController();
  TextEditingController EmailId=TextEditingController();
  TextEditingController MobileNumber=TextEditingController();
  TextEditingController PoliceStationName=TextEditingController();
  TextEditingController District=TextEditingController();
  TextEditingController State=TextEditingController();
  TextEditingController Pincode=TextEditingController();
  TextEditingController Password=TextEditingController();

  late String FetchedEmailId ="";
  late String FetchedUsername="";
  late String FetchedMobileNumber="";

  final FbDatabase=FirebaseDatabase.instance.reference();

  @override
  void initState() {
    super.initState();
    _themeBloc = ThemeBloc();

    LoadAllPreferences();

    widget.themeBloc.selectedTheme.add(_buildLightTheme());
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      // executes after build
      getSizeOfCard();
    });
  }

  void LoadAllPreferences() async
  {
    SharedPreferences Preference = await SharedPreferences.getInstance();

  // Try reading data from the counter key. If it doesn't exist, return null.
    setState(()
    {
      FetchedEmailId = Preference.getString('EmailId') ?? "";
      FetchedUsername = Preference.getString('Username') ?? "";
      FetchedMobileNumber = Preference.getString('MobileNumber') ?? "";

      // print("Email id : "+FetchedEmailId + " Username : "+FetchedUsername+" Mobile Number : "+FetchedMobileNumber);
    });
  }

  CurrentTheme _buildLightTheme() {
    return CurrentTheme('light', LoginSignUpDesignTheme.lightThemeData);
  }
  void getSizeOfCard() {
    final keyContext = cardKey.currentContext;
    if (keyContext != null) {
      final box = keyContext.findRenderObject() as RenderBox;
      setState(() {
        buttonOffset = (box.size.height / 2) - 30;
      });
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey=GlobalKey();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var heightOfScreen = MediaQuery.of(context).size.height;
    var widthOfScreen = MediaQuery.of(context).size.width;

    Fullname.text = FetchedUsername;
    EmailId.text = FetchedEmailId;
    MobileNumber.text=FetchedMobileNumber;

    return Scaffold(
      key: _scaffoldKey,
        body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Stack(
            children: <Widget>[
              Positioned(
                left: 0,
                top: 0,
                right: 0,
                child: ClipPath(
                  clipper: CustomLoginShapeClipper4(),
                  child: Container(
                    height: heightOfScreen,
                    decoration: BoxDecoration(color: AppColors.orangeShade2),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                right: 0,
                child: ClipPath(
                  clipper: CustomLoginShapeClipper5(),
                  child: Container(
                    height: heightOfScreen,
                    decoration: BoxDecoration(
                      gradient: Gradients.curvesGradient1,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                right: 0,
                child: ClipPath(
                  clipper: CustomLoginShapeClipper6(),
                  child: Container(
                    height: heightOfScreen,
                    decoration: BoxDecoration(
                      color: AppColors.lighterBlue,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                right: 0,
                child: ClipPath(
                  clipper: CustomLoginShapeClipper3(),
                  child: Container(
                    height: heightOfScreen,
                    decoration: BoxDecoration(
                      gradient: Gradients.curvesGradient2,
                    ),
                  ),
                ),
              ),
              Positioned(
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: ListView(
                              children: <Widget>[
                                Container(
                                  height: heightOfScreen * 0.05,
                                ),
                                Text(
                                  StringConst.REGISTER,
                                  textAlign: TextAlign.center,
                                  style: textTheme.headline!.copyWith(
                                    color: AppColors.lightBlueShade5,
                                  ),
                                ),
                                SizedBox(height: heightOfScreen * 0.02),
                                _buildForm(context: context),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

            ],
          ),
        ),
      );
  }

  Widget _buildForm({required BuildContext context}) {
    var widthOfScreen = MediaQuery.of(context).size.width;

    return Container(
      width: widthOfScreen,
      child: Stack(
        children: <Widget>[
          Container(
            width: widthOfScreen * 0.9,
            child: Card(
              key: cardKey,
              elevation: Sizes.ELEVATION_4,
              margin: const EdgeInsets.only(
                left: Sizes.MARGIN_0,
                top: Sizes.MARGIN_8,
                bottom: Sizes.MARGIN_8,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(100.0),
                  bottomRight: Radius.circular(100.0),
                ),
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: Sizes.MARGIN_12),
                child: Column(
                  children: <Widget>[
                    //User Name
                    TextFormField(
                      controller: Fullname,
                      decoration: InputDecoration(
                          labelText: "Full Name",
                          hintText: "Yash Kataria",
                          enabledBorder: Borders.noBorder,
                          prefixIcon:Icon(
                            FeatherIcons.user,
                            color: AppColors.blackShade1,
                            size: Sizes.ICON_SIZE_20,
                          ),
                          alignLabelWithHint: true,
                          contentPadding: EdgeInsets.only(top: Sizes.PADDING_4),
                          border: Borders.noBorder,
                          focusedBorder: Borders.noBorder
                      ),
                      style: Styles.customTextStyle(color: AppColors.pink),
                      onChanged: (FullnameValue)
                      {
                          FetchedUsername=FullnameValue;
                      },

                    ),
                    Divider(color: AppColors.grey, height: Sizes.HEIGHT_16),

                    //Email Address
                    TextFormField(
                      controller: EmailId,
                      decoration: InputDecoration(
                          labelText: "Email ID",
                          hintText: "abc@gmail.com",
                          enabledBorder: Borders.noBorder,
                          prefixIcon:Icon(
                            FeatherIcons.mail,
                            color: AppColors.blackShade1,
                            size: Sizes.ICON_SIZE_20,
                          ),
                          alignLabelWithHint: true,
                          contentPadding: EdgeInsets.only(top: Sizes.PADDING_4),
                          border: Borders.noBorder,
                          focusedBorder: Borders.noBorder
                      ),
                      style: Styles.customTextStyle(color: AppColors.pink),
                      // enabled: false,
                      readOnly: true,
                    ),
                    Divider(color: AppColors.grey, height: Sizes.HEIGHT_16),

                    //Phone Number
                    TextFormField(
                      controller: MobileNumber,
                      decoration: InputDecoration(
                          labelText: "Mobile Number",
                          hintText: "+91 1234567890",
                          enabledBorder: Borders.noBorder,
                          prefixIcon:Icon(
                            FeatherIcons.phone,
                            color: AppColors.blackShade1,
                            size: Sizes.ICON_SIZE_20,
                          ),
                          alignLabelWithHint: true,
                          contentPadding: EdgeInsets.only(top: Sizes.PADDING_4),
                          border: Borders.noBorder,
                          focusedBorder: Borders.noBorder
                      ),
                      style: Styles.customTextStyle(color: AppColors.pink),
                      readOnly: true,
                    ),
                    Divider(color: AppColors.grey, height: Sizes.HEIGHT_16),

                    //Police Station Name
                    TextFormField(
                      controller: PoliceStationName,
                      decoration: InputDecoration(
                          labelText: "Police Station Name",
                          hintText: "",
                          enabledBorder: Borders.noBorder,
                          prefixIcon:Icon(
                            FeatherIcons.shield,
                            color: AppColors.blackShade1,
                            size: Sizes.ICON_SIZE_20,
                          ),
                          alignLabelWithHint: true,
                          contentPadding: EdgeInsets.only(top: Sizes.PADDING_4),
                          border: Borders.noBorder,
                          focusedBorder: Borders.noBorder
                      ),
                      style: Styles.customTextStyle(color: AppColors.pink),
                    ),
                    Divider(color: AppColors.grey, height: Sizes.HEIGHT_16),

                    //Pin Code
                    TextFormField(
                      controller: Pincode,
                      decoration: InputDecoration(
                          labelText: "Pin Code",
                          hintText: "396191",
                          enabledBorder: Borders.noBorder,
                          prefixIcon:Icon(
                            FeatherIcons.mapPin,
                            color: AppColors.blackShade1,
                            size: Sizes.ICON_SIZE_20,
                          ),
                          alignLabelWithHint: true,
                          contentPadding: EdgeInsets.only(top: Sizes.PADDING_4),
                          border: Borders.noBorder,
                          focusedBorder: Borders.noBorder
                      ),
                      style: Styles.customTextStyle(color: AppColors.pink),
                      onChanged: (PinCodeValue)
                      {
                        GetCityAndState(PinCodeValue);
                      },
                    ),
                    Divider(color: AppColors.grey, height: Sizes.HEIGHT_16),

                    //District
                    TextFormField(
                      controller: District,
                      decoration: InputDecoration(
                          labelText: "District",
                          hintText: "",
                          enabledBorder: Borders.noBorder,
                          prefixIcon:Icon(
                            FeatherIcons.map,
                            color: AppColors.blackShade1,
                            size: Sizes.ICON_SIZE_20,
                          ),
                          alignLabelWithHint: true,
                          contentPadding: EdgeInsets.only(top: Sizes.PADDING_4),
                          border: Borders.noBorder,
                          focusedBorder: Borders.noBorder
                      ),
                      style: Styles.customTextStyle(color: AppColors.pink),
                      readOnly: true,
                    ),
                    Divider(color: AppColors.grey, height: Sizes.HEIGHT_16),

                    //State
                    TextFormField(
                      controller: State,
                      decoration: InputDecoration(
                          labelText: "State",
                          hintText: "",
                          enabledBorder: Borders.noBorder,
                          prefixIcon:Icon(
                            FeatherIcons.map,
                            color: AppColors.blackShade1,
                            size: Sizes.ICON_SIZE_20,
                          ),
                          alignLabelWithHint: true,
                          contentPadding: EdgeInsets.only(top: Sizes.PADDING_4),
                          border: Borders.noBorder,
                          focusedBorder: Borders.noBorder
                      ),
                      style: Styles.customTextStyle(color: AppColors.pink),
                      readOnly: true,
                    ),
                    Divider(color: AppColors.grey, height: Sizes.HEIGHT_16),

                    //Password
                    TextFormField(
                      controller: Password,
                      decoration: InputDecoration(
                          labelText: "Password",
                          hintText: "*****",
                          enabledBorder: Borders.noBorder,
                          prefixIcon:Icon(
                            FeatherIcons.lock,
                            color: AppColors.blackShade1,
                            size: Sizes.ICON_SIZE_20,
                          ),
                          alignLabelWithHint: true,
                          contentPadding: EdgeInsets.only(top: Sizes.PADDING_4),
                          border: Borders.noBorder,
                          focusedBorder: Borders.noBorder
                      ),
                      style: Styles.customTextStyle(color: AppColors.pink),
                      obscureText: true,

                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: widthOfScreen * 0.80,
            top: buttonOffset,
            child: Container(
              height: Sizes.HEIGHT_60,
              width: Sizes.WIDTH_60,
              child:  RaisedButton(
                    padding: const EdgeInsets.all(Sizes.PADDING_0),
                    elevation: Sizes.ELEVATION_8,
                    onPressed: () {

                      if((ValidatePassword() == true) && (Pincode.text.isNotEmpty) && (PoliceStationName.text.isNotEmpty)) {

                        // Logging out Firebase instance from Mobile Screen User
                        UserFromMobileScreen.signOut();

                        // Regsitering Police Officer in the Firebse Database

                        FbDatabase.child("PoliceOfficerRegistration").orderByChild("EmailID").equalTo(EmailId.text)
                            .once().then((snapshot){

                              if(snapshot.value != null)
                              {
                                print("-->"+snapshot.value.toString());
                                print("--> Email ID Already Registered.");
                                // _scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text("Email ID Already Registered.")));

                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Email ID Already Registered.")));

                                ExtendedNavigator.root.push(Routes.loginScreen,
                                    arguments: LoginScreenArguments(
                                        themeBloc: _themeBloc));
                              }
                              else
                              {
                                FbDatabase.child("PoliceOfficerRegistration").orderByChild("MobileNo").equalTo(MobileNumber.text)
                                    .once().then((snapshot){

                                  if(snapshot.value != null)
                                  {
                                    print("-->"+snapshot.value.toString());
                                    print("--> Mobile No. Already Registered.");
                                    // _scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text("Mobile No. Already Registered.")));

                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Mobile No. Already Registered.")));

                                    ExtendedNavigator.root.push(Routes.loginScreen,
                                        arguments: LoginScreenArguments(
                                            themeBloc: _themeBloc));

                                  }
                                  else
                                  {
                                    final NewPoliceOfficerRegistry=<String,dynamic>
                                    {
                                      'OfficerFullName' : Fullname.text,
                                      'EmailID' : EmailId.text,
                                      'MobileNo' : MobileNumber.text,
                                      'PoliceStationName' : PoliceStationName.text,
                                      'PinCode' : Pincode.text,
                                      'District' : District.text,
                                      'State' : State.text,
                                      'Password' : Password.text
                                    };

                                    FbDatabase
                                        .child("PoliceOfficerRegistration")
                                        .push()
                                        .set(NewPoliceOfficerRegistry)
                                        .then((_){
                                          print("Police Officer Has Been Successfully Registered.!");
                                          // _scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text("Registered Successfully.")));
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Registered Successfully.")));

                                        })
                                        .catchError((error) => print("Error Message : $error"));

                                    ExtendedNavigator.root.push(Routes.loginScreen,
                                        arguments: LoginScreenArguments(
                                            themeBloc: _themeBloc));
                                  }
                                });
                              }

                        });
                      }
                      else
                      {
                        _scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text("Please fill all the fields.")));
                      }
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Sizes.RADIUS_30),
                    ),
                    child: Ink(
                      height: Sizes.HEIGHT_60,
                      width: Sizes.WIDTH_60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Sizes.RADIUS_30),
                        gradient: Gradients.buttonGradient,
                      ),
                      child: Icon(
                        FeatherIcons.check,
                        size: Sizes.ICON_SIZE_30,
                        color: AppColors.white,
                      ),
                    ),
                  ),
            ),
          ),
        ],
      ),
    );
  }

  bool ValidatePassword()
  {
    if(!validatePasswordStructure(Password.text))
    {
      // show dialog/snackbar to get user attention.
      _scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text("Password Requirement : Minimum 1 uppercase,1 lowercase,1 Numeric No.,1 Special Character")));
      return false;
    }
    else{
      return true;
    }
  }
  bool validatePasswordStructure(String value){
    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  void GetCityAndState(String PinCode) async
  {
    String URL = "http://www.postalpincode.in/api/pincode/" + PinCode;

    http.Response _Response = await http.get(URL);

    // Map Data= jsonDecode(_Response.body);
    // print(Data);
    // print(Data['PostOffice'][0]['District']);

    if (_Response.statusCode != 200)
    {
      // return new Text('Could not connect to weather service.');
    }
    else
    {
      Map Data= jsonDecode(_Response.body);
      if(Data['Status'].toString() == "Success")
      {
        // print(Data['PostOffice'][0]['District']);
        setState(()
        {
          print(Data);
          District.text=Data['PostOffice'][0]['District'];
          State.text=Data['PostOffice'][0]['State'];
        });
      }
      else
      {
        // return new Text('Weather service error: $json.');
        setState(()
        {
          District.text="";
          State.text="";
        });
      }
    }
  }
}
