import 'package:fitness_app/core/const/color_constants.dart';
import 'package:fitness_app/core/const/path_constants.dart';
import 'package:fitness_app/core/const/text_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';

class HomeStatistics extends StatefulWidget {
  const HomeStatistics({Key? key}) : super(key: key);

  @override
  State<HomeStatistics> createState() => _HomeStatisticsState();
}

class _HomeStatisticsState extends State<HomeStatistics> {
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?', _steps = '?';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void onStepCount(StepCount event) {
    print(event);
    setState(() {
      _steps = event.steps.toString();
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    setState(() {
      _status = event.status;
    });
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available';
    });
    print(_status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      _steps = 'Step Count not available';
    });
  }

  void initPlatformState() {

    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);
    print(_status);
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _createComletedWorkouts(context),
          _createColumnStatistics(),
        ],
      ),
    );
  }

  Widget _createComletedWorkouts(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(15),
      height: 200,
      width: screenWidth * 0.35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorConstants.black,
        boxShadow: [
          BoxShadow(
            color: ColorConstants.textWhite.withOpacity(0.12),
            blurRadius: 5.0,
            spreadRadius: 1.1,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [

              Image(
                image: AssetImage(
                  PathConstants.footsteps,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  TextConstants.finished,
                  style: TextStyle(
                    color: ColorConstants.textWhite,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.fade,
                  softWrap: false,
                ),
              ),
            ],
          ),
          Text(
            _steps.toString(),
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: ColorConstants.textWhite,
            ),
          ),
          Text(
            "/10000",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: ColorConstants.grey,
            ),
          ),
          Text(
            TextConstants.stepsCompleted,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: ColorConstants.textGrey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _createColumnStatistics() {
    return Column(
      children: [
        DataWorkouts(
          icon: PathConstants.inProgress,
          title: TextConstants.inProgress,
          count: 2,
          text: TextConstants.workouts,
        ),
        const SizedBox(height: 20),
        DataWorkouts(
          icon: PathConstants.timeSent,
          title: TextConstants.timeSent,
          count: 62,
          text: TextConstants.minutes,
        ),
      ],
    );
  }
}


class DataWorkouts extends StatefulWidget {


  final String icon;
  final String title;
  final int count;
  final String text;

  DataWorkouts({
    required this.icon,
    required this.title,
    required this.count,
    required this.text,
  });

  @override
  State<DataWorkouts> createState() => _DataWorkoutsState();
}

class _DataWorkoutsState extends State<DataWorkouts> {

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: 90,
      width: screenWidth * 0.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorConstants.black,
        boxShadow: [
          BoxShadow(
            color: ColorConstants.textWhite.withOpacity(0.12),
            blurRadius: 5.0,
            spreadRadius: 1.1,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Image(image: AssetImage(widget.icon)),
              const SizedBox(width: 10),
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: ColorConstants.textWhite,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                widget.count.toString(),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: ColorConstants.textWhite,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                widget.text,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: ColorConstants.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



