import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/fitness_log.dart';
import '../services/firebase_service.dart';

class FitnessScreen extends StatefulWidget {
  const FitnessScreen({super.key});

  @override
  _FitnessScreenState createState() => _FitnessScreenState();
}

class _FitnessScreenState extends State<FitnessScreen> {
  final TextEditingController _stepsController = TextEditingController();

  @override
  void dispose() {
    _stepsController.dispose();
    super.dispose();
  }

  void _addFitnessLog() {
    if (_stepsController.text.isNotEmpty) {
      final log = FitnessLog(
        id: const Uuid().v4(),
        steps: int.parse(_stepsController.text),
        date: DateTime.now(),
      );
      Provider.of<FirebaseService>(context, listen: false).addFitnessLog(log);
      _stepsController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitness Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _stepsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter Steps',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addFitnessLog,
              child: const Text('Log Steps'),
            ),
          ],
        ),
      ),
    );
  }
}