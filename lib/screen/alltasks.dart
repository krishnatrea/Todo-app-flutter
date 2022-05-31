import 'package:dart_date/src/dart_date.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todoapp/bloc/todo_bloc.dart';
import 'package:todoapp/constants/uiconstants.dart';
import 'package:todoapp/models/todo.dart';
import 'package:todoapp/screen/newpage.dart';
import 'package:todoapp/widget/todolistile.dart';

class AllTAsks extends StatefulWidget {
  const AllTAsks({Key? key}) : super(key: key);

  @override
  State<AllTAsks> createState() => _AllTAsksState();
}

class _AllTAsksState extends State<AllTAsks> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TodoBloc>(context).add(GetAllTodo());
  }

  getalltaskslist(List<Tododata> todolist, BuildContext context) {
    List<Widget> rlist = [];
    todolist = todolist.reversed.toList();
    var padding = EdgeInsets.symmetric(vertical: 10.h);
    if (todolist.isNotEmpty) {
      DateTime date = todolist[0].createdAt;
      rlist.add(date.isToday
          ? Padding(
              padding: EdgeInsets.all(5.w),
              child: Text(
                "Today",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
              ),
            )
          : Padding(
              padding: EdgeInsets.all(5.w),
              child: Text(
                formatDate(date, ['dd', ' ', 'M']),
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
              ),
            ));
      for (int i = 0; i < todolist.length; i++) {
        // if next reservation date is same as date of previous then skip
        //else add next date and ReservationListView(List Tile for reservation info) to list
        if (date.day == todolist[i].createdAt.day &&
            date.month == todolist[i].createdAt.month &&
            date.year == todolist[i].createdAt.year) {
        } else {
          date = todolist[i].createdAt;
          rlist.add(Padding(
            padding: EdgeInsets.all(5.h),
            child: Text(
              formatDate(date, ['dd', ' ', 'M']),
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
            ),
          ));
        }
        rlist.add(TodoListTile(tododata: todolist[i]));
      }
    }
    return rlist;
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }

  Column customAppbar() {
    return Column(
      children: [
        SizedBox(
          height: 130.h,
          child: Container(
            color: const Color(0xff2A2362),
            padding: EdgeInsets.only(top: 51.h, left: 25.w),
            child: Column(children: [
              Row(
                children: [
                  SizedBox(
                    width: 190.w,
                    child: Text(greeting(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2),
                  ),
                  SizedBox(
                    width: 90.w,
                  ),
                  SizedBox(
                      height: 43.h,
                      width: 43.w,
                      child: Image.asset("assets/images/Group 2.png")),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
            ]),
          ),
        ),
      ],
    );
  }

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        customAppbar(),
        Expanded(
          child: SizedBox(
            height: 496.h,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.h),
              child: Container(
                color: Colors.white,
                child: BlocBuilder<TodoBloc, TodoState>(
                    buildWhen: (previous, current) => true,
                    builder: (context, state) {
                      if (state is TodoInitialState) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is TodoListState) {
                        List<Tododata> todolist = [];
                        todolist = state.todolist
                          ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
                        return todolist.isNotEmpty
                            ? ListView(
                                children: getalltaskslist(todolist, context),
                              )
                            : const NewPage();
                      }
                      return Container();
                    }),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
