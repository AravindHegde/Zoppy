import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zoppyui/AppPages/Dashboard/dashboard.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zoppyui/Utility/SecureStorage.dart';
import 'package:zoppyui/Utility/constants.dart' as constants;

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _password2Controller = TextEditingController();
  String _nameErrorMessage = '';
  String _phoneErrorMessage = '';
  String _passwordErrorMessage = '';
  String _password2ErrorMessage = '';
  String _errorMessage = '';

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor : constants.themeColorCode,
        flexibleSpace: Center(
          child: Image.asset('assets/images/logo.png',
          fit: BoxFit.fill),
        )
      ),
      body:  Stack(
        children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child:Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400.0),
                  child:  Column(
                    children: [
                      const SizedBox(height: 20),
                      const Text('Welcome to Zoppy',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextField(
                        controller: _nameController,
                        style: const TextStyle(color: Colors.black),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.person),
                            prefixIconColor: MaterialStateColor.resolveWith((states) =>
                              states.contains(MaterialState.focused)
                                  ? constants.themeColorCode
                                  : Colors.grey),
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: "Full Name",
                            errorText: _nameErrorMessage.isNotEmpty ? _nameErrorMessage:null,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: constants.themeColorCode)
                            )
                        ),
                        onChanged: (text) {
                          // Clear the error text when the user starts editing
                          setState(() {
                            _nameErrorMessage = '';
                            _errorMessage = '';
                          });
                        }
                      ),
                      const SizedBox(height: 30),
                      TextField(
                        controller: _phoneController,
                        style: const TextStyle(color: Colors.black),
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10)],
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.phone_android),
                            prefixIconColor: MaterialStateColor.resolveWith((states) =>
                              states.contains(MaterialState.focused)
                                  ? constants.themeColorCode
                                  : Colors.grey),
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: "Phone Number",
                            errorText: _phoneErrorMessage.isNotEmpty ? _phoneErrorMessage:null,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: constants.themeColorCode)
                            )
                        ),
                        onChanged: (text) {
                          // Clear the error text when the user starts editing
                          setState(() {
                            _phoneErrorMessage = '';
                            _errorMessage = '';
                          });
                        }
                      ),
                      const SizedBox(height: 30),
                      TextField(
                        controller: _passwordController,
                        style: const TextStyle(),
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            prefixIconColor: MaterialStateColor.resolveWith((states) =>
                              states.contains(MaterialState.focused)
                                  ? constants.themeColorCode
                                  : Colors.grey),
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: "Password",
                            errorText:_passwordErrorMessage.isNotEmpty ? _passwordErrorMessage:null,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: constants.themeColorCode)
                            )
                        ),
                        onChanged: (text) {
                          // Clear the error text when the user starts editing
                          setState(() {
                            _passwordErrorMessage = '';
                            _errorMessage = '';
                          });
                        }
                      ),
                      const SizedBox(height: 30),
                      TextField(
                        controller: _password2Controller,
                        style: const TextStyle(),
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            prefixIconColor: MaterialStateColor.resolveWith((states) =>
                              states.contains(MaterialState.focused)
                                  ? constants.themeColorCode
                                  : Colors.grey),
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: "Re-enter Password",
                            errorText:_password2ErrorMessage.isNotEmpty ? _password2ErrorMessage:null,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: constants.themeColorCode)
                            )
                        ),
                        onChanged: (text) {
                          // Clear the error text when the user starts editing
                          setState(() {
                            _password2ErrorMessage = '';
                            _errorMessage = '';
                          });
                        }
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Sign Up',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w700),
                          ),
                          CircleAvatar(
                            radius: 26,
                            backgroundColor: constants.themeColorCode,
                            child: IconButton(
                                color: Colors.white,
                                onPressed: () async{
                                  if(await signUp()){
                                    if (!context.mounted) return;
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(builder: (context) => const Dashboard()), // Replace NewPage with your desired page
                                      (route) => false, // This function ensures that all previous pages are removed
                                    );
                                  }
                                },
                                icon: const Icon(
                                  Icons.arrow_forward,
                                )),
                                
                          ),
                          
                        ],
                      ),
                      Visibility(
                        visible: _errorMessage.isNotEmpty?true:false,
                        child: Text(
                          _errorMessage,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text('Already have an Account? ',
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Sign In',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: constants.themeColorCode,
                                fontSize: 18,
                              ),
                            )
                          ),
                        ]
                      )
                    ]
                  )
                )
              )
            )
        ],
      ),
    );
  }

  Future<bool> signUp() async {
    if(_nameController.text.isEmpty){
      setState(() {
        _nameErrorMessage = 'Name can\'t be empty';
      });
    }
    else if(_phoneController.text.length < 10){
      setState(() {
        _phoneErrorMessage = 'Mobile Number must be 10 digit'; //Error
      });
    }
    else if(_passwordController.text.length < 6 ){
      setState(() {
        _passwordErrorMessage = 'Password must be atleast 6 characters';
      });
    }
    else if(_passwordController.text != _password2Controller.text){
      setState(() {
        _password2ErrorMessage = 'Passwords do not match';
      });
    }
    else{
      final Map<String, String> data = {
        'name' : _nameController.text,
        'phone': _phoneController.text,
        'password': _passwordController.text,
      };
      final String jsonData = jsonEncode(data);
      final response =await http.post(
        Uri.parse(constants.baseURL+'signUp'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonData,
      );
      if (response.statusCode == 200) {
        String token = '';
        Map<String, dynamic> responseData = json.decode(response.body);
        if(responseData.containsKey('token')){
          token = responseData['token'];
        }
        SecureStorage secureStorage = SecureStorage();
        await secureStorage.initialize();
        secureStorage.setToken(token);
        return true;
      } else {
        setState(() {
          _errorMessage = response.body;
        });
      }
    }
    return false;
  }
}