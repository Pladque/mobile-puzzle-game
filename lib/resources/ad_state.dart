import 'package:flutter/material.dart';
import 'dart:io';

@immutable
class AdHelper
{
  String get bannerAdUnitId =>Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/5224354917' : '';
}