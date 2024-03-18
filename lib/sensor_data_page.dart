import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter/animation.dart'; // for AnimationController, etc.

class SensorDataPage extends StatefulWidget {
  @override
  _SensorDataPageState createState() => _SensorDataPageState();
}

class _SensorDataPageState extends State<SensorDataPage>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          // Add UI components to display sensor readings here
          // For example, you can use Text widgets to display sensor values
          TweenAnimationBuilder(
            tween: Tween(begin: 100.0, end: 150.0),
            duration: const Duration(seconds: 2),
            curve: Curves.easeInOutCubic,
            builder: (_, double size, __) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: size,
                height: size,
                child: Stack(
                  children: [
                    // Sensor readings
                    const Center(
                      child: Text(
                        '60%',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Circular gradient overlay
                    Center(
                      child: Container(
                        width: size,
                        height: size,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              Colors.lightGreen.withOpacity(0.3),
                              Colors.lightGreen.withOpacity(0.05),
                              Colors.blue.withOpacity(0.1),
                              Colors.blue.withOpacity(0.1),
                              Colors.transparent
                            ],
                            stops: [0.0, 0.3, 0.5, 0.8, 1.0],
                            center: Alignment.center,
                            radius: 0.6,
                            tileMode: TileMode.repeated,
                            transform: GradientRotation(
                              _animation.value * 2 * pi,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          const Text(
            "Flex sensor Reading",
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          // Table for sensor data
          DataTable(
            columns: [
              const DataColumn(label: Text('')),
              const DataColumn(label: Text('Affected')),
              const DataColumn(label: Text('Healthy')),
            ],
            rows: [
              const DataRow(cells: [
                DataCell(Text('Finger 1')),
                DataCell(Text('Value')),
                DataCell(Text('Value')),
              ]),
              const DataRow(cells: [
                DataCell(Text('Finger 2')),
                DataCell(Text('Value')),
                DataCell(Text('Value')),
              ]),
              const DataRow(cells: [
                DataCell(Text('Finger 3')),
                DataCell(Text('Value')),
                DataCell(Text('Value')),
              ]),
              const DataRow(cells: [
                DataCell(Text('Finger 4')),
                DataCell(Text('Value')),
                DataCell(Text('Value')),
              ]),
              const DataRow(cells: [
                DataCell(Text('Finger 5')),
                DataCell(Text('Value')),
                DataCell(Text('Value')),
              ]),
              // Add more rows as needed
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            "Myoware sensor Reading",
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          const Text("Healthy hand reading"),
          const SizedBox(height: 20),
          const Text("Affected hand reading"),
        ],
      ),
    );
  }
}
