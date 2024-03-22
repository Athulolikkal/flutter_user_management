import 'package:flutter/material.dart';
import 'package:user_management/gql/query/mutation.dart';

class EditUser extends StatefulWidget {
  final String userName;
  final String email;
  final String id;
  const EditUser(
      {super.key,
      required this.userName,
      required this.email,
      required this.id});

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  GraphQLMutationServices graphQLMutationServices = GraphQLMutationServices();
  final _formKey = GlobalKey<FormState>();
  String? _email = '';
  String? _name = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Card(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Edit User",
                      style: TextStyle(fontSize: 20),
                    ),
                    TextFormField(
                      // controller: _emailController,
                      initialValue: widget.email,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'Please enter your email',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please enter your valid email';
                        } else if (value.trim() != value) {
                          return 'can\'t add white spaces';
                        } else if (!value.contains('@')) {
                          return 'enter a proper email address';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _email = value;
                      },
                    ),
                    TextFormField(
                      // controller: _nameController,
                      initialValue: widget.userName,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        hintText: 'Please enter your name',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          print(value);
                          return 'please enter your name';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _name = value;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancel')),
                          Visibility(
                            child: ElevatedButton(
                              child: isLoading
                                  ? const CircularProgressIndicator()
                                  : Text('Update'),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.blue),
                                  foregroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  textStyle: MaterialStateProperty.all(
                                      const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10), // Set the border radius herehfkdshf
                                    ),
                                  )),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  if (_email != '' || _name != '') {
                                    // print('validated');
                                    setState(() => isLoading = true);
                                    await graphQLMutationServices.updateUser(
                                      userId: widget.id,
                                      email:
                                          _email != '' ? _email : widget.email,
                                      name:
                                          _name != '' ? _name : widget.userName,
                                    );
                                    Navigator.of(context).pop(true);
                                  } else {
                                    print('not validated');
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text("No data changed"),
                                      margin: EdgeInsets.all(10),
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor:
                                          Color.fromARGB(255, 31, 30, 30),
                                      duration: Duration(seconds: 2),
                                    ));
                                    Navigator.of(context).pop();
                                  }
                                }
                              },
                              // icon: const Icon(Icons.person),
                              // label: const Text('Update'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
