// import 'dart:ffi';

import 'package:bcrypt/bcrypt.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:user_management/gql/config/grphql_config.dart';
import 'package:user_management/gql/model/user_model.dart';

class GraphQLQueryServices {
  static GrphQLConfig graphQLConfig = GrphQLConfig();
  GraphQLClient client = graphQLConfig.clientToQuery();

  Future<List<UserModel>> getAllUsers() async {
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
          List<UserModel> users = userDetail.map((user) {
            return UserModel.fromMap(map: user);
          }).toList();
          return users;
        }
      }
    } catch (err) {
      throw Exception(err);
    }
  }

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
      throw Exception(err);
    }
  }
}
