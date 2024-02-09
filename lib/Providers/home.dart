import 'dart:convert';
import 'dart:typed_data';
import "package:flutter/material.dart";
import 'package:url_launcher/url_launcher.dart';
import 'package:xml2json/xml2json.dart';
import '../Services/api_service.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class HomeProv extends ChangeNotifier {
  final myTransformer = Xml2Json();
  bool _isImageZoomed = false;
  bool _isSuccess = true;
  bool _isScanned = false;
  bool _isLoaded = false;
  bool _isSvg = false;
  bool _isYoutube = false;
  bool _isOnlySyriac = true;
  String _qrCodeValue = '';
  String _protocolDomainPath = '', _bookTextS = '', _bookTextG = '';
  List<String> _queries = [];
  List<String> tempQueriesMapItems = [];
  Map<String, String> _queriesMap = {};
  Map<dynamic, dynamic> _book = {};
  String _videoURL = '';
  bool _isInternalVideo = false;
  bool _isBetkanuProduct = true;
  isBetkanuProduct() => _isBetkanuProduct;
  isSuccess() => _isSuccess;
  isImageZoomed() => _isImageZoomed;
  bookTextS() => _bookTextS;
  bookTextG() => _bookTextG;
  videoURL() => _videoURL;
  isOnlySyriac() => _isOnlySyriac;
  isYoytube() => _isYoutube;
  isSvg() => _isSvg;
  isLoaded() => _isLoaded;
  isScanned() => _isScanned;
  qrCpdeValue() => _qrCodeValue;
  protocolDomainPath() => _protocolDomainPath;
  queries() => _queries;
  queriesMap() => _queriesMap;
  book() => _book;
  isInternalVideo() => _isInternalVideo;

  dynamic getElementFromBook(dynamic property) {
    return _book[property];
  }

  String AudioURL() {
    return _book["AudioURL"] ?? "";
  }

  setIsBetkanuProduct(bool value) {
    _isBetkanuProduct = value;
    notifyListeners();
  }

  setIsInternalVideo(bool value) {
    _isInternalVideo = value;
    notifyListeners();
  }

  setIsSuccess(bool isSuccess) {
    _isSuccess = isSuccess;
    notifyListeners();
  }

  clearVideoUrl() {
    _videoURL = '';
    notifyListeners();
  }

  clearBook() {
    _book.clear();
    print('after cleariiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiing book: ' +
        _book.length.toString());

    notifyListeners();
  }

  setIsImageZoomed(bool isImageZoomed) {
    _isImageZoomed = isImageZoomed;
    notifyListeners();
  }

  setVideoURL(String videoURL) {
    _videoURL = videoURL;
    notifyListeners();
  }

  setIsSvg() async {
    _book["ImageURL"] = _book["ImageURL"] ?? '';
    _isSvg = _book["ImageURL"]?.contains(".svg");
    notifyListeners();
  }

  setIsLoaded(bool isLoaded) {
    _isLoaded = isLoaded;
    notifyListeners();
  }

  setIsScanned(bool isScanned) {
    _isScanned = isScanned;
    notifyListeners();
  }

  setQRCodeValue(String qrCodeValue) {
    _qrCodeValue = qrCodeValue;
    notifyListeners();
  }

  QRCodeURL(BuildContext context) async {
    _isYoutube = false;
    _isBetkanuProduct = true;
    notifyListeners();
    if ((_qrCodeValue.contains('youtu.be')) ||
        (_qrCodeValue.contains('youtube'))) {
      youtubeURL();
      _isYoutube = true;
      launchYoutubeURL();
    } else if (_qrCodeValue.contains('.xml')) {
      await getBook(getXMLData());
    } else if (_qrCodeValue.contains("betkanu")) {
      splitQRCodeURL();
      await getBook(getBookFromAPI(context));
    } else {
      _isBetkanuProduct = false;
      _isSuccess = false;
      notifyListeners();
    }
    _isLoaded = true;

    notifyListeners();
  }

  youtubeURL() {
    _videoURL = _qrCodeValue.replaceAll(' ', '');
    notifyListeners();
  }

  splitQRCodeURL() {
    _queries.clear();
    List<String> temp = [];
    String wholeQuery = '';
    temp = _qrCodeValue.split('?');
    _protocolDomainPath = temp[0];
    wholeQuery = temp[1];
    temp.clear();
    temp = wholeQuery.split('&');
    for (var element in temp) {
      _queries.add(element);
    }
    temp.clear();
    for (var element in _queries) {
      temp = element.split('=');
      tempQueriesMapItems.add(temp[0]);
      tempQueriesMapItems.add(temp[1]);
    }
    numberOfQueries(tempQueriesMapItems);
    tempQueriesMapItems.clear();
    temp.clear();
    notifyListeners();
  }

  numberOfQueries(List<String> temp) {
    _queriesMap.clear();
    switch ((temp.length) ~/ 2) {
      case 1:
        _queriesMap = {
          temp[0]: temp[1],
        };
        break;
      case 2:
        _queriesMap = {
          temp[0]: temp[1],
          temp[2]: temp[3],
        };
        break;
      case 3:
        _queriesMap = {
          temp[0]: temp[1],
          temp[2]: temp[3],
          temp[4]: temp[5],
        };
        break;
      case 4:
        _queriesMap = {
          temp[0]: temp[1],
          temp[2]: temp[3],
          temp[4]: temp[5],
          temp[6]: temp[7],
        };
        break;
      default:
        _queriesMap = {};
    }
    notifyListeners();
  }

  Future<void> getText() async {
    try {
      var headers = {
        'Content-Type': 'text/plain',
      };
      print("text urlllllllllllllllllllllllllllllllllllllllllllllllllllllll" +
          _book["TextURL"]);
      String url = _book["TextURL"];
      String encodedUrl = Uri.encodeFull(url);
    //  if (encodedUrl.contains('')) {
       encodedUrl= encodedUrl.toString().replaceAll('%0D%0A', '');
     // }
      var response = await http.get(Uri.parse(encodedUrl), headers: headers);

      if (response.statusCode == 200) {
        Uint8List bytes = await HttpClient()
            .getUrl(Uri.parse(encodedUrl))
            .then((HttpClientRequest request) => request.close())
            .then((HttpClientResponse response) => response.fold<Uint8List>(
                Uint8List(0), (a, b) => Uint8List.fromList([...a, ...b])));

        String contents;
        try {
          contents = utf8.decode(bytes.toList(), allowMalformed: true);
        } catch (e) {
          print('Error decoding response body: $e');
          _isSuccess = false;
          notifyListeners();
          return;
        }
        checkTextLang(contents);
        print("Coooooooooooooooooooooooooooontentssssssssssssss:" + contents);
        _isOnlySyriac
            ? onlySyriacText(contents)
            : seperateTextByLanguage(contents);

        _isSuccess = true;
        notifyListeners();
      } else {
        print('Request failed with status: ${response.statusCode}');
        _isSuccess = false;
        notifyListeners();
      }
    } catch (exception) {
      print(
          'Exception occurreddddddddddddddddddddddddddddddddddddddd for unexpected thing : $exception');
      _isSuccess = false;
      notifyListeners();
    }
  }

  seperateTextByLanguage(String contents) async {
    List<String> temp = [];
    temp = contents.split('\n');
    _bookTextG = temp[0];
    _bookTextS = temp[1];
    notifyListeners();
  }

  onlySyriacText(String contents) {
    _bookTextS = contents;
    notifyListeners();
  }

  checkTextLang(String text) {
    _isOnlySyriac = !(text.contains(RegExp(r'[a-zA-Z]')));
    notifyListeners();
  }

  getBook(var book) async {
    await book;
    notifyListeners();

    await getText();
    await setIsSvg();
    print(
        'videoooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo' +
            _book["VideoURL"].toString());
    if ((_book["VideoURL"] != null || _book["VideoURL"].toString() != 'null') &&
        (_book["VideoURL"].toString().contains('.mp4'))) {
      _isInternalVideo = true;
    }
    notifyListeners();
  }

  getBookFromAPI(BuildContext context) async {
    _book = await APIService.getBook(context, query: _queriesMap);

    notifyListeners();
  }

  getXMLData() async {
    //Check if the domain is betkanu without .com
    if (!(_qrCodeValue.toLowerCase().contains('.com'))) {
      //link doesn't have .com, add .com to it
      _qrCodeValue = _qrCodeValue.replaceAll("/betkanu/", "/betkanu.com/");
      notifyListeners();
    }

    //If it has any invalid key(s), replace it with the valid key(s)
    _qrCodeValue = _qrCodeValue
        .replaceAll("kidssongsbookk", "kidssongsbook")
        .replaceAll("zmryothedzaaorebook", "kidssongsbook");

    var resp = await http.get(Uri.parse(_qrCodeValue));

    myTransformer.parse(resp.body);
    var json = await myTransformer.toParker();
    var resultMap = await jsonDecode(json);

    _book["ImageURL"] = resultMap["BKRBundle"]["ImageURL"];
    print("111111111111111111111111111111111111111" + _book["ImageURL"]);

    _book["TextURL"] = isContainsHTML(resultMap["BKRBundle"]["TextURL"])
        ? " "
        : resultMap["BKRBundle"]["TextURL"];
    print("222222222222222222222222222222222222222222" + _book["TextURL"]);

    _book["TextLanguage"] = resultMap["BKRBundle"]["TextLanguage"];
    print("333333333333333333333333333333333333333" + _book["TextLanguage"]);

    _book["AudioURL"] = resultMap["BKRBundle"]["AudioURL"];
    print("444444444444444444444444444444444444444444" + _book["AudioURL"]);

    notifyListeners();
  }

  isContainsHTML(String text) {
    return text.toLowerCase().contains("html") ? true : false;
  }

  Future<void> launchYoutubeURL() async {
    try {
      await launchUrl(Uri.parse(_videoURL));
    } catch (e) {
      _isSuccess = false;
      print('Error launching YouTube URL: $e');
    }
  }
}
