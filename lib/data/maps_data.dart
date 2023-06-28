import 'package:fitness_app/data/exercise_data.dart';

class MapsData {
  final String title;
  final String exercices;
  final String minutes;
  final int currentProgress;
  final int progress;
  final String image;
  final List<ExerciseData> exerciseDataList;

  MapsData({
    required this.title,
    required this.exercices,
    required this.minutes,
    required this.currentProgress,
    required this.progress,
    required this.image,
    required this.exerciseDataList,
  });

  @override
  String toString() {
    return 'WorkoutData(title: $title, exercices: $exercices, minutes: $minutes, currentProgress: $currentProgress, progress: $progress, image: $image, exerciseDataList: $exerciseDataList)';
  }
}
