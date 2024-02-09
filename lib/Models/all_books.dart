import 'dart:convert';

class AllBooks {
  final int id;
  final String name;
  final String url;
  final String dialect;
   String? shortDescription, longDescription;
  final bool isReleased, isDownloadable;
   String? downloadableDocument;
   String? projectURL;
  final String bookImageURL;

  AllBooks({
    required this.id,
    required this.name,
    required this.url,
    required this.dialect,
     this.shortDescription,
     this.longDescription,
    required this.isReleased,
    required this.isDownloadable,
     this.downloadableDocument,
     this.projectURL,
   required this.bookImageURL,
  });

  factory AllBooks.fromJson(Map<String, dynamic> json) {
    return AllBooks(
      id: json["Id"] as int,
      name: json["Name"] as String,
      url: json["URL"] as String,
      dialect: json["Dialect"] as String,
      shortDescription: json["ShortDescription"] as String,
      longDescription: json["LongDescription"] as String,
      isReleased: json["IsReleased"] as bool,
      isDownloadable: json["IsDownloadable"] as bool,
      downloadableDocument: json["DownloadableDocument"] as String,
      projectURL: json["ProjectURL"] as String,
      bookImageURL: json["BookImageURL"] == ''? 'assets/images/cooming_soon3.jpg'
          : json["BookImageURL"],
    );
  }

  static List<AllBooks> booksFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return AllBooks.fromJson(data);
    }).toList();
  }
}

class Books {
  Books({
    required this.id,
    required this.name,
    required this.url,
    required this.dialect,
    required this.shortDescription,
    required this.longDescription,
    required this.isReleased,
    required this.isDownloadable,
    required this.downloadableDocument,
    required this.projectUrl,
    this.bookImageUrl,
  });

  int id;
  String name;
  String url;
  String dialect;
  String shortDescription;
  String longDescription;
  bool isReleased;
  bool isDownloadable;
  String downloadableDocument;
  String projectUrl;
  String? bookImageUrl;

  factory Books.fromRawJson(String str) => Books.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Books.fromJson(var json) => Books(
        id: json["Id"] as int,
        name: json["Name"] as String,
        url: json["URL"] as String,
        dialect: json["Dialect"] as String,
        shortDescription: json["ShortDescription"] as String,
        longDescription: json["LongDescription"] as String,
        isReleased: json["IsReleased"] as bool,
        isDownloadable: json["IsDownloadable"] as bool,
        downloadableDocument: json["DownloadableDocument"] as String,
        projectUrl: json["ProjectURL"] as String,
        bookImageUrl: json["BookImageURL"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "URL": url,
        "Dialect": dialect,
        "ShortDescription": shortDescription,
        "LongDescription": longDescription,
        "IsReleased": isReleased,
        "IsDownloadable": isDownloadable,
        "DownloadableDocument": downloadableDocument,
        "ProjectURL": projectUrl,
        "BookImageURL": bookImageUrl ,
      };
}
