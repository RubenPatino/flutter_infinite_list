import 'package:aflore_flutter/bloc/home/home_bloc.dart';
import 'package:aflore_flutter/ui/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreenBloc extends StatelessWidget {
  const HomeScreenBloc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => HomeBloc()..add(HomeEventInit()),
        child: const HomeScreen(),
      ),
    );
  }
}
