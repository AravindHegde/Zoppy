import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zoppyui/Utility/SecureStorage.dart';
import 'package:zoppyui/Utility/constants.dart' as constants; 



class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _passwordVisible = false;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _phoneErrorMessage = '';
  String _passwordErrorMessage = '';
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
        ) // Replace 'logo.png' with the actual path to your logo image.
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child:Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400.0),
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    const Text('Welcome, User!',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      controller: _phoneController,
                      style: TextStyle(color: Colors.black),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10)],
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone_android),
                          prefixIconColor: MaterialStateColor.resolveWith((states) =>
                            states.contains(MaterialState.focused)
                                ? constants.themeColorCode
                                : Colors.grey),
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: "Mobile Number",
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
                      obscureText: !_passwordVisible,
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
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                              color: Colors.black,
                              ),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                  _passwordVisible = !_passwordVisible;
                              });
                            },
                          )),
                      onChanged: (text) {
                        // Clear the error text when the user starts editing
                        setState(() {
                          _passwordErrorMessage = '';
                          _errorMessage = '';
                        });
                      }
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Sign in',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w700),
                        ),
                        CircleAvatar(
                          radius: 26,
                          backgroundColor: constants.themeColorCode,
                          child: IconButton(
                              color: Colors.white,
                              onPressed: () async{
                                if(await logIn()){
                                  if (!context.mounted) return;
                                  Navigator.popAndPushNamed(context, 'dashboard');
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          style: const ButtonStyle(),
                          onPressed: () {
                            Navigator.pushNamed(context, 
                             'signUp'
                            );
                          },
                          child: const Text(
                            'Sign Up',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: constants.themeColorCode,
                                fontSize: 18),
                          ),
                          
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Forgot Password',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: constants.themeColorCode,
                              fontSize: 18,
                            ),
                          )
                        ),
                      ],
                    )
                  ]
                )
              )
            )
          )
        ]
      )
    );
  }

  Future<bool> logIn() async {
    if(_phoneController.text.length < 10){
      setState(() {
        _phoneErrorMessage = 'Mobile Number must be 10 digit';
      });
    }
    else if(_passwordController.text.length < 6 ){
      setState(() {
        _passwordErrorMessage = 'Password must be atleast 6 characters';
      });
    }
    else{
      final Map<String, String> data = {
        'phone': _phoneController.text,
        'password': _passwordController.text,
      };
      final String jsonData = jsonEncode(data);
      final response =await http.post(
        Uri.parse(constants.baseURL+'logIn'),
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