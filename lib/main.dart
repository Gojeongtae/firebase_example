import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics(); //나 애널리틱스 사용할래~
  static FirebaseAnalyticsObserver observer =
  FirebaseAnalyticsObserver(analytics: analytics); //페이지 이동이나 클릭 등 사용자 행동을
  //관찰하는 옵저버 사용할래~

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorObservers: <NavigatorObserver>[observer],
      home: FirebaseApp(
        analytics : analytics,
        observer : observer,
      )
    );
  }
}

class FirebaseApp extends StatefulWidget {
  FirebaseApp({Key? key, required this.analytics, required this.observer}) : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _FirebaseAppState createState() => _FirebaseAppState(analytics, observer);
}

class _FirebaseAppState extends State<FirebaseApp>{
  _FirebaseAppState(this.analytics, this.observer);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  String _message = '';

  void setMessage(String message){
    setState(() {
      _message = message;
    });
  }

  Future<void> _sendAnalyticsEvent() async {
    //애널리틱스의 logEvent를 호출해 test_event라는 키값으로 데이터 저장
    await analytics.logEvent(
      name: "test_event",
      parameters: <String, dynamic>{
        'string' : 'hellot flutter',
        'int' : 100,
      },
    );
    setMessage('Analytics 보내기 성공');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Example'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: _sendAnalyticsEvent,
              child: Text('테스트'),
            ),
            Text(_message, style: const TextStyle(color: Colors.blueAccent)),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
      floatingActionButton:
      FloatingActionButton(child: const Icon(Icons.tab), onPressed: () {}),
    );
  }
}