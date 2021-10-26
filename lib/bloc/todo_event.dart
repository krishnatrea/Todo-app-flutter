part of 'todo_bloc.dart';

class GetAllTodo extends TodoEvent {
  @override
  List<Object?> get props => [];
}

class ClearAllTodo extends TodoEvent {
  @override
  List<Object?> get props => [];
}

class AddtodoEvent extends TodoEvent {
  final Tododata tododata;
  AddtodoEvent({
    required this.tododata,
  });
  @override
  List<Object?> get props => [tododata];
}

class DeltodoEvent extends TodoEvent {
  final Tododata tododata;
  DeltodoEvent({
    required this.tododata,
  });
  @override
  List<Object?> get props => [tododata];
}

class UpdattodoEvent extends TodoEvent {
  final Tododata tododata;
  UpdattodoEvent({
    required this.tododata,
  });
  @override
  List<Object?> get props => [tododata];
}

class TodoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}
