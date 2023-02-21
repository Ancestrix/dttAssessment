import 'package:flutter/material.dart';

class SearchTextField extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SearchTextFieldState();
  }
}

class SearchTextFieldState extends State<SearchTextField>{
  final _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: TextField(
            controller: _usernameController,
            onChanged: (text) {
              setState(() {});
            },
            decoration: InputDecoration(
                labelText: 'Username',
                suffixIcon: _usernameController.text.isNotEmpty
                    ? IconButton(
                    onPressed: () {
                      _usernameController.clear();
                      setState(() {});
                    },
                    icon: const Icon(Icons.cancel, color: Colors.grey))
                    : null),
          ),
        ),
      ),
    );
  }
}