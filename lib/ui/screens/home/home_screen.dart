import 'package:aflore_flutter/bloc/home/home_bloc.dart';
import 'package:aflore_flutter/models/network/model_movie_popular.dart';
import 'package:aflore_flutter/ui/custom_widgets/custom_card.dart';
import 'package:aflore_flutter/ui/custom_widgets/custom_view_movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(_onScroll);

    super.initState();
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        switch (state.status) {
          case HomeStatus.failure:
            return const Center(child: Text('Sin información para mostrar'));
          case HomeStatus.success:
            if (state.list.isEmpty) {
              return const Center(child: Text('Sin lista de películas'));
            }else {
              return _home(state.list);
            }
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _home(List<ModelMovie> modelList) {
    final itemCount = modelList.length;

    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverAppBar(
          expandedHeight: 40.h,
          floating: false,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Populares',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              background: Image.asset(
                "assets/img/home.jpg",
                fit: BoxFit.cover,
              )),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, i) {
            final result = modelList[i];
            return _card(result);
          }, childCount: itemCount),
        )
      ],
    );
  }

  Widget _card(ModelMovie movie) {
    return CustomCard(movie, (value) {
      _onTap(value);
    });
  }

  void _onTap(ModelMovie movie) {
    Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        barrierDismissible: true,
        pageBuilder: (BuildContext context, _, __) {
          return CustomViewMovie(movie: movie);
        }));
  }

  void _onScroll() {
    if (_isBottom) context.read<HomeBloc>().add(HomeEventInit());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
