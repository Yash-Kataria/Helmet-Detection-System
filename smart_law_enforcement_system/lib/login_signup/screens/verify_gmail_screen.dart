import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_law_enforcement_system/login_signup/bloc/theme_bloc.dart';
import 'package:smart_law_enforcement_system/login_signup/routes/router.gr.dart';
import 'package:smart_law_enforcement_system/login_signup/themes/login_signup_design_theme.dart';
import 'package:smart_law_enforcement_system/login_signup/values/values.dart';
import 'package:smart_law_enforcement_system/login_signup/widgets/custom_shape_clippers.dart';

class VerifyGmailScreen extends StatefulWidget {
  VerifyGmailScreen({required this.themeBloc});

  final ThemeBloc themeBloc;

  @override
  _VerifyGmailScreenState createState() => _VerifyGmailScreenState();
}

class _VerifyGmailScreenState extends State<VerifyGmailScreen> {
  GlobalKey cardKey = GlobalKey();
  double buttonOffset = 40.0;

  late ThemeBloc _themeBloc;

  late FirebaseAuth _auth;

  late String verificationId;

  bool showLoading = false;

  @override
  void initState() {
    super.initState();
    _themeBloc = ThemeBloc();

    _auth = FirebaseAuth.instance;

    widget.themeBloc.selectedTheme.add(_buildLightTheme());
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      // executes after build
      getSizeOfCard();
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

  void signInWithCredential() async {
    final googleSignIn = GoogleSignIn();

    setState(() {
      showLoading = true;
    });

    try {
      final Gmailuser = await googleSignIn.signIn();

      if (Gmailuser == null) {
        showLoading = false;
        _scaffoldKey.currentState!.showSnackBar(SnackBar(
            content: Text("User is not recognized as a valid google user.")));

        // ExtendedNavigator.root.push(Routes.gmailVerify,arguments: GmailVerifyArguments(themeBloc: _themeBloc));
      } else {
        final googleAuth = await Gmailuser.authentication;

        final gmailUserCredential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final authCredential =
            await _auth.signInWithCredential(gmailUserCredential);

        setState(() {
          showLoading = false;
        });

        if (authCredential.user != null) {
          // Storing the value of mobile number in global scope shared preference

          final Preference = await SharedPreferences.getInstance();
          Preference.setString('EmailId', authCredential.user.email);
          Preference.setString('Username', authCredential.user.displayName);

          //Logging Out from Google
          googleSignIn.disconnect();
          ExtendedNavigator.root.push(Routes.VerifyMobile,
              arguments: VerifyMobileArguments(themeBloc: _themeBloc));
        }
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });

      _scaffoldKey.currentState!
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var heightOfScreen = MediaQuery.of(context).size.height;
    var widthOfScreen = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
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
                        decoration:
                            BoxDecoration(color: AppColors.orangeShade2),
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
                                  height: heightOfScreen * 0.4,
                                ),
                                Text(
                                  "Verify Your Gmail",
                                  textAlign: TextAlign.center,
                                  style: textTheme.headline!.copyWith(
                                    color: AppColors.lightBlueShade5,
                                  ),
                                ),
                                SizedBox(height: heightOfScreen * 0.05),
                                // _buildForm(context: context),
                                Container(
                                  width: widthOfScreen,
                                  padding: EdgeInsets.all(4),
                                  child: OutlineButton.icon(
                                    label: Text(
                                      'Verify With Google',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    shape: StadiumBorder(),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                    highlightedBorderColor: Colors.black,
                                    borderSide: BorderSide(color: Colors.black),
                                    textColor: Colors.black,
                                    icon: Icon(
                                      FontAwesomeIcons.google,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      signInWithCredential();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: heightOfScreen * 0.1,
                    right: Sizes.SIZE_0,
                    child: Container(
                      height: Sizes.HEIGHT_60,
                      width: Sizes.WIDTH_120,
                      child: RaisedButton(
                        onPressed: () => ExtendedNavigator.root.push(
                            Routes.loginScreen,
                            arguments:
                                LoginScreenArguments(themeBloc: _themeBloc)),
                        color: AppColors.white,
                        elevation: Sizes.ELEVATION_6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(Sizes.RADIUS_30),
                            bottomLeft: Radius.circular(Sizes.RADIUS_30),
                          ),
                        ),
                        child: Text(
                          StringConst.LOG_IN_2,
                          style: textTheme.button!.copyWith(
                            color: AppColors.orangeShade1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
