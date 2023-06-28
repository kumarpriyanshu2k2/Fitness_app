import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fitness_app/core/service/firebase_storage_service.dart';
import 'package:fitness_app/core/service/user_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'edit_account_event.dart';
part 'edit_account_state.dart';

class EditAccountBloc extends Bloc<EditAccountEvent, EditAccountState> {
  EditAccountBloc() : super(EditAccountInitial()){
    on<UploadImage>((event, emit) async{
      try {
        final XFile? image =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (image != null) {
          emit(EditAccountProgress());
          await FirebaseStorageService.uploadImage(filePath: image.path);
          emit(EditPhotoSuccess(image));
        }
      } catch (e) {
        emit( EditAccountError(e.toString()));
        await Future.delayed(Duration(seconds: 1));
        emit( EditAccountInitial());
      }
    });
    on<ChangeUserData>((event, emit) async {
      emit( EditAccountProgress());
      try {
        await UserService.changeUserData(
            displayName: event.displayName, email: event.email);
        emit( EditAccountInitial());
      } catch (e) {
        emit( EditAccountError(e.toString()));
        await Future.delayed(Duration(seconds: 1));
        emit(EditAccountInitial());
      };
    });
  }

  @override
  Stream<EditAccountState> mapEventToState(
    EditAccountEvent event,
  ) async* {
    if (event is UploadImage) {
      try {
        final XFile? image =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (image != null) {
          yield EditAccountProgress();
          await FirebaseStorageService.uploadImage(filePath: image.path);
          yield EditPhotoSuccess(image);
        }
      } catch (e) {
        yield EditAccountError(e.toString());
        await Future.delayed(Duration(seconds: 1));
        yield EditAccountInitial();
      }
    }
    if (event is ChangeUserData) {
      yield EditAccountProgress();
      try {
        await UserService.changeUserData(
            displayName: event.displayName, email: event.email);
        yield EditAccountInitial();
      } catch (e) {
        yield EditAccountError(e.toString());
        await Future.delayed(Duration(seconds: 1));
        yield EditAccountInitial();
      }
    }
  }
}
