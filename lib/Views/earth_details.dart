import 'dart:math';

import 'package:canopus/Provider/arguments_provider.dart';
import 'package:canopus/Provider/date_provider.dart';
import 'package:canopus/Provider/maps_provider.dart';
import 'package:canopus/Views/date_picker.dart';
import 'package:canopus/Views/fetching_screen.dart';
import 'package:canopus/Views/maps_screen.dart';
import 'package:canopus/Views/paramaters_screen.dart';
import 'package:canopus/Views/solar_irradiance.dart';
import 'package:canopus/Views/solar_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:parallax_rain/parallax_rain.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart' as rv;

class EarthDetail extends StatefulWidget {
  const EarthDetail({Key? key}) : super(key: key);

  @override
  State<EarthDetail> createState() => _EarthDetailState();
}

class _EarthDetailState extends State<EarthDetail> {
  late List<rv.RiveAnimationController> _controllers;
  static const List _spaceshipAnimations = [
    'back_spin',
    'idle_hover',
    'back_spin',
    'back_move',
    'choose_ani_1',
    'choose_ani_2',
    'choose_ani_3',
    'color_red',
    'color_blue',
    'color_green'
  ];
  @override
  void initState() {
    _controllers = _spaceshipAnimations
        .map((animationName) => rv.OneShotAnimation('$animationName'))
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _argumentsProvider = Provider.of<ArgumentsProvider>(context);
    final _dateProvider = Provider.of<DateProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xff100414),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xff100414),
                    Colors.blue,
                    Color(0xff100414),
                    Color(0xff100414)
                  ],
                ),
              ),
              height: MediaQuery.of(context).size.height / 3,
            ),
            ParallaxRain(
              dropColors: const [
                Colors.white,
                Colors.grey,
                Colors.blue,
                Colors.orange
              ],
              numberOfDrops: 30,
              dropFallSpeed: 2,
              numberOfLayers: 5,
              child: SafeArea(
                child: GestureDetector(
                  onTap: () {
                    final rand = Random().nextInt(_spaceshipAnimations.length);
                    _controllers[rand].isActive = true;
                  },
                  child: SizedBox(
                    width: 400,
                    height: 200,
                    child: rv.RiveAnimation.asset(
                      'assets/images/ship.riv',
                      controllers: _controllers,
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 2.4,
                  crossAxisSpacing: 50,
                  mainAxisSpacing: 50,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const MapsScreen(),
                        ),
                      ),
                      child: const Card(
                        shape: StadiumBorder(),
                        color: Color(0xff2C303B),
                        child: ListTile(
                          title: Center(
                            child: Text(
                              'Location',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 26,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const CanopusDatePicker())),
                      child: const Card(
                        shape: StadiumBorder(),
                        color: Color(0xff2C303B),
                        child: ListTile(
                          title: Center(
                            child: Text(
                              'Date',
                              style: TextStyle(
                                color: Colors.orange,
                                fontSize: 26,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const ParamaterScreen())),
                      child: const Card(
                        shape: StadiumBorder(),
                        color: Color(0xff2C303B),
                        child: ListTile(
                          title: Center(
                            child: Text(
                              'Parameters',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => SolarPanelScreen())),
                      child: const Card(
                        shape: StadiumBorder(),
                        color: Color(0xff2C303B),
                        child: ListTile(
                          title: Center(
                            child: Text(
                              'Solar panels',
                              style:
                                  TextStyle(color: Colors.green, fontSize: 26),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const SolarIrradianceScreen())),
                      child: const Card(
                        shape: StadiumBorder(),
                        color: Color(0xff2C303B),
                        child: ListTile(
                          title: Center(
                            child: Text(
                              'Solar energy',
                              style: TextStyle(
                                color: Colors.yellow,
                                fontSize: 23,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    _argumentsProvider.getArguments.isNotEmpty &&
                            _dateProvider.getStartDate.isNotEmpty
                        ? GestureDetector(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (_) => const FetchingScreen())),
                            child: const Card(
                              shape: StadiumBorder(),
                              color: Colors.red,
                              child: ListTile(
                                title: Center(
                                  child: Text(
                                    'Calculate!',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
