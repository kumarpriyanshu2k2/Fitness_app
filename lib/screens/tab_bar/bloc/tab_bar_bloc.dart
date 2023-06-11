import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'tab_bar_event.dart';
part 'tab_bar_state.dart';

class TabBarBloc extends Bloc<TabBarEvent, TabBarState> {
  int currentIndex = 0;
  int get index => currentIndex;
  set index(int index) => currentIndex = index;
  TabBarBloc() : super(TabBarInitial()){
    on<TabBarItemTappedEvent>((event, emit) {
      currentIndex = event.index;
      emit(TabBarItemSelectedState(index: currentIndex));
    });
  }
}





