import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todoapp/bloc/todo_bloc.dart';
import 'package:todoapp/keys/globalkeys.dart';
import 'package:todoapp/screen/home.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodoBloc>(
      create: (context) => TodoBloc(TodoInitialState())..add(GetAllTodo()),
      child: ScreenUtilInit(
        designSize: const Size(386, 835),
        builder: () => 
        MaterialApp(
          navigatorKey: Customkeys.navigationkey,
          scaffoldMessengerKey: Customkeys.scaffholdkey,
          restorationScopeId: 'app',
          title: "Todo App",
          home: const Home(),
        ),
      ),
    );
  }
}
