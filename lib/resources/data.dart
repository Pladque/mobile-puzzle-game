import 'package:flutter/material.dart';

class Data
{
  List get levelsInfo =>_levelsInfo;
  List get wordsInfo =>_wordsInfo;



  final _levelsInfo = [
    {'levelNumber': 0, 'ans': 24, 'solved': false},
    {'levelNumber': 1, 'ans': 31, 'solved': false},
    {'levelNumber': 2, 'ans': 5, 'solved': false},
    {'levelNumber': 3, 'ans': 2, 'solved': false},
    {'levelNumber': 4, 'ans': 162, 'solved': false},
    {'levelNumber': 5, 'ans': 84, 'solved': false},
    {'levelNumber': 6, 'ans': 3335, 'solved': false},
    {'levelNumber': 7, 'ans': 9, 'solved': false},
    {'levelNumber': 8, 'ans': 524, 'solved': false},
    {'levelNumber': 9, 'ans': 12, 'solved': false},
    // World 2
    {'levelNumber': 10, 'ans': 13, 'solved': false},
    {'levelNumber': 11, 'ans': 18, 'solved': false},
    {'levelNumber': 12, 'ans': 113, 'solved': false},
    {'levelNumber': 13, 'ans': 22, 'solved': false},
    {'levelNumber': 14, 'ans': 13, 'solved': false},
    {'levelNumber': 15, 'ans': 27, 'solved': false},
    {'levelNumber': 16, 'ans': 57, 'solved': false},
    {'levelNumber': 17, 'ans': 83, 'solved': false},
    {'levelNumber': 18, 'ans': 35, 'solved': false},
    {'levelNumber': 19, 'ans': 6, 'solved': false},    // 112588
    // World 3
    {'levelNumber': 20, 'ans': 67, 'solved': false},
    {'levelNumber': 21, 'ans': 49, 'solved': false},
    {'levelNumber': 22, 'ans': 151, 'solved': false},
    {'levelNumber': 23, 'ans': 100, 'solved': false},
    {'levelNumber': 24, 'ans': 3, 'solved': false},
    {'levelNumber': 25, 'ans': 921, 'solved': false},
    {'levelNumber': 26, 'ans': 46, 'solved': false},
    {'levelNumber': 27, 'ans': 0, 'solved': false},
    {'levelNumber': 28, 'ans': 3, 'solved': false},
    {'levelNumber': 29, 'ans': 7, 'solved': false},
    // World 4
    {'levelNumber': 30, 'ans': 68, 'solved': false},
    {'levelNumber': 31, 'ans': 16, 'solved': false},
    {'levelNumber': 32, 'ans': 125, 'solved': false},
    {'levelNumber': 33, 'ans': 0, 'solved': false},
    {'levelNumber': 34, 'ans': 610, 'solved': false},
    {'levelNumber': 35, 'ans': 0, 'solved': false},
    {'levelNumber': 36, 'ans': 15, 'solved': false},
    {'levelNumber': 37, 'ans': 0, 'solved': false},
    {'levelNumber': 38, 'ans': 0, 'solved': false},
    {'levelNumber': 39, 'ans': 20, 'solved': false},
    // World 5
    {'levelNumber': 40, 'ans': 0, 'solved': false},
    {'levelNumber': 41, 'ans': 7, 'solved': false},
    {'levelNumber': 42, 'ans': 2, 'solved': false},
    {'levelNumber': 43, 'ans': 0, 'solved': false},
    {'levelNumber': 44, 'ans': 0, 'solved': false},
    {'levelNumber': 45, 'ans': 0, 'solved': false},
    {'levelNumber': 46, 'ans': 0, 'solved': false},
    {'levelNumber': 47, 'ans': 0, 'solved': false},
    {'levelNumber': 48, 'ans': 0, 'solved': false},
    {'levelNumber': 49, 'ans': 0, 'solved': false},
  ];

  static const _wordsInfo = [
    {
      'RequiredStarsAmount': 0,
      'amountOfLevels': 10,
      'firstLevelNumber': 0,
      'colorTheme': Color.fromARGB(200, 255, 255, 255)
    },
    {
      'RequiredStarsAmount': 5,
      'amountOfLevels': 10,
      'firstLevelNumber': 10,
      'colorTheme': Color.fromARGB(210, 255, 255, 255)
    },
    {
      'RequiredStarsAmount': 12,
      'amountOfLevels': 10,
      'firstLevelNumber': 20,
      'colorTheme': Color.fromARGB(220, 255, 255, 255)
    },
    {
      'RequiredStarsAmount': 21,
      'amountOfLevels': 10,
      'firstLevelNumber': 30,
      'colorTheme': Color.fromARGB(230, 255, 255, 255)
    },
    {
      'RequiredStarsAmount': 36,
      'amountOfLevels': 10,
      'firstLevelNumber': 40,
      'colorTheme': Color.fromARGB(255, 255, 255, 255)
    },
  ];
}