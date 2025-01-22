import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shope_app/network/local/cache_helper.dart';
import 'package:shope_app/shared/cubit/cubit.dart';
import 'package:shope_app/shared/cubit/states.dart';
import 'package:shope_app/style/bloc_observer.dart';
import 'package:shope_app/style/themes/theme_data.dart';

import 'layout/shop_layout.dart';
import 'modules/login/login_screen.dart';
import 'modules/on_boarding/on_boarding_screen.dart';
import 'network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  //bool? isDark = CacheHelper.getData(key: 'isDark');
  Widget widget;
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  String? token = CacheHelper.getData(key: 'token');

  if (onBoarding != null) {
    if (token != null) {
      widget = const ShopLayout();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = const OnBoardingScreen();
  }

  runApp(MyApp(
    isDark: 'isDark' == "true" ? true : false,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget startWidget;
  const MyApp({super.key, required this.isDark, required this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopAppCubit()..getHomeData(),
      child: BlocConsumer<ShopAppCubit, ShopAppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: startWidget,
          );
        },
      ),
    );
  }
}
