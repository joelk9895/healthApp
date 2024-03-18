import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WeeklyGraphPage extends StatefulWidget {
  @override
  _WeeklyGraphPageState createState() => _WeeklyGraphPageState();
}

class _WeeklyGraphPageState extends State<WeeklyGraphPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  double maxRadius = 180; // Maximum radius for sections

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000), // Set animation duration
    );
    _animation = Tween<double>(
      begin: 0, // Initial animation value
      end: maxRadius, // Final animation value (maximum radius)
    ).animate(_animationController);
    _animationController.forward(); // Start the animation
  }

  @override
  void dispose() {
    _animationController.dispose(); // Dispose the animation controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            'Weekly Pie Chart',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(
                        value: 30,
                        title: _animation.value > 60 ? 'Left' : '',
                        titleStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        gradient: LinearGradient(
                          colors: [
                            Colors.blue,
                            Color.fromARGB(255, 8, 71, 123)!
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        radius: _animation.value, // Use animated value
                      ),
                      PieChartSectionData(
                        value: 20,
                        gradient: LinearGradient(
                          colors: [
                            Colors.green,
                            Color.fromARGB(255, 8, 123, 85)!
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        titleStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        title: _animation.value > 60 ? 'Right' : '',
                        radius: _animation.value, // Use animated value
                      ),
                    ],
                    // You can customize other properties of the PieChartData here
                    startDegreeOffset: _animation
                        .value, // Set your desired start degree offset
                    sectionsSpace: 1,
                    centerSpaceRadius: 0,
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
