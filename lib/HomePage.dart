import 'package:employee_bloc/Employee.dart';
import 'package:employee_bloc/EmployeeBlock.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final EmployeeBloc _employeeBloc = EmployeeBloc();

  @override
  void dispose() {
    _employeeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 199, 187, 80),
        title: Text("Employee App"),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: StreamBuilder<List<Employee>>(
          stream: _employeeBloc.employeeListStream,
          builder:
              (BuildContext context, AsyncSnapshot<List<Employee>> snapshot) {
            return ListView.builder(
              itemCount: snapshot.hasData ? snapshot.data!.length : 0,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      EdgeInsets.only(top: index == 0 ? 0 : 8.0, bottom: 8.0),
                  child: Card(
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(20.0),
                          child: Text(
                            "${snapshot.data![index].id}.",
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${snapshot.data![index].name}.",
                                  style: TextStyle(fontSize: 18.0),
                                ),
                                Text(
                                  "₹ ${snapshot.data![index].salary}.",
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: IconButton(
                            icon: Icon(Icons.thumb_up_sharp),
                            color: Colors.green,
                            onPressed: () {
                              if (snapshot.hasData &&
                                  index < snapshot.data!.length) {
                                _employeeBloc.employeeSalaryIncrement
                                    .add(snapshot.data![index]);
                              }
                            },
                          ),
                        ),
                        Container(
                          child: IconButton(
                            icon: Icon(Icons.thumb_down_sharp),
                            color: Colors.red,
                            onPressed: () {
                              if (snapshot.hasData &&
                                  index < snapshot.data!.length) {
                                _employeeBloc.employeeSalaryDecrement
                                    .add(snapshot.data![index]);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
