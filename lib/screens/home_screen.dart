import 'package:flutter/material.dart';
import 'package:user_management/gql/query/query.dart';
import 'package:user_management/screens/userInfo.dart';
import 'package:user_management/widgets/custom_app.dart';
import 'package:user_management/widgets/user_dialog.dart';
import 'package:user_management/widgets/modal_adduser.dart';
import 'package:user_management/widgets/user_edit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GraphQLQueryServices graphQLService = GraphQLQueryServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        name: 'CRUD',
      ),
      body: FutureBuilder(
          future: graphQLService.getAllUsers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              if (snapshot.data!.isNotEmpty) {
                return SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: ListView.separated(
                        itemBuilder: (ctx, index) {
                          return ListTile(
                            title: Text(snapshot.data![index]['name']),
                            subtitle: Text(snapshot.data![index]['email']),
                            leading: const CircleAvatar(
                              backgroundColor: Colors.green,
                            ),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (cntx) => UserInfo(
                                        userName: snapshot.data![index]['name'],
                                        email: snapshot.data![index]['email'],
                                      )));
                            },
                            onLongPress: () {
                              AlertDialogs.deleteUser(
                                      context,
                                      'Delete User',
                                      '''Are you sure do you want to delete ${snapshot.data![index]['name']}?''',
                                      snapshot.data![index]['id'])
                                  .then((value) => {
                                        if (value == true) {setState(() {})}
                                      });
                            },
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit,
                                      color: Colors.blue),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return EditUser(
                                            userName: snapshot.data![index]
                                                ['name'],
                                            email: snapshot.data![index]
                                                ['email'],
                                            id: snapshot.data![index]['id'],
                                          );
                                        }).then((value) => {
                                          if (value == true)
                                            {setState(() => {})}
                                        });
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () {
                                    AlertDialogs.deleteUser(
                                            context,
                                            'Delete User',
                                            '''Are you sure do you want to delete ${snapshot.data![index]['name']}?''',
                                            snapshot.data![index]['id'])
                                        .then((value) => {
                                              if (value == true)
                                                {setState(() {})}
                                            });
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (ctx, index) {
                          return const Divider();
                        },
                        itemCount: snapshot.data!.length),
                  ),
                );
              } else {
                return const SafeArea(child: Center(child: Text('No Data')));
              }
            } else if (snapshot.hasError) {
              return const Text('Unable to fetch user details');
            }
            return const Center(child: CircularProgressIndicator());
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return const AddUser();
                  },
                  isScrollControlled: true)
              .then((value) {
            if (value == true) {
              setState(() {});
            }
          });
          // print('print is happend');
        },
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: const Icon(Icons.add),
      ),
    );
  }
}
