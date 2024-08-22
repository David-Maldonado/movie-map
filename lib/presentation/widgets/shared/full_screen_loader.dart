import 'package:flutter/material.dart';
class FlullScreenLoader extends StatelessWidget {
  const FlullScreenLoader({super.key});

  Stream<String> getLoadingMessages() {
    final messages = <String>[
      'Cargando películas',
      'Comprando pororo',
      'Cargando populares',
      'Llamando a mi novia',
      'Uff!! sigo esperando...',
      'Esto está tardando más de lo esperado 😕'
    ];
    return Stream.periodic(const Duration(milliseconds: 1200), (step) {
      return messages[step];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Espere por favor'),
          const SizedBox(height: 10),
          const CircularProgressIndicator(strokeWidth: 2),
          const SizedBox(height: 10),
          StreamBuilder(
            stream: getLoadingMessages(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) return const Text('Cargando...');

              return Text(snapshot.data);
            },
          ),
        ],
      ),
    );
  }
}
