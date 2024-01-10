import 'dart:io';

void task1(){
  print('task 1');
}

void task2(){
  Duration duration = Duration(seconds: 5);
  Future.delayed(duration,(){
    print('task 1');
  });
}

void task3(){
  print('task 1');
}

