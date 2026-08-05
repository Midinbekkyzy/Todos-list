import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson5/ui/todos/bloc/todo_bloc.dart';

class TodosPage extends StatefulWidget {
  const TodosPage({super.key});

  @override
  State<TodosPage> createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
  final TodoBloc _todoBloc = TodoBloc();

  @override
  void initState() {
    _todoBloc.add(GetTodosEvent());
    super.initState();
  }

  @override
  void dispose() {
    _todoBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todos')),
      body: BlocBuilder<TodoBloc, TodoState>(
        bloc: _todoBloc,
        builder: (context, state) {
          if (state is LoadedTodoState) {
            return ListView.builder(
              itemCount: state.list.length,
              itemBuilder: (context, index) {
                final item = state.list[index];
                return ListTile(
                  title: Text(item.todo),
                  subtitle: Text(
                    item.completed ? 'готово' : 'не готово',
                  ),
                );
              },
            );
          }
          if (state is ErrorTodoState) {
            return Center(
              child: Text(
                'Error',
                style: TextStyle(fontSize: 30, color: Colors.red),
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
