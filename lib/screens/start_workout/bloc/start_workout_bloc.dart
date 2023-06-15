import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'start_workout_event.dart';
part 'start_workout_state.dart';

class StartWorkoutBloc extends Bloc<StartWorkoutEvent, StartWorkoutState> {
  StartWorkoutBloc() : super(StartWorkoutInitial()){
    on<BackTappedEvent>((event, emit) {
      emit(BackTappedState());
    });
    on<PlayTappedEvent>((event, emit) {
      emit(PlayTimerState(time: event.time));
    });
    on<PauseTappedEvent>((event, emit) {
      emit(PauseTimerState(currentTime: event.time));
    });
  }

  int time = 0;

}
