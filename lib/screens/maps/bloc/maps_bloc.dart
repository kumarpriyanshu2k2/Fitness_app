

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'maps_event.dart';
part 'maps_state.dart';

class MapsBloc extends Bloc<MapsEvent, MapsState> {
  MapsBloc() : super(MapsInitial()){
    on<ReloadImageEvent>((event, emit) {
      emit(ReloadImageState());
    });
  }

}
