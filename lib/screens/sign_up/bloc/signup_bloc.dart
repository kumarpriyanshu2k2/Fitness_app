import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fitness_app/core/service/auth_service.dart';
import 'package:fitness_app/core/service/validation_service.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignUpBloc extends Bloc<SignupEvent, SignUpState> {
  SignUpBloc() : super(SignupInitial()){
    on<OnTextChangedEvent>((event, emit) {
      if (isButtonEnabled != checkIfSignUpButtonEnabled()) {
        isButtonEnabled = checkIfSignUpButtonEnabled();
        emit(SignUpButtonEnableChangedState(isEnabled: isButtonEnabled));
      }
    });
    on<SignUpTappedEvent>((event, emit) async{
      if (checkValidatorsOfTextField()) {
        try {
          emit( LoadingState());
          await AuthService.signUp(emailController.text, passwordController.text, userNameController.text);
          emit( NextTabBarPageState());
          print("Go to the next page");
        } catch (e) {
          print(e);
          emit (ErrorState(message: e.toString()));

      }
      } else {
      emit(ShowErrorState());
      }
    });
    on<SignInTappedEvent>((event, emit) {
      emit(NextSignInPageState());

    });

  }

  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isButtonEnabled = false;

  @override


  bool checkIfSignUpButtonEnabled() {
    return userNameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty;
  }

  bool checkValidatorsOfTextField() {
    return ValidationService.username(userNameController.text) &&
        ValidationService.email(emailController.text) &&
        ValidationService.password(passwordController.text) &&
        ValidationService.confirmPassword(passwordController.text, confirmPasswordController.text);
  }
}
