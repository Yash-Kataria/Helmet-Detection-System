// import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route_annotations.dart';
import 'package:smart_law_enforcement_system/login_signup/bloc/theme_bloc.dart';
import 'package:smart_law_enforcement_system/login_signup/screens/login_screen.dart';
import 'package:smart_law_enforcement_system/login_signup/screens/signup_screen.dart';
import 'package:smart_law_enforcement_system/login_signup/screens/verify_gmail_screen.dart';
import 'package:smart_law_enforcement_system/login_signup/screens/verify_mobile_number_screen.dart';
import 'package:smart_law_enforcement_system/primary_screens/MasterPage.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    // initial route is named "/"

    MaterialRoute(page: LoginScreen, initial: true),
    MaterialRoute(page: SignUpScreen),
    MaterialRoute(page: VerifyGmailScreen),
    MaterialRoute(page: VerifyMobileScreen),
    // MaterialRoute(page: HomeScreen),
    MaterialRoute(page: MasterPage),
  ],
)
class $AppRouter {}

//ScreenArguments arguments holder class
class ScreenArguments {
  final ThemeBloc themeBloc;
  ScreenArguments({required this.themeBloc});
}
