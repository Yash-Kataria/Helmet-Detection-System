import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:smart_law_enforcement_system/login_signup/bloc/theme_bloc.dart';
import 'package:smart_law_enforcement_system/login_signup/routes/router.gr.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async
{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    runApp(
        MyApp(),
    );
}

class MyApp extends StatefulWidget {
    @override
    _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>
{
    late ThemeBloc _themeBloc;

    @override
    void initState() {
        super.initState();
        _themeBloc = ThemeBloc();
    }

    @override
    Widget build(BuildContext context) {
        return StreamBuilder<ThemeData>(
            initialData: _themeBloc.initialTheme().data,
            stream: _themeBloc.themeDataStream,
            builder: (BuildContext context, AsyncSnapshot<ThemeData> snapshot) {
                return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    theme: snapshot.data,
                    darkTheme: null,
                    builder: ExtendedNavigator<AppRouter>(
                        router: AppRouter(),
                        initialRoute: Routes.loginScreen,
                        initialRouteArgs: LoginScreenArguments(themeBloc: _themeBloc),
//            initialRoute: Routes.loginScreen1,
                    ),
                );
            },
        );
    }
}
