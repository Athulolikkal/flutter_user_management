import 'package:flutter/material.dart';
import 'package:user_management/gql/query/query.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  GraphQLQueryServices graphQLQueryServices = GraphQLQueryServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Center(
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'Login',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                            labelText: 'Email',
                            hintText: 'Please enter your email',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please enter your valid email';
                           } else if(value.trim() != value){
                            return 'can\'t add white spaces';
                          
                          } else if (!value.contains('@')) {
                            return 'enter a proper email address';
                          } 
                          return null;
                        },
                      ),
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Please enter your password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please enter the password';
                        } else if (value.length > 8) {
                          return 'maximum 8 letters';
                        } else if (value.length < 4) {
                          return 'minimum 4 letters';
                        }else{
                          return null;
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: ElevatedButton.icon(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                            minimumSize:
                                MaterialStateProperty.all(const Size(400, 40)),
                            textStyle: MaterialStateProperty.all(const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10), // Set the border radius here
                              ),
                            )),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            checkLogin(context);
                          }
                        },
                        icon: const Icon(Icons.check),
                        label: const Text('Login'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ));
  }

  void checkLogin(BuildContext cntx)async {
    try {
      final _email = _emailController.text;
      final _password = _passwordController.text;
      print('call comes here');
   await graphQLQueryServices.getAllUsers();
      // if (_email == _password) {
      //   print('success');
      // } else {
      //   //snakBar
      //   ScaffoldMessenger.of(cntx).showSnackBar(SnackBar(
      //     content: Text('email and password doesn\'t match'),
      //     margin: EdgeInsets.all(10),
      //     behavior: SnackBarBehavior.floating,
      //     backgroundColor: Colors.red,
      //   ));

      //   //alert dialog
      //   // showDialog(context: cntx, builder: (cntx1){
      //   //   return AlertDialog(
      //   //     title: Text('Error'),
      //   //     content: Text('email and password doesn\'t match'),
      //   //     shape: RoundedRectangleBorder( // Custom shape for the AlertDialog
      //   //   borderRadius: BorderRadius.circular(5.0),
      //   // ),
      //   //     actions:[
      //   //       TextButton(onPressed: (){
      //   //         Navigator.of(cntx1).pop();
      //   //       }, child: Text('Close'))
      //   //     ]
      //   //   );
      //   // });
      // }
    } catch (err) {
      print('$err');
    }
  }
}
