import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fitness_app/core/const/text_constants.dart';
import 'package:fitness_app/core/service/user_service.dart';
import 'package:meta/meta.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc() : super(ChangePasswordInitial()){
    on<ChangePassword>((event, emit) async*{
      yield ChangePasswordProgress();
      try {
        await UserService.changePassword(newPass: event.newPass);
        emit(ChangePasswordSuccess(message: TextConstants.passwordUpdated));
        await Future.delayed(Duration(seconds: 1));
        emit( ChangePasswordInitial());
      } catch (e) {
        emit( ChangePasswordError(e.toString()));
        await Future.delayed(Duration(seconds: 1));
        emit( ChangePasswordInitial());
      }
    });
  }

  @override
  Stream<ChangePasswordState> mapEventToState(
    ChangePasswordEvent event,
  ) async* {
    if (event is ChangePassword) {
      yield ChangePasswordProgress();
      try {
        await UserService.changePassword(newPass: event.newPass);
        yield ChangePasswordSuccess(message: TextConstants.passwordUpdated);
        await Future.delayed(Duration(seconds: 1));
        yield ChangePasswordInitial();
      } catch (e) {
        yield ChangePasswordError(e.toString());
        await Future.delayed(Duration(seconds: 1));
        yield ChangePasswordInitial();
      }
    }
  }
}
