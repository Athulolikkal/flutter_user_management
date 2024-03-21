import 'package:flutter/material.dart';
import 'package:user_management/gql/query/mutation.dart';
// import 'package:get_storage/get_storage.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _userNameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final GraphQLMutationServices graphQlMutationServices =
      GraphQLMutationServices();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Add User",
                style: TextStyle(fontSize: 20),
              ),
              TextFormField(
                controller: _emailController,
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
              ),
              TextFormField(
                controller: _userNameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  hintText: 'Please enter your email',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  hintText: 'Please enter your password',
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter the password';
                  } else if (value.length > 8) {
                    return 'maximum 8 letters';
                  } else if (value.length < 4) {
                    return 'minimum 4 letters';
                  } else {
                    return null;
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Visibility(
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
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
                      setState(() {
                        isLoading = true;
                      });
                      isUserAdd(context);
                    },
                    icon: const Icon(Icons.person),
                    label: isLoading
                        ? const CircularProgressIndicator()
                        : const Text('Add'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void isUserAdd(BuildContext cntx) async {
    final _email = _emailController.text;
    final _password = _passwordController.text;
    final _name = _userNameController.text;
    if (_email.isNotEmpty && _password.isNotEmpty && _name.isNotEmpty) {
      final Map<String, dynamic> Details = await graphQlMutationServices
          .addUserDetails(email: _email, password: _password, username: _name);
      if (Details['Error'] == true) {
        final errorMessage = Details['message'];
        ScaffoldMessenger.of(cntx).showSnackBar(SnackBar(
          content: Text(errorMessage),
          margin: const EdgeInsets.all(10),
          behavior: SnackBarBehavior.floating,
          backgroundColor: const Color.fromARGB(255, 31, 30, 30),
          duration: const Duration(seconds: 2),
        ));
        Navigator.of(cntx).pop();
      } else {
        ScaffoldMessenger.of(cntx).showSnackBar(const SnackBar(
          content: Text("successfully added the user"),
          margin: EdgeInsets.all(10),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Color.fromARGB(255, 43, 159, 27),
          duration: Duration(seconds: 2),
        ));
        _emailController.clear();
        _passwordController.clear();
        _userNameController.clear();
        Navigator.of(cntx).pop(true);

        // Navigator.of(cntx).pushReplacement(
        //   MaterialPageRoute(builder: (cntx) => HomeScreen()),
        // );
      }
    } else {
      ScaffoldMessenger.of(cntx).showSnackBar(const SnackBar(
        content: Text('Please enter all the details'),
        margin: EdgeInsets.all(10),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.fromARGB(255, 31, 30, 30),
        duration: Duration(seconds: 2),
      ));
      Navigator.of(cntx).pop();
    }
  }
}
