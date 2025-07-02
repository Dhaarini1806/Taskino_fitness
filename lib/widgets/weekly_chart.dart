// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import '../services/firebase_service.dart';
import '../models/fitness_log.dart';

class WeeklyChart extends StatelessWidget {
  const WeeklyChart({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<FitnessLog>>(
      stream: Provider.of<FirebaseService>(context).getWeeklyFitnessLogs(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final logs = snapshot.data!;
        final Map<int, int> weeklySteps = {0: 0, 1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0};
        for (var log in logs) {
          weeklySteps[log.date.weekday - 1] = log.steps;
        }

        return Container(
          height: 200,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 2, offset: Offset(2, 2))],
          ),
          child: BarChart(
            BarChartData(
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 40)),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                      return Text(days[value.toInt()]);
                    },
                  ),
                ),
                topTitles: AxisTitles(sideTitles: const SideTitles(showTitles: false)),
                rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              borderData: FlBorderData(show: false),
              barGroups: weeklySteps.entries
                  .map((entry) => BarChartGroupData(
                        x: entry.key,
                        barRods: [
                          BarChartRodData(
                            toY: entry.value.toDouble(),
                            color: Colors.teal,
                            width: 10,
                          ),
                        ],
                      ))
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}