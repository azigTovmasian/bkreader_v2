import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../Models/all_books.dart';
import '../Providers/home.dart';

class APIService {
  static Future<Map> getBook(BuildContext context,
      {required Map<String, String> query}) async {
    try {
      var uri = Uri.https('www.betkanu.com', '/api/BKReader', query);
      final response = await http.get(uri, headers: {"FROM": "BETKANU"});
      if (response.statusCode == 200) {
        Map<dynamic, dynamic> data = await jsonDecode(response.body);
        print(
            "dataaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" +
                data.toString());
                Provider.of<HomeProv>(context, listen: false).setIsSuccess(true);
        return data;
      } else {
        Provider.of<HomeProv>(context, listen: false).setIsSuccess(false);
        return {};
      }
    } catch (e) {
      return {};
    }
  }

  static Future<List<AllBooks>> getBooks(BuildContext context) async {
    try {
      var uri = Uri.https('www.betkanu.com', '/api/BKReader');
      final response = await http.get(uri, headers: {"FROM": "BETKANU"});
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
        List<dynamic> temp = [];
        for (var item in data) {
          temp.add(item);
        }
        Provider.of<HomeProv>(context, listen: false).setIsSuccess(true);
        return AllBooks.booksFromSnapshot(temp);
      } else {
        Provider.of<HomeProv>(context, listen: false).setIsSuccess(false);
        return [];
      }
    } catch (e) {
        Provider.of<HomeProv>(context, listen: false).setIsSuccess(false);
      return [];
    }
  }
}
