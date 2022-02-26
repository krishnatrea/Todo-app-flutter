import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todoapp/models/todo.dart';
import 'package:todoapp/screen/addtodo.dart';
import 'package:todoapp/screen/landingpage.dart';
import 'package:uuid/uuid.dart';
import '/bloc/todo_bloc.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  static changeindex(BuildContext context, int i){
    var state = context.findAncestorStateOfType<_HomeState>();
      state!.changeindex(i);
  }
  @override
  State<Home> createState() => _HomeState();
}
 
class _HomeState extends State<Home> {
  List<Widget> pages =  [const LandingPage(), AddTodo() , Container()];
  static int index = 0;
  void changeindex(int i){
    index = i;
    setState(() {
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Tododata data = Tododata(id: Uuid().v1(), title: "New", description: "todo", catagory: "non", done: 0, deleted: 0, createdAt: DateTime.now().subtract(Duration(days: 2)));
          BlocProvider.of<TodoBloc>(context).add(AddtodoEvent(tododata: data));
        },
      ),
      bottomNavigationBar: bottomnav(),
      body: SafeArea(
        child: pages[index],
      ),
    );
  }



  BottomNavigationBar bottomnav() {
    return BottomNavigationBar(
      backgroundColor: const Color(0xff2A2362),
      iconSize: 40.h,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white38,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: (int i ) {
        index = i;
        setState((){});
      },
      currentIndex: index,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.dashboard_rounded,
            ),
            label: " "),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.add_box_rounded,
            ),
            label: " "),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.assessment,
            ),
            label: " "),
      ],
    );
  }
}


