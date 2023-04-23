import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:newnote/timelock.dart';
import 'package:getwidget/getwidget.dart';
import 'package:stacked_notification_cards/stacked_notification_cards.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  num get swipeThreshold => 100;
  final TextEditingController _searchTextController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  double _startY = 0.0;
  var _isSearchVisible = false;
  var _isHomeBlurred = false;
  var _isCard = false;
  var _isSearch = false;
  var _isCardVisible = false;
  final focusNode = FocusNode();
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onPanDown: (details) {
            _startY = details.globalPosition.dy;
          },
          onPanUpdate: (details) {
            final y = details.globalPosition.dy;
            if (y > _startY + 50 && !_isCard && !_isSearchVisible) {
              _isSearch = true;
              print("torch1");
              FocusScope.of(context).nextFocus();
              setState(() {
                _isSearchVisible = true;
                _isHomeBlurred = true;
              });
            } else if (y < _startY - 50 && !_isCardVisible && !_isSearch) {
              _isCard = true;
              print("torch4");
              FocusScope.of(context).nextFocus();
              setState(() {
                _isCardVisible = true;
                _isHomeBlurred = true;
              });
            }
          },
          child: Stack(
            children: [
              Center(child: LockScreenLayout()),
              if (_isHomeBlurred)
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                      color: Color.fromARGB(255, 6, 6, 6).withOpacity(0.2)),
                ),
              _buildSearch(),
              NotificationAppleCard(context),
              
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBg() {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        color: Colors.black.withOpacity(0.2),
      ),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CupertinoSearchTextField(
        focusNode: focusNode,
        backgroundColor: const Color.fromARGB(255, 52, 50, 50),
        borderRadius: BorderRadius.circular(8),
        itemColor: Color.fromARGB(255, 37, 38, 39),
      ),
    );
  }

  Widget _buildSearch() {
    if (_isSearchVisible) {
      return GestureDetector(
        onPanDown: (details) {
          _startY = details.globalPosition.dy;
        },
        onPanUpdate: (details) {
          final y = details.globalPosition.dy;
          if (y < _startY - 50 && _isSearchVisible && _isSearch) {
            print("torch2");
            _isSearch = false;
            setState(() {
              _isSearchVisible = false;
              _isHomeBlurred = false;
            });
          }
        },
        child: Stack(
          children: [
            _buildSearchBg(),
            SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  _buildSearchField(),
                ],
              ),
            )
          ],
          alignment: AlignmentDirectional.topStart,
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  Widget NotificationAppleCard(BuildContext context) {
    final int index;
    List<NotificationCard> _listOfNotification = [
      NotificationCard(
        date: DateTime.now(),
        leading: Icon(
          Icons.account_circle,
          size: 48,
        ),
        title: 'OakTree 1',
        subtitle: 'We believe in the power of mobile computing.',
      ),
      NotificationCard(
        date: DateTime.now().subtract(
          const Duration(minutes: 4),
        ),
        leading: Icon(
          Icons.account_circle,
          size: 48,
        ),
        title: 'OakTree 2',
        subtitle: 'We believe in the power of mobile computing.',
      ),
      NotificationCard(
        date: DateTime.now().subtract(
          const Duration(minutes: 10),
        ),
        leading: Icon(
          Icons.account_circle,
          size: 48,
        ),
        title: 'OakTree 3',
        subtitle: 'We believe in the power of mobile computing.',
      ),
      NotificationCard(
        date: DateTime.now().subtract(
          const Duration(minutes: 30),
        ),
        leading: Icon(
          Icons.account_circle,
          size: 48,
        ),
        title: 'OakTree 4',
        subtitle: 'We believe in the power of mobile computing.',
      ),
      NotificationCard(
        date: DateTime.now().subtract(
          const Duration(minutes: 44),
        ),
        leading: Icon(
          Icons.account_circle,
          size: 48,
        ),
        title: 'OakTree 5',
        subtitle: 'We believe in the power of mobile computing.',
      ),
    ];

    if (_isCardVisible) {
      return GestureDetector(
          onPanDown: (details) {
            _startY = details.globalPosition.dy;
          },
          onPanUpdate: (details) {
            final y = details.globalPosition.dy;

            if (y > _startY + 50 && _isCardVisible) {
              print("torch3");
              _isCard = false;
              setState(() {
                _isCardVisible = false;
                _isHomeBlurred = false;
              });
            }
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                'Stacked Notification Card',
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  StackedNotificationCards(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 2.0,
                      )
                    ],
                    notificationCardTitle: 'Message',
                    notificationCards: [..._listOfNotification],
                    cardColor: Color(0xFFF1F1F1),
                    padding: 16,
                    actionTitle: Text(
                      'Notifications',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    showLessAction: Text(
                      'Show less',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    onTapClearAll: () {
                      setState(() {
                        _listOfNotification.clear();
                      });
                    },
                    clearAllNotificationsAction: Icon(Icons.close),
                    clearAllStacked: Text('Clear All'),
                    cardClearButton: Text('clear'),
                    cardViewButton: Text('view'),
                    onTapClearCallback: (index) {
                      print(index);
                      setState(() {
                        _listOfNotification.removeAt(index);
                      });
                    },
                    onTapViewCallback: (index) {
                      print(index);
                    },
                  ),
                ],
              ),
            ),
          ));
    } else {
      return SizedBox.shrink();
    }
  }
}

