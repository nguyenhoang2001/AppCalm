final List<String> iconImageList = ['051-user.png'];
const String firebaseCloudserverToken ='AAAAt7GY6Lo:APA91bHEq2Xi6m4716ciM8KgnGcHYw7YJ8K5X3_pFnzbzRkZzyX4nKRkbQFn8pKceSWVFXoYjYuToqGZcnrEhHqhI9gRG7OxQHtrjypm8o2LElq5v0zhOw0Sb64itx54DtpDfb9Du86H';
const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
class MyProfileData{
  final String myThumbnail;
  final String myName;
  final List<String> myLikeList;
  final List<String> myLikeCommnetList;
  final String myFCMToken;
  MyProfileData({this.myName,this.myThumbnail,this.myLikeList,this.myLikeCommnetList,this.myFCMToken});
}

const reportMessage = 'Thank you for reporting. We will determine the user\'s information within 24 hours and delete the account or take action to stop it.';
