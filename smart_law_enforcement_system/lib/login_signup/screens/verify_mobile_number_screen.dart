import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_law_enforcement_system/login_signup/bloc/theme_bloc.dart';
import 'package:smart_law_enforcement_system/login_signup/routes/router.gr.dart';
import 'package:smart_law_enforcement_system/login_signup/themes/login_signup_design_theme.dart';
import 'package:smart_law_enforcement_system/login_signup/values/values.dart';
import 'package:smart_law_enforcement_system/login_signup/widgets/custom_shape_clippers.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class VerifyMobileScreen extends StatefulWidget {
  VerifyMobileScreen({required this.themeBloc});
  final ThemeBloc themeBloc;
  @override
  _VerifyMobileScreenState createState() => _VerifyMobileScreenState();
}

class _VerifyMobileScreenState extends State<VerifyMobileScreen> {
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;

  late String verificationId;

  bool showLoading = false;

  GlobalKey cardKey = GlobalKey();
  double buttonOffset = 40.0;

  late ThemeBloc _themeBloc;

  late FirebaseAuth UserFromSignUpScreen;

  late FirebaseAuth _auth;

  final MobileNumber = TextEditingController();
  final OTPNumber = TextEditingController();

  @override
  void initState() {
    super.initState();
    _themeBloc = ThemeBloc();

    //Removing Previous Firebase Insatnce from Sign Up Screen

    UserFromSignUpScreen = FirebaseAuth.instance;

    _auth = FirebaseAuth.instance;

    widget.themeBloc.selectedTheme.add(_buildLightTheme());
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      // executes after build
      getSizeOfCard();
    });
  }

  void LogoutPreviousFirebaseInstance() async {
    await UserFromSignUpScreen.signOut();
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

  void signInWithPhoneAuthCredential(AuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });

    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      setState(() {
        showLoading = false;
      });

      if (authCredential.user != null) {
        // Storing the value of mobile number in global scope shared preference

        final Preference = await SharedPreferences.getInstance();
        Preference.setString('MobileNumber', authCredential.user.phoneNumber);

        ExtendedNavigator.root.push(Routes.signUpScreen,
            arguments: SignUpArguments(themeBloc: _themeBloc));
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });

      _scaffoldKey.currentState!
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  getMobileFormWidget(context) {
    var textTheme = Theme.of(context).textTheme;
    var heightOfScreen = MediaQuery.of(context).size.height;
    var widthOfScreen = MediaQuery.of(context).size.width;

    return GestureDetector(
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
                          height: heightOfScreen * 0.35,
                        ),
                        Text(
                          "Verify Your Mobile Number",
                          textAlign: TextAlign.center,
                          style: textTheme.headline!.copyWith(
                            color: AppColors.lightBlueShade5,
                          ),
                        ),
                        SizedBox(height: heightOfScreen * 0.03),
                        _buildFormMobileNumber(context: context),
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
                onPressed: () {
                  ExtendedNavigator.root.push(Routes.loginScreen,
                      arguments: LoginScreenArguments(themeBloc: _themeBloc));
                },
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
    );
  }

  getOtpFormWidget(context) {
    var textTheme = Theme.of(context).textTheme;
    var heightOfScreen = MediaQuery.of(context).size.height;
    var widthOfScreen = MediaQuery.of(context).size.width;

    return GestureDetector(
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
                          height: heightOfScreen * 0.35,
                        ),
                        Text(
                          "Enter OTP",
                          textAlign: TextAlign.center,
                          style: textTheme.headline!.copyWith(
                            color: AppColors.lightBlueShade5,
                          ),
                        ),
                        SizedBox(height: heightOfScreen * 0.03),
                        _buildFormOTPNumber(context: context),
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
                onPressed: () => ExtendedNavigator.root.push(Routes.loginScreen,
                    arguments: LoginScreenArguments(themeBloc: _themeBloc)),
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
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  final GlobalKey<FormState> _FormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var heightOfScreen = MediaQuery.of(context).size.height;
    var widthOfScreen = MediaQuery.of(context).size.width;
    return Scaffold(
        key: _scaffoldKey,
        body: Container(
          child: showLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
                  ? getMobileFormWidget(context)
                  : getOtpFormWidget(context),
          // padding: const EdgeInsets.all(16),
        ));
  }

  Widget _buildFormMobileNumber({required BuildContext context}) {
    var widthOfScreen = MediaQuery.of(context).size.width;
    var textTheme = Theme.of(context).textTheme;

    return Container(
      width: widthOfScreen,
      child: Form(
        key: _FormKey,
        child: Stack(
          children: <Widget>[
            Container(
              width: widthOfScreen * 0.85,
              child: Card(
                key: cardKey,
                elevation: Sizes.ELEVATION_4,
                margin: const EdgeInsets.only(
                  left: Sizes.MARGIN_0,
                  top: Sizes.MARGIN_32,
                  bottom: Sizes.MARGIN_8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(300.0),
                    bottomRight: Radius.circular(300.0),
                  ),
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: Sizes.MARGIN_12),
                  child: Column(
                    children: <Widget>[
                      //Mobile Number
                      TextFormField(
                        controller: MobileNumber,
                        validator: (Value) {
                          if (Value == null || Value.isEmpty) {
                            return "Mobile No. Field Can't Be Empty.";
                          }
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            labelText: "Mobile Number",
                            hintText: "+91 1234567890",
                            enabledBorder: Borders.noBorder,
                            prefixIcon: Icon(
                              FeatherIcons.phone,
                              color: AppColors.blackShade1,
                              size: Sizes.ICON_SIZE_20,
                            ),
                            alignLabelWithHint: true,
                            contentPadding:
                                EdgeInsets.only(top: Sizes.PADDING_4),
                            border: Borders.noBorder,
                            focusedBorder: Borders.noBorder),
                        style: Styles.customTextStyle(color: AppColors.pink),
                        enableSuggestions: true,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: widthOfScreen * 0.70,
              top: 40.0,
              child: Container(
                height: Sizes.HEIGHT_60,
                width: Sizes.WIDTH_100,
                child: RaisedButton(
                  padding: const EdgeInsets.all(Sizes.PADDING_0),
                  elevation: Sizes.ELEVATION_8,
                  onPressed: () async {
                    // ExtendedNavigator.root.push(Routes.signUpScreen,arguments: SignUpArguments(themeBloc: _themeBloc));
                    if (!validateMobileNumberStructure(MobileNumber.text)) {
                      _scaffoldKey.currentState!.showSnackBar(SnackBar(
                          content: Text(
                              "Provide a valid Mobile No. (Eg : +91 9234567890)")));
                    } else {
                      if (_FormKey.currentState!.validate()) {
                        setState(() {
                          showLoading = true;
                        });
                        await _auth.verifyPhoneNumber(
                          phoneNumber: MobileNumber.text,
                          verificationCompleted: (phoneAuthCredential) async {
                            setState(() {
                              showLoading = false;
                            });
                            // signInWithPhoneAuthCredential(phoneAuthCredential);
                          },
                          verificationFailed: (verificationFailed) async {
                            setState(() {
                              showLoading = false;
                            });
                            _scaffoldKey.currentState!.showSnackBar(SnackBar(
                                content: Text(verificationFailed.message)));
                          },
                          codeSent: (verficationId, resendingToken) async {
                            setState(() {
                              showLoading = false;
                              currentState =
                                  MobileVerificationState.SHOW_OTP_FORM_STATE;
                              this.verificationId = verficationId;
                            });
                          },
                          codeAutoRetrievalTimeout: (verificationId) async {},
                        );
                      } else {
                        _scaffoldKey.currentState!.showSnackBar(SnackBar(
                            content: Text("Mobile No. field can't be empty.")));
                      }
                    }
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Sizes.RADIUS_30),
                  ),
                  child: Ink(
                    height: Sizes.HEIGHT_60,
                    width: Sizes.WIDTH_100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Sizes.RADIUS_30),
                      gradient: Gradients.buttonGradient,
                    ),
                    child: Center(
                      child: Text(
                        "Send OTP",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: AppColors.lightBlueShade5,
                        ),
                      ),
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

  bool validateMobileNumberStructure(String value) {
    String pattern = r'^(\+91[\-\s]?)?[0]?(91)?[6789]\d{9}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  Widget _buildFormOTPNumber({required BuildContext context}) {
    var widthOfScreen = MediaQuery.of(context).size.width;
    var textTheme = Theme.of(context).textTheme;

    return Container(
      width: widthOfScreen,
      child: Form(
        key: _FormKey,
        child: Stack(
          children: <Widget>[
            Container(
              width: widthOfScreen * 0.85,
              child: Card(
                key: cardKey,
                elevation: Sizes.ELEVATION_4,
                margin: const EdgeInsets.only(
                  left: Sizes.MARGIN_0,
                  top: Sizes.MARGIN_32,
                  bottom: Sizes.MARGIN_8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(300.0),
                    bottomRight: Radius.circular(300.0),
                  ),
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: Sizes.MARGIN_12),
                  child: Column(
                    children: <Widget>[
                      // OTP
                      TextFormField(
                        controller: OTPNumber,
                        validator: (Value) {
                          if (Value == null || Value.isEmpty) {
                            return "Please provide the OTP no.";
                          }
                        },
                        decoration: InputDecoration(
                            labelText: "OTP",
                            hintText: "******",
                            enabledBorder: Borders.noBorder,
                            prefixIcon: Icon(
                              FeatherIcons.edit,
                              color: AppColors.blackShade1,
                              size: Sizes.ICON_SIZE_20,
                            ),
                            alignLabelWithHint: true,
                            contentPadding:
                                EdgeInsets.only(top: Sizes.PADDING_4),
                            border: Borders.noBorder,
                            focusedBorder: Borders.noBorder),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.phone,
                        style: Styles.customTextStyle(color: AppColors.pink),
                        obscureText: true,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: widthOfScreen * 0.70,
              top: 40.0,
              child: Container(
                height: Sizes.HEIGHT_60,
                width: Sizes.WIDTH_100,
                child: RaisedButton(
                  padding: const EdgeInsets.all(Sizes.PADDING_0),
                  elevation: Sizes.ELEVATION_8,
                  onPressed: () async {
                    // ExtendedNavigator.root.push(Routes.signUpScreen,arguments: SignUpArguments(themeBloc: _themeBloc));
                    if (_FormKey.currentState!.validate()) {
                      AuthCredential phoneAuthCredential =
                          PhoneAuthProvider.credential(
                              verificationId: verificationId,
                              smsCode: OTPNumber.text);

                      signInWithPhoneAuthCredential(phoneAuthCredential);
                    } else {
                      _scaffoldKey.currentState!.showSnackBar(SnackBar(
                          content: Text("OTP No. field can't be empty.")));
                    }
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Sizes.RADIUS_30),
                  ),
                  child: Ink(
                    height: Sizes.HEIGHT_60,
                    width: Sizes.WIDTH_100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Sizes.RADIUS_30),
                      gradient: Gradients.buttonGradient,
                    ),
                    child: Center(
                      child: Text(
                        "Verify OTP",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: AppColors.lightBlueShade5,
                        ),
                      ),
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
