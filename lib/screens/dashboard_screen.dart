import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'calculator_screen.dart';
import 'todo_screen.dart';
import 'fitness_screen.dart';
import '../services/firebase_service.dart';
import '../widgets/weekly_chart.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Taskino Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Provider.of<FirebaseService>(context, listen: false).signOut(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Weekly Fitness Overview',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const WeeklyChart(),
            const SizedBox(height: 32),
            const Text(
              'Features',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildFeatureCard(
                  context,
                  icon: Icons.calculate,
                  title: 'Calculator',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CalculatorScreen()),
                  ),
                ),
                _buildFeatureCard(
                  context,
                  icon: Icons.list,
                  title: 'To-Do List',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TodoScreen()),
                  ),
                ),
                _buildFeatureCard(
                  context,
                  icon: Icons.fitness_center,
                  title: 'Fitness Tracker',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FitnessScreen()),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context,
      {required IconData icon, required String title, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          width: 100,
          height: 100,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 30, color: Colors.teal),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}