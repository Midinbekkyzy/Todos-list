part of 'todo_bloc.dart';

sealed class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

final class TodoInitial extends TodoState {}

final class LoadingTodoState extends TodoState {}

final class ErrorTodoState extends TodoState {}

final class LoadedTodoState extends TodoState {
  const LoadedTodoState({required this.list});

  final List<TodoModel> list;

  @override
  List<Object> get props => [list];
}
