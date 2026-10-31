
import 'package:flutter/material.dart';

void main() {
  runApp(const MiOrganizadorApp());
}

class MiOrganizadorApp extends StatelessWidget {
  const MiOrganizadorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mi Organizador Personal',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2563EB),
        ),
        scaffoldBackgroundColor: const Color(0xFFF1F5F9),
        useMaterial3: true,
      ),
      home: const PantallaPrincipal(),
    );
  }
}

class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key});

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  final List<String> actividades = [
    'Estudiar Flutter',
    'Completar mis tareas',
  ];
  final Set<int> actividadesCompletadas = {};

  void agregarActividad() {
    final controlador = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Nueva actividad'),
          content: TextField(
            controller: controlador,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Escribe una actividad',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                final texto = controlador.text.trim();

                if (texto.isNotEmpty) {
                  setState(() {
                    actividades.add(texto);
                  });

                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('¡Actividad agregada correctamente!'),
                    ),
                  );
                }
              },
              child: const Text('Agregar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Organizador'),
        backgroundColor: const Color(0xFF172554),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '¡Hola Yuli!',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Organiza tus actividades y aprovecha tu día.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 25),
            const Text(
              'Mis actividades',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: actividades.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: Checkbox(
                      value: actividadesCompletadas.contains(index),
                      onChanged: (valor) {
                        setState(() {
                        if (valor == true) {
                        actividadesCompletadas.add(index);
                        } else {
                        actividadesCompletadas.remove(index);
                        }
                        });
                        },
                        ),
                        title: Text(
                          actividades[index],
                          style: TextStyle(
                            decoration: actividadesCompletadas.contains(index)
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                         trailing: IconButton(
                              icon: const Icon(
                              Icons.delete_outline,
                                color: Colors.deepOrange,
                              ),
                              onPressed: () {
                                setState(() {
                                  actividades.removeAt(index);
                                  actividadesCompletadas.remove(index);
                                });
                              },
                            ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: agregarActividad,
                icon: const Icon(Icons.add),
                label: const Text('Agregar actividad'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
