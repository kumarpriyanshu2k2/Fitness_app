part of 'maps_bloc.dart';

@immutable
abstract class MapsState {}

class MapsInitial extends MapsState {}

class ReloadImageState extends MapsState {}
