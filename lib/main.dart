import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Random random = Random();
  int x = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Expanded(
      child: Scaffold(
          appBar: AppBar(
            title: Center(child: const Text('lottry App')),
          ),
          body: Center(
            child: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('lottry app number is $x'),
                  const SizedBox(height: 20),
                  Container(
                    height: x >= 4 ? 600 : 200,
                    width: 300,
                    decoration: BoxDecoration(
                      color: x <= 4
                          ? Colors.green.withOpacity(.3)
                          : Colors.teal.withOpacity(.6),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: x >= 4
                          ? Center(
                              child: Expanded(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.done_all,
                                        color: Colors.green,
                                        size: 40,
                                      ),
                                      Text(
                                          'Conregulation you  win the lottry your number is $x '),
                                    ]),
                              ),
                            )
                          : Expanded(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.error,
                                      color: Colors.red,
                                      size: 40,
                                    ),
                                    Text(
                                        'sorry you loss the lottry , your number is $x '),
                                  ]),
                            ),
                    ),
                  )
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
              onPressed: (() {
                x = random.nextInt(10);
                setState(() {});
              }),
              child: const Icon(
                Icons.refresh,
              ))),
    ));
  }
}
