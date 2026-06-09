import 'package:flutter/material.dart';

import 'models/task.dart';
import 'repositories/task_repository.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lista de Tarefas',
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TaskRepository repository = TaskRepository();

  final TextEditingController taskController =
      TextEditingController();

  final TextEditingController idController =
      TextEditingController();

  List<Task> tasks = [];

  int? editingId;

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  Future<void> loadTasks() async {
  print("Carregando Atividades");

  tasks = await repository.getAll();

  print(tasks.length);

  setState(() {});
  }

  Future<void> addTask() async {
    if (taskController.text.isEmpty) return;

    Task task = Task(
      task: taskController.text,
      done: 0,
      created: DateTime.now().toString(),
    );

    await repository.insert(task);

    taskController.clear();

    loadTasks();
  }

  Future<void> updateTask() async {
    if (editingId == null) return;

    Task task = Task(
      id: editingId,
      task: taskController.text,
      done: 0,
      created: DateTime.now().toString(),
    );

    await repository.update(task);

    editingId = null;

    taskController.clear();

    loadTasks();
  }

  Future<void> deleteTask(int id) async {
    await repository.delete(id);

    loadTasks();
  }

  Future<void> searchById() async {
    if (idController.text.isEmpty) return;

    Task? task = await repository.getById(
      int.parse(idController.text),
    );

    if (task == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("ATIVIDADE NÃO ENCONTRADA"),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text(
            "ATIVIDADE\nENCONTRADA",
            textAlign: TextAlign.center,
          ),
          content: Text(
            "ID: ${task.id}\n"
            "Ação: ${task.task}",
          ),
        );
      },
    );
  }

  void editTask(Task task) {
    editingId = task.id;

    taskController.text = task.task;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("MINHAS ATIVIDADES"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            TextField(
              controller: taskController,
              decoration: const InputDecoration(
                labelText: "Digite sua atividade",
                filled: true,
                fillColor: Color.fromARGB(255, 202, 202, 202),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                      side: const BorderSide(
                        color: Colors.black,
                        width: 2,
                      )
                    ),
                    onPressed: addTask,
                    child: const Text("ADICIONAR"),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                      side: const BorderSide(
                        color: Colors.black,
                        width: 2,
                      )
                    ),
                    onPressed: updateTask,
                    child: const Text("ATUALIZAR"),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            TextField(
              controller: idController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: const InputDecoration(
                labelText: "Pesquisar pelo ID",
                filled: true,
                fillColor: Color.fromARGB(255, 202, 202, 202),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                side: const BorderSide(
                  color: Colors.black,
                  width: 2,
                )
              ),
              onPressed: searchById,
              child: const Text("PESQUISAR"),
            ),

            const SizedBox(height: 20),

            const Text(
              "ATIVIDADES A REALIZAR",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "TOTAL DE ATIVIDADES: ${tasks.length}",
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),

            SizedBox(height:10),

            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];

                  return Card(
                    color: Color.fromARGB(255, 202, 202, 202),
                    elevation: 5,
                    child: ListTile(
                      title: Text(task.task),
                      subtitle: Text(
                        "ID: ${task.id}",
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () =>
                                editTask(task),
                          ),

                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () =>
                                deleteTask(task.id!),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}