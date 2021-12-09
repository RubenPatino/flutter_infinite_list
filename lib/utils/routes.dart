import 'package:aflore_flutter/constants/page_constant.dart';
import 'package:aflore_flutter/ui/screens/home/home_screen_bloc.dart';
import 'package:flutter/material.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder>{
      PageConstant.homeScreen: (_) => const HomeScreenBloc()
    };
  }
}
