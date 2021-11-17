import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:smart_law_enforcement_system/login_signup/bloc/theme_bloc.dart';
import 'package:smart_law_enforcement_system/login_signup/screens/login_screen.dart';
import 'package:smart_law_enforcement_system/login_signup/screens/signup_screen.dart';
import 'package:smart_law_enforcement_system/login_signup/screens/verify_gmail_screen.dart';
import 'package:smart_law_enforcement_system/login_signup/screens/verify_mobile_number_screen.dart';
import 'package:smart_law_enforcement_system/primary_screens/MasterPage.dart';

class Routes {

    static const String loginScreen = '/login-screen';
    static const String signUpScreen = '/sign-up-screen';
    static const String VerifyGmailScreen = '/verify-gmail-screen';
    static const String VerifyMobile = '/verify-mobile-screen';
    static const String Masterpage = '/Masterpage';


    static const all = <String>{
        loginScreen,
        signUpScreen,
        VerifyGmailScreen,
        VerifyMobile,
        Masterpage,
    };
}

class AppRouter extends RouterBase {
    @override
    List<RouteDef> get routes => _routes;
    final _routes = <RouteDef>[
        RouteDef(Routes.loginScreen, page: LoginScreen),
        RouteDef(Routes.signUpScreen, page: SignUpScreen),
        RouteDef(Routes.VerifyGmailScreen, page: VerifyGmailScreen),
        RouteDef(Routes.VerifyMobile, page: VerifyMobileScreen),
        RouteDef(Routes.Masterpage, page: MasterPage),

    ];

    @override
    Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
    final _pagesMap = <Type, AutoRouteFactory>{

        LoginScreen: (data) {
            // print("Coming in Login Screen");
            final args = data.getArgs<LoginScreenArguments>(nullOk: false);
            return MaterialPageRoute<dynamic>(
                builder: (context) => LoginScreen(themeBloc: args.themeBloc),
                settings: data,
            );
        },
        SignUpScreen: (data) {
            // print("Coming in Sign Up Screen");
            final args = data.getArgs<SignUpArguments>(nullOk: false);
            return MaterialPageRoute<dynamic>(
                builder: (context) => SignUpScreen(themeBloc: args.themeBloc),
                settings: data,
            );
        },
        VerifyGmailScreen: (data) {
            // print("Coming in Sign Up Screen");
            final args = data.getArgs<VerifyGmailArguments>(nullOk: false);
            return MaterialPageRoute<dynamic>(
                builder: (context) => VerifyGmailScreen(themeBloc: args.themeBloc),
                settings: data,
            );
        },
        VerifyMobileScreen: (data) {
            // print("Coming in Sign Up Screen");
            final args = data.getArgs<VerifyMobileArguments>(nullOk: false);
            return MaterialPageRoute<dynamic>(
                builder: (context) => VerifyMobileScreen(themeBloc: args.themeBloc),
                settings: data,
            );
        },
        // MasterPage: (data) {
        //     return MaterialPageRoute<dynamic>(
        //         builder: (context) => MasterPage(),
        //         settings: data,
        //     );
        // },
    };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************


/// LoginScreen arguments holder class
class LoginScreenArguments {
    final ThemeBloc themeBloc;
    LoginScreenArguments({required this.themeBloc});
}

/// SignUp arguments holder class
class SignUpArguments {
    final ThemeBloc themeBloc;
    SignUpArguments({required this.themeBloc});
}

/// VerifyGmail arguments holder class
class VerifyGmailArguments {
    final ThemeBloc themeBloc;
    VerifyGmailArguments({required this.themeBloc});
}

/// VerifyMobile arguments holder class
class VerifyMobileArguments {
    final ThemeBloc themeBloc;
    VerifyMobileArguments({required this.themeBloc});
}
