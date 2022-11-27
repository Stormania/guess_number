import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const GuessMyNumber());
}

class GuessMyNumber extends StatelessWidget {
  const GuessMyNumber({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guess My Number',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Guess My Number'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _GuessNumberState();
}

class _GuessNumberState extends State<MyHomePage> {
  final TextEditingController controller = TextEditingController();
  String hintText = '';
  String? message = '';
  String? errorText;
  int randomNumber = Random().nextInt(100);
  bool correctNumber = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Guess My Number App',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            const Text(
              'Choose a number between 1 and 100',
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Card(
                elevation: 30,
                child: SizedBox(
                  height: 250,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          controller: controller,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Guess a number.',
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                            errorText: errorText,
                            errorStyle: const TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            '$message',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: ElevatedButton(
                            child: const Text('Check'),
                            onPressed: () {
                              // ignore: always_declare_return_types
                              checkNumber(int? guessNumber) {
                                setState(() {
                                  if (guessNumber == null) {
                                    errorText = 'Please enter a number!';
                                    message = '';
                                    controller.clear();
                                  } else {
                                    if (guessNumber == randomNumber) {
                                      // ignore: inference_failure_on_function_invocation
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('Congrats!'),
                                            content: Text(
                                              'You are correct. It is $randomNumber.',
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () => Navigator.pop(context, 'Reset'),
                                                child: const Text('Reset'),
                                              )
                                            ],
                                          );
                                        },
                                      );
                                      message = '';
                                      correctNumber = true;
                                      errorText = null;
                                    } else if (guessNumber < randomNumber) {
                                      message = 'Please try again a greater number.';
                                      errorText = null;
                                    } else {
                                      message = 'Please try again a smaller number.';
                                      errorText = null;
                                    }
                                    controller.clear();
                                  }
                                });
                              }

                              checkNumber(int.tryParse(controller.text));
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
