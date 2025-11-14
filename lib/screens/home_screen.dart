// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart'; // Para gerar IDs únicos para as tarefas
import '../models/task.dart';
import '../widgets/task_list_item.dart';
// Precisamos adicionar a dependência 'uuid' no seu pubspec.yaml:
// dependencies:
//   flutter:
//     sdk: flutter
//   uuid: ^4.3.3 // Adicione esta linha e execute 'flutter pub get'

const uuid = Uuid(); // Gerador de ID

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _selectedDay = DateTime.now();
  final List<Task> _allTasks = [
    Task(
      id: uuid.v4(),
      title: 'Responder e-mails da faculdade',
      date: DateTime(2023, 11, 11),
      isCompleted: false,
    ),
    Task(
      id: uuid.v4(),
      title: 'Revisar código Flutter',
      date: DateTime(2023, 11, 11),
      isCompleted: true,
    ),
    Task(
      id: uuid.v4(),
      title: 'Comprar frutas',
      date: DateTime(2023, 11, 12),
      isCompleted: false,
    ),
    Task(
      id: uuid.v4(),
      title: 'Ligar para a mãe',
      date: DateTime(2023, 11, 11),
      isCompleted: false,
    ),
  ];

  List<Task> get _tasksForSelectedDay {
    final tasks = _allTasks.where((task) {
      return task.date.year == _selectedDay.year &&
          task.date.month == _selectedDay.month &&
          task.date.day == _selectedDay.day;
    }).toList();

    tasks.sort((a, b) {
      if (a.isCompleted != b.isCompleted) {
        return a.isCompleted ? 1 : -1; 
      }
      return a.title.toLowerCase().compareTo(b.title.toLowerCase());
    });

    return tasks;
  }

  void _addTask(String title) {
    if (title.isEmpty) return;

    final newTask = Task(
      id: uuid.v4(),
      title: title,
      date: _selectedDay,
      isCompleted: false, 
    );

    setState(() {
      _allTasks.add(newTask);
    });
  }

  void _removeTask(String taskId) {
    setState(() {
      _allTasks.removeWhere((task) => task.id == taskId);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Tarefa removida com sucesso!')),
    );
  }

  void _toggleTaskCompletion(String taskId) {
    final taskIndex = _allTasks.indexWhere((task) => task.id == taskId);

    if (taskIndex >= 0) {
      final existingTask = _allTasks[taskIndex];
      final updatedTask = existingTask.copyWith(
        isCompleted: !existingTask.isCompleted,
      );

      setState(() {
        _allTasks[taskIndex] = updatedTask;
      });
    }
  }

  void _showAddTaskDialog() {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Adicionar Nova Tarefa'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(labelText: 'Descrição da Tarefa'),
          onSubmitted: (_) {
            _addTask(controller.text);
            Navigator.of(ctx).pop();
          },
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
          ElevatedButton(
            child: const Text('Adicionar'),
            onPressed: () {
              _addTask(controller.text);
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  void _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDay,
      firstDate: DateTime(2023),
      lastDate: DateTime(2026),
    );

    if (picked != null && picked != _selectedDay) {
      setState(() {
        _selectedDay = picked;
      });
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    Widget taskListContent = _tasksForSelectedDay.isEmpty
        ? const Center(
            child: Text(
              'Nenhuma tarefa para este dia!',
              style: TextStyle(fontSize: 18, color: Colors.black54),
            ),
          )
        : ListView.builder(
            itemCount: _tasksForSelectedDay.length,
            itemBuilder: (ctx, index) {
              final task = _tasksForSelectedDay[index];
              return TaskListItem(
                task: task,
                onToggleCompletion: _toggleTaskCompletion,
                onRemove: _removeTask,
              );
            },
          );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda Diária'),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: const Icon(Icons.add, size: 30, color: Colors.white),
      ),
      
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Bem Vindo, Emilio!',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.black87),
              ),
              Text(
                'Dia ${_formatDate(_selectedDay)}',
                style: const TextStyle(fontSize: 22, color: Colors.black54),
              ),
              const SizedBox(height: 20),

              Card(
                color: Theme.of(context).primaryColor.withOpacity(0.95),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                     
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Data Selecionada: ${_formatDate(_selectedDay)}',
                            style: const TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          const Icon(Icons.calendar_today, color: Colors.white70),
                        ],
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton.icon(
                        onPressed: _selectDate,
                        icon: const Icon(Icons.edit_calendar, color: Colors.white),
                        label: const Text(
                          'Selecionar o dia',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.secondary,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),

              Card(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  constraints: BoxConstraints(
                    minHeight: isLandscape ? 200 : 300, 
                    maxHeight: isLandscape ? 400 : 500,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tarefas para o dia ${_formatDate(_selectedDay)}:',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                      ),
                      const Divider(),
                      Expanded(
                        child: taskListContent,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}