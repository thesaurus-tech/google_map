import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//global key to show notification through out the app state
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

const _docker =
    "https://stayonsoserver.mangowave-4fb88b19.southindia.azurecontainerapps.io/";
const _local = "http://localhost:8080/";
const dockerPath = _docker;
const String dbPath =
    String.fromEnvironment('DB_PATH', defaultValue: '1223123123');
const String globalKeyVar = dbPath;
const String firebasePath = '/global_key/$globalKeyVar/';
const String apiKey = 'AIzaSyDBEP447TPNXuu50J3UxRwQXQ6KDvy8vQY';