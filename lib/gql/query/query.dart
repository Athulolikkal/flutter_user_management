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
        print("print with exception $result");
      } else {
        print("print without exception $result");
      }
      return [];
    } catch (err) {
      throw Exception(err);
    }
  }
}
