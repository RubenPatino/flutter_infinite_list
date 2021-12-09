part of 'home_bloc.dart';

enum HomeStatus { initial, success, failure }

class HomeState extends Equatable {
  const HomeState(
      {this.list = const <ModelMovie>[],
      this.hasReachedMax = false,
      this.status = HomeStatus.initial});

  final List<ModelMovie> list;
  final bool hasReachedMax;
  final HomeStatus status;

  HomeState copyWith(
      {List<ModelMovie>? list,
      bool? hasReachedMax,
      HomeStatus? status,
      int? total}) {
    return HomeState(
        list: list ?? this.list,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        status: status ?? this.status);
  }

  @override
  List<Object> get props => [list, hasReachedMax];
}
