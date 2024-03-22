import 'package:flutter/material.dart';
import 'package:user_management/gql/query/mutation.dart';

class AlertDialogs {
  static Future<bool> deleteUser(
    BuildContext context,
    String title,
    String body,
    String Id,
  ) async {
    GraphQLMutationServices graphQLMutationServices = GraphQLMutationServices();
    final action = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              title,
              style: const TextStyle(fontSize: 24),
            ),
            content: Text(body),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('Close')),
              TextButton(
                  onPressed: () async {
                    await graphQLMutationServices.deleteUser(userId: Id);
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('Confirm'))
            ],
          );
        });

    return action ?? false;
  }

  // static Future<bool> editUser(
  //   BuildContext context,
  //   String name,
  //   String email,
  //   String id,
  // ) async {
  //   try {
  //     final action = await showDialog(context: context, builder:(BuildContext context){
  //     return Container(

  //     );
  //     });
  //     return true;
  //   } catch (err) {
  //     print(err);
  //     return false;
  //   }
  // }
}
