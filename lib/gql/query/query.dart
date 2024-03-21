// import 'dart:ffi';

import 'package:bcrypt/bcrypt.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:user_management/gql/config/grphql_config.dart';


class GraphQLQueryServices {
  static GrphQLConfig graphQLConfig = GrphQLConfig();
  GraphQLClient client = graphQLConfig.clientToQuery();

//To find all users
  Future<List<dynamic>> getAllUsers() async {
    try {
      QueryResult result = await client.query(
          QueryOptions(fetchPolicy: FetchPolicy.noCache, document: gql('''
            query MyQuery {
             users {
                email
                id
                name
                   }
            }
        ''')));

      if (result.hasException) {
        // print(result.hasException);
        throw Exception(result.exception);
      } else {
        List? userDetail = result.data?['users'];

        if (userDetail == null || userDetail.isEmpty) {
          return [];
        } else {
          // print(userDetail);
          // List<UserModel> users = userDetail.map((user) {
          //   return UserModel.fromMap(map: user);
          // }).toList();
          // return users;
          return userDetail;
        }
      }
    } catch (err) {
      throw Exception(err);
    }
  }

//To get a specific user
  Future<dynamic> findUserByEmail({password, required email}) async {
    try {
      if (email != null && email.isNotEmpty) {}

      QueryResult result = await client.query(
          QueryOptions(fetchPolicy: FetchPolicy.noCache, document: gql('''
          query MyQuery {
          users(where: {email: {_eq: "$email"}}) {
          email
          id
          name
          password
           }
          }
''')));
      print('$result');
      if (result.hasException) {
        throw Exception(result.exception);
      } else {
        Map? userInfo =
            result.data?['users'].length > 0 ? (result.data?['users'][0]) : {};
        if (userInfo != null && userInfo.isNotEmpty) {
          if (password.isNotEmpty && password != null) {
            final String? dbPassword = userInfo['password'];

            if (dbPassword != null) {
              final bool checkPassword = BCrypt.checkpw(password, dbPassword);
              if (checkPassword == true) {
                return {
                  'status': true,
                  'name': userInfo['name'],
                  'email': userInfo['email'],
                  'message': 'login successfull'
                };
              } else {
                return {'status': false, 'message': 'login successfull'};
              }
            }
          }
          return {
            'status': true,
            'name': userInfo['name'],
            'email': userInfo['email'],
            'id': userInfo['id']
          };
        } else {
          return {'status': false, 'message': 'invalid email or password'};
        }
      }
    } catch (err) {
      print('$err');
      throw Exception(err);
    }
  }
}
