import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';



class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  int pageIndex = 0;

  final pageController = PageController(initialPage: 0);
  OnboardingBloc() : super(OnboardingInitial()){
    on<PageChangedEvent>((event,emit){
      if (pageIndex == 2) {
        emit(NextScreenState());
        return;
      }
      pageIndex += 1;

      pageController.animateToPage(

        pageIndex,
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );

      emit(PageChangedState(counter: pageIndex));

    });
    on<PageSwipedEvent>((event, emit){
        pageIndex = event.index;
        emit(PageChangedState(counter: pageIndex));
    });
    }
  }







