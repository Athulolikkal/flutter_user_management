import 'package:bcrypt/bcrypt.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:user_management/gql/config/grphql_config.dart';

class GraphQLMutationServices {
  static GrphQLConfig graphQLConfig = GrphQLConfig();
  GraphQLClient client = graphQLConfig.clientToQuery();

  //To add user
  Future<Map<String, dynamic>> addUserDetails(
      {required email, username, password}) async {
    try {
      if (email.isNotEmpty && username.isNotEmpty && password.isNotEmpty) {
        final String hashed = BCrypt.hashpw(password, BCrypt.gensalt());
        QueryResult result = await client.mutate(
            MutationOptions(fetchPolicy: FetchPolicy.noCache, document: gql('''
        mutation MyQuery {
        insert_users_one(object: {email: "$email", name: "$username", password: "$hashed"})
        {
         id
         }
        }
        ''')));
        if (result.hasException) {
          print(result.exception);
          return {"Error": true, "message": "faild to add details!"};
        } else {
          Map<String, dynamic>? userInfo = result.data!['insert_users_one'];
          if (userInfo != null) {
            return userInfo;
          } else {
            return {"Error": true, "message": "something went wrong"};
          }
        }
      }
      return {"Error": true, "message": "something went wrong"};
    } catch (err) {
      print(err);
      return {"Error": true, "message": "something went wrong"};
    }
  }

  Future<bool> deleteUser({required userId}) async {
    try {
      QueryResult result = await client.mutate(
          MutationOptions(fetchPolicy: FetchPolicy.noCache, document: gql(
            '''
             mutation MyQuery {
             delete_users(where: {id: {_eq: "$userId"}}) {
             returning {
             id
              }
            }
           }
          '''
        )));
      print(result);
      return true;
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<bool> updateUser({required userId,email,name}) async {
    try {
      QueryResult result = await client.mutate(
          MutationOptions(fetchPolicy: FetchPolicy.noCache, document: gql(
            '''
             mutation MyQuery {
             update_users(_set: {email: "$email", name: "$name"}, where: {id: {_eq: "$userId"}}) {
             returning {
             id
             email
             name
             }
            }
           }
          '''
        )));
      print(result);
      return true;
    } catch (err) {
      throw Exception(err);
    }
  }
}
