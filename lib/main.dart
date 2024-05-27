import 'package:coinpro_prokit/screen/CPSplashScreen.dart';
import 'package:coinpro_prokit/store/AppStore.dart';
import 'package:coinpro_prokit/utils/AppTheme.dart';
import 'package:coinpro_prokit/utils/CPDataProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

AppStore appStore = AppStore();

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();

  await initialize(aLocaleLanguageList: languageList());

  appStore.toggleDarkMode(value: getBoolAsync('isDarkModeOnPref'));

  defaultRadius = 10;
  defaultToastGravityGlobal = ToastGravity.BOTTOM;

  runApp(const MyApp());

  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://wrzngalxdfmfojbtcugy.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Indyem5nYWx4ZGZtZm9qYnRjdWd5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTYzNTkzODIsImV4cCI6MjAzMTkzNTM4Mn0.0JzveiHtC7zZVL8mTVBKwjlTuyr1tWH5KckE_h5ZxiY',
  );

  runApp(MyApp());
}

// It's handy to then extract the Supabase client in a variable for later uses
final supabase = Supabase.instance.client;


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '${"Coin Pro"}${!isMobile ? ' ${platformName()}' : ''}',
        home: CPSplashScreen(),
        theme: appStore.isDarkModeOn ? AppThemeData.darkTheme:AppThemeData.lightTheme ,
        navigatorKey: navigatorKey,
        scrollBehavior: SBehavior(),
        supportedLocales: LanguageDataModel.languageLocales(),
        localeResolutionCallback: (locale, supportedLocales) => locale,
      ),
    );
  }
}
