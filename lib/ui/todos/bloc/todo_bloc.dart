import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lesson5/data/models/todo_model.dart';
import 'package:lesson5/data/repository/todo_repository.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository _repo = TodoRepository();

  TodoBloc() : super(TodoInitial()) {
    on<GetTodosEvent>((event, emit) async {
      try {
        emit(LoadingTodoState());
        final list = await _repo.getTodos();
        emit(LoadedTodoState(list: list));
      } catch (e) {
        emit(ErrorTodoState());
      }
    });
  }
}
