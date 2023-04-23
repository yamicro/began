import 'package:flutter/material.dart';

class LockScreenTime extends StatefulWidget {
  @override
  _LockScreenTimeState createState() => _LockScreenTimeState();
}

class _LockScreenTimeState extends State<LockScreenTime> {
  String _showChineseWeekday(int weekday) {
    switch (weekday) {
      case 1:
        return '一';
      case 2:
        return '二';
      case 3:
        return '三';
      case 4:
        return '四';
      case 5:
        return '五';
      case 6:
        return '六';
      case 7:
        return '日';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                // 显示时和分
                '${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()..color = Colors.white.withOpacity(0.8),
                ),
              ),
              SizedBox(width: 20),
              Text(
                '周${_showChineseWeekday(DateTime.now().weekday)}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()..color = Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
          Text(
            // 显示年月日
            '${DateTime.now().year}年${DateTime.now().month}月${DateTime.now().day}日',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              foreground: Paint()..color = Colors.white.withOpacity(0.8),
            ),
          ),
          // SizedBox(height: 20),
          
        ],
      ),
    );
  }
}