import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/commons/const.dart';
import 'package:flutter_app2/commons/utils.dart';
import 'package:flutter_app2/threadworking/reportPost.dart';


class ThreadItem extends StatefulWidget{
  final BuildContext parentContext;
  final DocumentSnapshot data;
  final MyProfileData myData;
  final ValueChanged<MyProfileData> updateMyDataToMain;
  final bool isFromThread;
  final Function threadItemAction;
  final int commentCount;
  ThreadItem({this.data,this.myData,this.updateMyDataToMain,this.threadItemAction,this.isFromThread,this.commentCount,this.parentContext});
  @override State<StatefulWidget> createState() => _ThreadItem();
}
class _ThreadItem extends State<ThreadItem>{
  MyProfileData _currentMyData;
  int _likeCount;
  @override
  void initState() {
    _currentMyData = widget.myData;
    _likeCount = widget.data['postLikeCount'];
    super.initState();
  }

  void _updateLikeCount(bool isLikePost) async{
    MyProfileData _newProfileData = await Utils.updateLikeCount(widget.data,widget.myData.myLikeList != null && widget.myData.myLikeList.contains(widget.data['postID']) ? true : false,widget.myData,widget.updateMyDataToMain,true);
    setState(() {
      _currentMyData = _newProfileData;
    });
    setState(() {
      isLikePost ? _likeCount-- : _likeCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(2.0,2.0,2.0,6),
      child: Card(
        elevation:10.0,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                onTap: () => widget.isFromThread ? widget.threadItemAction(widget.data) : null,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(6.0,2.0,10.0,2.0),
                      child: Container(
                          width: 48,
                          height: 48,
                          child: Image.asset('images/${widget.data['userThumbnail']}')
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(widget.data['userName'],style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(Utils.readTimestamp(widget.data['postTimeStamp']),style: TextStyle(fontSize: 16,color: Colors.black87),),
                        ),
                      ],
                    ),
                    Spacer(),
                    PopupMenuButton<int>(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 1,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right:8.0,left:8.0),
                                child: Icon(Icons.report),
                              ),
                              Text("Report"),
                            ],
                          ),
                        ),
                      ],
                      initialValue: 1,
                      onCanceled: () {
                        print("You have canceled the menu.");
                      },
                      onSelected: (value) {
                        showDialog(
                            context: widget.parentContext,
                            builder: (BuildContext context) => ReportPost(postUserName: widget.data['userName'],postId:widget.data['postID'],content:widget.data['postContent'],reporter: widget.myData.myName,));
                      },
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => widget.isFromThread ? widget.threadItemAction(widget.data) : null,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8,10,4,10),
                  child: Container(
                    child: Text(/*(widget.data['postContent'] as String).length > 200 ? '${widget.data['postContent'].substring(0, 132)} ...' : */widget.data['postContent'],
                      style: TextStyle(fontSize: 16,),
                      maxLines: 1000,
                    ),
                  ),
                ),
              ),
              Divider(height: 2,
                color: Colors.white,
              ),
              Padding(
                padding: const EdgeInsets.only(top:6.0,bottom: 2.0),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => _updateLikeCount(_currentMyData.myLikeList != null && _currentMyData.myLikeList.contains(widget.data['postID']) ? true : false),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left:8.0),
                            child: Icon(Icons.favorite_outlined,size: 20,color: widget.myData.myLikeList != null && widget.myData.myLikeList.contains(widget.data['postID']) ? Colors.red[900] : Colors.black),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:8.0),
                            child: Text(' ${widget.isFromThread ? widget.data['postLikeCount'] : _likeCount} ',
                              style: TextStyle(fontSize: 16,
                                  //fontWeight: FontWeight.bold,
                                  color: widget.myData.myLikeList != null && widget.myData.myLikeList.contains(widget.data['postID']) ? Colors.red[900]  : Colors.black),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:25.0),
                            child: GestureDetector(
                              onTap: () => widget.isFromThread ? widget.threadItemAction(widget.data) : null,
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.insert_comment,size: 20),
                                  Padding(
                                    padding: const EdgeInsets.only(left:8.0),
                                    child: Text(' ${widget.commentCount} ',style: TextStyle(fontSize: 16,)
                                        //fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    /*GestureDetector(
                      onTap: () => widget.isFromThread ? widget.threadItemAction(widget.data) : null,
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.insert_comment_outlined,size: 20),
                          Padding(
                            padding: const EdgeInsets.only(left:1.0),
                            child: Text(' ${widget.commentCount} ',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                          ),
                        ],
                      ),
                    ),*/
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}