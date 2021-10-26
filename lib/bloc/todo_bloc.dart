import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todoapp/database/database.dart';
import 'package:todoapp/models/todo.dart';

part 'todo_state.dart';
part 'todo_event.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc(TodoState initialState) : super(initialState);
  CustomDb db = CustomDb.instance;

  @override
  Stream<TodoState> mapEventToState(
    TodoEvent event,
  ) async* {
    if (event is GetAllTodo) {
      yield* mapGetAllTodoToState(event);
    } else if (event is ClearAllTodo) {
      yield* mapClearAlltodoToState(event);
    } else if (event is AddtodoEvent) {
      yield* mapAddTodoToState(event);
    } else if (event is DeltodoEvent) {
      yield* mapDeltodoEventToState(event);
    } else if (event is UpdattodoEvent) {
      yield* mapUpdattodoEvent(event);
    }
    else {
      yield NotTodoListState();
    }
  }

  Stream<TodoState> mapGetAllTodoToState(GetAllTodo event) async* {
    // Customkeys.navigationkey.currentState!.push(MaterialPageRoute(builder: (_) => const App()));
    yield TodoListState(todolist:  await db.todolist());
  }

  Stream<TodoState> mapClearAlltodoToState(ClearAllTodo event) async* {}

  Stream<TodoState> mapAddTodoToState(AddtodoEvent event) async* {
    await db.insertTodo(event.tododata);
    yield TodoListState(todolist:  await db.todolist());
  }

  Stream<TodoState> mapDeltodoEventToState(DeltodoEvent event) async* {
    await db.deletetodo(event.tododata.id);
    yield TodoListState(todolist: await db.todolist());
  }

  Stream<TodoState> mapUpdattodoEvent(UpdattodoEvent event) async* {
    await db.updateTodo(event.tododata);
    yield TodoListState(todolist: await db.todolist());
  }
}
