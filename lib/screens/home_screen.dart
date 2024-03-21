import 'package:flutter/material.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';
// import 'package:user_management/gql/model/user_model.dart';
import 'package:user_management/gql/query/query.dart';
import 'package:user_management/widgets/custom_app.dart';
import 'package:user_management/widgets/modal_adduser.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final GraphQLQueryServices graphQLService = GraphQLQueryServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: FutureBuilder(
          future: graphQLService.getAllUsers(),
          builder: (context, snapshot) {
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
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit,
                                      color: Colors.blue),
                                  onPressed: () {
                                    print(
                                        'edit pressed ${snapshot.data![index]['id']}');
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () {
                                    print(
                                        'delete pressed ${snapshot.data![index]['id']}');
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

              // print(snapshot.data);
            } else if (snapshot.hasError) {
              return const Text('Unable to fetch user details');
            }
            return const Center(child: CircularProgressIndicator());
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext innerContext) {
                return AddUser();
              },
              isScrollControlled: true);
          // print('print is happend');
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }
}