class LockScreenLayout extends StatefulWidget {
  @override
  _LockScreenLayoutState createState() => _LockScreenLayoutState();
}

class _LockScreenLayoutState extends State<LockScreenLayout> {
  List<String> wallpapers = [
    // 添加 wallpaper 图片列表
    'images/1.jpg',
  ];
  int wallpaperIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
            child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage(wallpapers[wallpaperIndex]),
                  fit: BoxFit.cover,
                )))),
        Align(
          alignment: Alignment.topCenter.add(Alignment(0, 0.1)),
          child: LockScreenTime(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SafeArea(
                child: Align(
              alignment: Alignment.bottomLeft.add(Alignment(0, -0.1)),
              child: Stack(
                children: [
                  blurryButton(Container(width: 56, height: 56) // 扩大大小
                      ),
                  CupertinoButton(
                    onPressed: () {},
                    child: Icon(CupertinoIcons.add_circled,
                        color: CupertinoColors.white),
                  ),
                ],
              ),
            )),
            SafeArea(
              child: Align(
                alignment: Alignment.bottomRight.add(Alignment(0, -0.1)),
                child: Stack(children: [
                  blurryButton(Container(width: 56, height: 56) // 扩大大小
                      ),
                  CupertinoButton(
                    onPressed: () {},
                    child: Icon(CupertinoIcons.camera_fill,
                        color: CupertinoColors.white, fill: 1.0),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget blurryButton(Widget child) {
    return ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        blendMode: BlendMode.hardLight,
        child: child,
      ),
    );
  }
}

class MessageCard extends StatefulWidget {
  const MessageCard({Key key}) : super(key: key);

  @override
  _MessageCardState createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  bool _liked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final RenderBox overlay = Overlay.of(context).context.findRenderObject();
        showMenu<String>(
          context: context,
          position: RelativeRect.fromLTRB(
            overlay.size.width / 4, 
            overlay.size.height / 2,
            overlay.size.width * 3 / 4,
            overlay.size.height
          ),
          items: [
            'Reply', 
            'Forward',
            'Delete'
          ]
        ).then((String value) {
          // 相应操作
        });
      },
      onDoubleTap: () {
        setState(() {
          _liked = true;
        });
      },
      child: Dismissible(
        key: Key('messageCard'),
        onDismissed: (direction) {
          // 删除卡片
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 3.0,
                blurRadius: 5.0,
                offset: Offset(0, 3),
              )
            ]
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Title', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8.0),
                Text('Message content'),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('9:41 AM', style: TextStyle(color: Colors.grey, fontSize: 12.0)),
                    _liked ? Icon(Icons.favorite, color: Colors.red, size: 16.0) : SizedBox(),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
