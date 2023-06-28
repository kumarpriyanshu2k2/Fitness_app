import 'package:fitness_app/screens/maps/bloc/maps_bloc.dart';
import 'package:fitness_app/screens/maps/widget/maps_content.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MapsPage extends StatelessWidget {
  const MapsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContext(context),
    );
  }

  BlocProvider<MapsBloc> _buildContext(BuildContext context) {
    return BlocProvider<MapsBloc>(
      create: (BuildContext context) => MapsBloc(),
      child: BlocConsumer<MapsBloc, MapsState>(
        buildWhen: (_, currState) => currState is MapsInitial,
        builder: (context, state) {
          return MapsContent();
        },
        listenWhen: (_, currState) => true,
        listener: (context, state) {},
      ),
    );
  }
}
