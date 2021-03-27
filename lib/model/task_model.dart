class Task {
  int id;
  String title;
  String priority;
  DateTime date;
  int status; // 0- Incomplete , 1 - Complete
  Task({this.title, this.date, this.priority, this.status});
  Task.withId({this.id, this.title, this.date, this.priority, this.status});

  Map<String, dynamic> toMap(){
    //syntas
    final map = Map<String, dynamic>();
    if(id != null){
    map['id'] = id;
    }
    map['title'] = title;
    map['date'] = date.toIso8601String();
    map['priority'] = priority;
    map['status'] = status;

    // we need to return map
    return map;

  }
  factory Task.fromMap(Map<String, dynamic> map){
    return Task.withId(
        id: map['id']
        , title: map['title']
        , date: DateTime.parse(map['date'])
        , priority: map['priority']
        , status: map['status'],);
  }
  
}