import 'package:cloud_firestore/cloud_firestore.dart';


class Users {
  final String type;
  final String name;
  final String number;
  final String tower;
  final String flat;

  Users({required this.type , required this.name , required this.number , required this.tower , required this.flat});
}

class Notices {
  final String date;
  final String notice;

  Notices({required this.date , required this.notice});
}

class Complains {
  final int urgency;
  final String complaint;
  final String flat;
  final String tower;

  Complains ({required this.urgency , required this.complaint, required this.tower, required this.flat});
}

class Services {
  final String service;
  final String flat;
  final String tower;
  final String date;

  Services ({required this.service, required this.date, required this.flat, required this.tower});
}

class Visitor {
  final String name;
  final String phone;
  final String carnum;

  Visitor({required this.name , required this.phone , required this.carnum});
}

class Activities {
  final String name;
  final String phone;
  final String activity;
  final String day;
  final String time;
  final String location;

  Activities({required this.name , required this.phone , required this.activity, required this.day, required this.time, required this.location});
}

class DatabaseService {

  final String uid;
  DatabaseService({required this.uid});

  CollectionReference userRecord = FirebaseFirestore.instance.collection(
      'userInfo');

  Future updateUserData(String type, String name, String number, String tower,
      String flat) async {
    return await userRecord.doc(uid).set({
      'type': type,
      'name': name,
      'number': number,
      'tower': tower,
      'flat': flat,
    });
  }

  CollectionReference userComplaint = FirebaseFirestore.instance.collection(
      'userComplaint');

  Future userComplaints(int urgency, String complaint , String tower, String flat) async {
    return await userComplaint.doc(uid).set({
      'urgency': urgency,
      'complaint': complaint,
      'tower' : tower,
      'flat' : flat,
    });
  }

  CollectionReference notices = FirebaseFirestore.instance.collection(
      'Notice');

  Future addNotice(String date, String notice) async {
    return await notices.doc(uid).set({
      'date' : date,
      'notice' : notice,
    });
  }

  CollectionReference serviceReq = FirebaseFirestore.instance.collection(
      'Services Required');

  Future serviceRequired(String date, String service , String tower, String flat) async {
    return await serviceReq.doc(uid).set({
      'date': date,
      'service wanted': service,
      'tower' : tower,
      'flat' : flat,
    });
  }

  CollectionReference VisitorRecord = FirebaseFirestore.instance.collection(
      'visitors');

  Future updateVisitorData(String name, String phone, String carnum) async {
    return await VisitorRecord.doc(uid).set({
      'name': name,
      'phone': phone,
      'carnum': carnum,
    });
  }

  CollectionReference societyActivities = FirebaseFirestore.instance.collection(
      'Society Activities');

  Future addActivity(String name, String phone, String activity, String day, String time, String location) async {
    return await societyActivities.doc(uid).set({
      'name': name,
      'phone': phone,
      'activity': activity,
      'day': day,
      'time': time,
      'location': location,
    });
  }


  List <Users> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Users(
        name: doc.get('name') ?? '',
        type: doc.get('type') ?? '',
        number: doc.get('number') ?? '0',
        tower: doc.get('tower') ?? '0',
        flat: doc.get('flat') ?? '0',
      );
    }).toList();
  }


  Stream<List<Users>> get user {
    return userRecord.snapshots().map(_userListFromSnapshot);
  }

  List <Notices> _noticeListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Notices(
        date: doc.get('date') ?? '00/00/0000',
        notice: doc.get('notice') ?? '',
      );
    }).toList();
  }

  Stream<List<Notices>> get notice {
    return notices.snapshots().map(_noticeListFromSnapshot);
  }

  List <Complains> _complainListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Complains(
        urgency: doc.get('urgency') ?? '0',
        complaint: doc.get('complaint') ?? '',
        tower: doc.get('tower') ?? '0',
        flat: doc.get('flat') ?? '0',
      );
    }).toList();
  }


  Stream<List<Complains>> get complain {
    return userComplaint.snapshots().map(_complainListFromSnapshot);
  }

  List <Services> _serviceListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Services(
        service: doc.get('service') ?? '',
        date: doc.get('date') ?? '00/00/0000',
        tower: doc.get('tower') ?? '0',
        flat: doc.get('flat') ?? '0',
      );
    }).toList();
  }


  Stream<List<Services>> get service {
    return serviceReq.snapshots().map(_serviceListFromSnapshot);
  }

  List <Activities> _activityListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Activities(
        name: doc.get('name')?? 'xxx',
        phone: doc.get('phone')?? '00000',
        activity: doc.get('activity')?? '-nil-',
        day: doc.get('day')??'-nil-',
        time: doc.get('time')?? '00:00',
        location: doc.get('location')?? '-nil-',
      );
    }).toList();
  }

  Stream<List<Activities>> get activity {
    return societyActivities.snapshots().map(_activityListFromSnapshot);
  }
  }
