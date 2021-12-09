import 'package:aflore_flutter/api/api_dio.dart';
import 'package:aflore_flutter/db/shared_preferences/preference_connector.dart';
import 'package:aflore_flutter/models/network/model_movie_popular.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';

part 'home_event.dart';

part 'home_state.dart';

const throttleDuration = Duration(seconds: 1);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<HomeEventInit>(_eventGetInfo,
        transformer: throttleDroppable(throttleDuration));
  }

  int page = 1;

  Future<void> _eventGetInfo(
      HomeEventInit event, Emitter<HomeState> emit) async {
    try {
      if (state.hasReachedMax) return;

      if (state.status == HomeStatus.initial) {
        final model = await ApiDio().getMoviePopular(page);

        if (model != null) {
          SharedPreferencesConnector().savedModelMovie(model);

          final list = model.results;

          if (list != null) {
            return emit(state.copyWith(
                status: HomeStatus.success,
                list: list,
                hasReachedMax: false,
                total: list.length));
          } else {
            return emit(state.copyWith(status: HomeStatus.failure));
          }
        } else {
          return emit(state.copyWith(status: HomeStatus.failure));
        }
      } else {
        page++;
        final model = await ApiDio().getMoviePopular(page);

        if (model != null) {
          final list = model.results;

          if (list != null) {
            list.isEmpty
                ? emit(state.copyWith(hasReachedMax: true))
                : emit(state.copyWith(
                    status: HomeStatus.success,
                    list: List.of(state.list)..addAll(list),
                    hasReachedMax: false));
          } else {
            return emit(state.copyWith(status: HomeStatus.failure));
          }
        } else {
          return emit(state.copyWith(status: HomeStatus.failure));
        }
      }
    } catch (ex) {
      emit(state.copyWith(status: HomeStatus.failure));
    }
  }
}
