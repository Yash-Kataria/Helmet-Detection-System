import 'package:auto_route/auto_route.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:smart_law_enforcement_system/login_signup/bloc/theme_bloc.dart';
import 'package:smart_law_enforcement_system/login_signup/routes/router.gr.dart';
import 'package:smart_law_enforcement_system/login_signup/themes/login_signup_design_theme.dart';
import 'package:smart_law_enforcement_system/login_signup/values/values.dart';
import 'package:smart_law_enforcement_system/login_signup/widgets/custom_shape_clippers.dart';
import 'package:smart_law_enforcement_system/login_signup/widgets/spaces.dart';
import 'package:smart_law_enforcement_system/primary_screens/MasterPage.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({required this.themeBloc});

  final ThemeBloc themeBloc;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey key = GlobalKey();
  double buttonOffset = 40.0;
  double textOffset = 60.0;
  late ThemeBloc _themeBloc;

  TextEditingController MobileNo=TextEditingController();
  TextEditingController Password=TextEditingController();

  final FbDatabase=FirebaseDatabase.instance.reference();
  bool showLoading = false;


  @override
  void initState() {
    super.initState();
    _themeBloc = ThemeBloc();

    widget.themeBloc.selectedTheme.add(_buildLightTheme());
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      // executes after build
      getSizeOfCard();
    });
  }

  @override
  void dispose()
  {
    // Cleaning up the controller when the widget is disposed
    MobileNo.dispose();
    Password.dispose();
    super.dispose();
  }

  CurrentTheme _buildLightTheme() {
    return CurrentTheme('light', LoginSignUpDesignTheme.lightThemeData);
  }

  void getSizeOfCard() {
    final keyContext = key.currentContext;
    if (keyContext != null) {
      final box = keyContext.findRenderObject() as RenderBox;
      setState(() {
        buttonOffset = (box.size.height / 2) - 30;
        textOffset = box.size.height;
      });
    }
  }
  final GlobalKey<ScaffoldState> _scaffoldKey=GlobalKey();

  @override
  Widget build(BuildContext context) {
    var heightOfScreen = MediaQuery.of(context).size.height;
    var widthOfScreen = MediaQuery.of(context).size.width;
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      key:_scaffoldKey,
      body: showLoading
          ? Center(
          child: CircularProgressIndicator(),
        )
          : GestureDetector(
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
                margin: const EdgeInsets.all(Sizes.MARGIN_0),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView(
                        children: <Widget>[
                          Container(
                            height: heightOfScreen * 0.25,
                          ),
                          Text(
                            "Account Login",
                            textAlign: TextAlign.center,
                            style: textTheme.headline!.copyWith(
                              color: AppColors.lightBlueShade5,
                            ),
                          ),
                          SizedBox(height: heightOfScreen * 0.05),
                          _buildForm(context: context),
                          SpaceH16(),
                          Container(
                            margin:
                                EdgeInsets.all(15),
                            child: Text(
                              "Forgot Password ?",
                              style: textTheme.body1!.copyWith(
                                fontSize: Sizes.TEXT_SIZE_16,
                                color: AppColors.orangeShade4,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SpaceH16(),
                          Container(
                            height: 60,
                            width: 120,
                            margin:
                                EdgeInsets.only(right: (widthOfScreen - 120)),
                            child: RaisedButton(
                                onPressed: () => ExtendedNavigator.root.push(Routes.VerifyGmailScreen,arguments: VerifyGmailArguments(themeBloc: _themeBloc)),
                              // onPressed:() => ExtendedNavigator.root.push(Routes.VerifyMobile,arguments: VerifyMobileArguments(themeBloc: _themeBloc)),
                              color: AppColors.white,
                              elevation: Sizes.ELEVATION_6,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(Sizes.RADIUS_30),
                                  bottomRight: Radius.circular(Sizes.RADIUS_30),
                                ),
                              ),
                              child: Text(
                                StringConst.REGISTER,
                                style: textTheme.button!.copyWith(
                                  color: AppColors.orangeShade1,
                                ),
                              ),
                            ),
                          ),
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
            width: widthOfScreen * 0.85,
            child: Card(
              elevation: Sizes.ELEVATION_4,
              margin: const EdgeInsets.only(
                left: Sizes.MARGIN_0,
                top: Sizes.MARGIN_8,
                bottom: Sizes.MARGIN_8,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(60.0),
                  bottomRight: Radius.circular(60.0),
                ),
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: Sizes.MARGIN_16),
                child: Column(
                  children: <Widget>[
                    //Mobile Number
                    TextFormField(
                      controller: MobileNo,
                      decoration: InputDecoration(
                        labelText: "Mobile Number",
                        hintText: "+91 1234567890",
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
                      keyboardType: TextInputType.phone,
                      style: Styles.customTextStyle(color: AppColors.pink),
                    ),

                    Divider(
                      color: AppColors.grey,
                      height: Sizes.HEIGHT_20,
                    ),

                    // Password
                    TextFormField(
                      controller: Password,
                      decoration: InputDecoration(
                          labelText: "Password",
                          hintText: "*******",
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
            left: widthOfScreen * 0.75,
            top: buttonOffset,
            child: Container(
              height: Sizes.HEIGHT_60,
              width: Sizes.WIDTH_60,
              child: RaisedButton(
                padding: const EdgeInsets.all(Sizes.PADDING_0),
                elevation: Sizes.ELEVATION_8,
                onPressed: ()
                {
                  // _scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text("Invalid Credentials!")));
                  // ExtendedNavigator.root.push(Routes.homescreen);

                  // if((validateMobileNumberStructure(Username.text) == true) && ) {

                    setState(() {
                      showLoading=true;
                    });
                    if(MobileNo.text.isNotEmpty && Password.text.isNotEmpty)
                    {
                      if(validateMobileNumberStructure(MobileNo.text) == true)
                      {
                        if(validatePasswordStructure(Password.text) == true)
                        {

                          // String MobileNoVar="+91 9512136600".replaceAll(' ', '');
                          String MobileNoVar=MobileNo.text.toString();

                          FbDatabase.child("PoliceOfficerRegistration").orderByChild("MobileNo").equalTo(MobileNoVar.replaceAll(' ', ''))
                              .once().then((snapshot){

                            if(snapshot.value == null)
                            {
                              print("--> Mobile No. not registered.");

                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Mobile No. Not Registered.")));

                              setState(() {
                                showLoading=false;
                              });

                            }
                            else
                            {
                              FbDatabase.child("PoliceOfficerRegistration").orderByChild("Password").equalTo(Password.text)
                                  .once().then((snapshot){

                                if(snapshot.value == null)
                                {
                                  print("--> Invalid Password.");

                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid Password.")));

                                  setState(() {
                                    showLoading=false;
                                  });
                                }
                                else   // Everything is correct move to homepage
                                {
                                  setState(() {
                                    showLoading=false;
                                  });

                                  // ExtendedNavigator.root.push(Routes.Masterpage);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MasterPage(),
                                        settings: RouteSettings(
                                          arguments: MobileNoVar,
                                        )),
                                  );
                                }
                              });
                            }
                          });
                        }
                        else
                        {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Provide A Valid Password")));
                        }
                      }
                      else
                      {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Provide A Valid Mobile No.")));
                      }
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
                    FeatherIcons.arrowRight,
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

  bool validatePasswordStructure(String value){
    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  bool validateMobileNumberStructure(String value){
    String  pattern = r'^(\+91[\-\s]?)?[0]?(91)?[6789]\d{9}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }
}
