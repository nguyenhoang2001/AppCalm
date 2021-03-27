import 'dart:convert';
import 'package:flutter_app2/models/article_model.dart';
import 'package:http/http.dart' as http;

class News{
  List<ArticleModel> news = [];

  Future<void> getNews() async{
    String url = "http://newsapi.org/v2/top-headlines?country=us&category=health&apiKey=ba4728761e504db89b02414ffa343d94";
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok"){
      jsonData['articles'].forEach((element){
        if (element['url'] != null && element['description'] != null && element['urlToImage'] != null ){
          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            content: element["content"],
            url: element["url"],
            urlToImage: element['urlToImage'],
          );
          news.add(articleModel);
        }
      });
    }
  }
}