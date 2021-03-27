import 'package:flutter/material.dart';
import 'package:flutter_app2/helper/news.dart';
import 'package:flutter_app2/models/article_model.dart';
import 'package:flutter_app2/views/article_view.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<ArticleModel> articles = new List<ArticleModel>();
  bool _loading = true;

  @override
  void initState() {
    // Create list of categories name and img
    super.initState();
    getNews();
  }

  getNews() async{
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff40e0d0),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Top News", style: TextStyle(fontSize: 22,color: Colors.white, fontWeight: FontWeight.bold), )
          ],
        ),
        centerTitle: true,
        elevation: 3.0,
      ),
      body: _loading ? Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      ) : SingleChildScrollView(
          child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: <Widget>[
              ///Categories
              ///Blog
              Container(
                padding: EdgeInsets.only(top: 16),
                child: ListView.builder(
                    itemCount: articles.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index){
                      return Blogtile(
                        imageUrl: articles[index].urlToImage,
                        title: articles[index].title,
                        desc: articles[index].description ,
                        url: articles[index].url
                      );
                    }),
              ),
            ],),
        ),
      ),
    );
  }
}



class Blogtile extends StatelessWidget {
  final String imageUrl, title, desc, url;
  Blogtile({@required this.imageUrl, @required this.title, @required this.desc,@required this.url});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => ArticleView(
              blogUrl: url,
            )));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),

        child: Column(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(imageUrl)),
            Text(title, style: TextStyle(fontSize: 18, color: Colors.black87,fontWeight: FontWeight.w500),),
            SizedBox(height: 8,),
            Text(desc,style: TextStyle(fontSize: 15,color: Colors.black54))

          ],),
      ),
    );
  }
}

