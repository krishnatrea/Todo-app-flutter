part of 'todo_bloc.dart';

class TodoState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TodoInitialState extends TodoState {}

class NotTodoListState extends TodoState {
  @override
  List<Object?> get props => [];
}

class TodoListState extends TodoState {
  final List<Tododata> todolist;
  TodoListState({
    required this.todolist,
  });
  @override
  List<Object?> get props => [todolist];
}
