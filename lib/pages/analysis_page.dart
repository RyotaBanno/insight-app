import 'package:flutter/material.dart';
import '../main.dart';

class AnalysisPage extends StatefulWidget {
  static const routeName = '/analysis';
  const AnalysisPage({super.key});

  @override
  State<AnalysisPage> createState() => _AnalysisPageState();
}

class _AnalysisPageState extends State<AnalysisPage> {
  late Future<String> _future;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    // ここでは AppScope.of(context) は呼ばない
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _future = AppScope.of(context).fetchAiAnalysis(userId: 'me');
      _initialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('個人分析（AI）')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FutureBuilder<String>(
            future: _future,
            builder: (context, snap) {
              if (!snap.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    snap.data!,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.6,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
