import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:swipable_stack/swipable_stack.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const Home(),
    ),
  );
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List products = [
    {
      "_id": '1',
      "name": 'Airpods Wireless',
      "image": 'assets/images/airpods.jpg',
      "description":
          'Bluetooth technology lets you connect it with compatible devices wirelessly High-quality ',
    },
    {
      "_id": '2',
      "name": 'iPhone 11 Pro',
      "image": 'assets/images/phone.jpg',
      "description":
          'Introducing the iPhone 11 Pro. A transformative triple-camera system that adds tons of capability',
    },
    {
      "_id": '3',
      "name": 'Cannon EOS',
      "image": 'assets/images/camera.jpg',
      "description": 'Characterized by versatile imaging specs,',
    },
    {
      "_id": '4',
      "name": 'Sony Playstation',
      "image": 'assets/images/playstation.jpg',
      "description":
          'The ultimate home entertainment center starts with PlayStation. ',
    },
    {
      "_id": '5',
      "name": 'Logitech',
      "image": 'assets/images/mouse.jpg',
      "description":
          'Get a better handle on your games with this Logitech LIGHTSYNC gaming mouse.',
    },
    {
      "_id": '6',
      "name": 'Amazon Echo',
      "image": 'assets/images/alexa.jpg',
      "description":
          'Meet Echo Dot - Our most popular smart speaker with a fabric design.',
    },
  ];

  var dir;
  bool showAnimation = false;

  bool listMode = true;
  late final SwipableStackController _controller;

  void _listenController() => setState(() {});

  @override
  void initState() {
    super.initState();
    _controller = SwipableStackController()..addListener(_listenController);
  }

  @override
  void dispose() {
    super.dispose();
    _controller
      ..removeListener(_listenController)
      ..dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          !listMode
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      listMode = true;
                    });
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.black,
                  ))
              : Container()
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Test App',
          style: TextStyle(
              fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: listMode
          ? ListView.builder(
              itemBuilder: (builder, index) => InkWell(
                onTap: () => setState(() {
                  listMode = false;
                }),
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            child: Image.asset(
                              products[index]['image'],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  products[index]['name'],
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  products[index]['description'],
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const Divider(),
                    ],
                  ),
                ),
              ),
              itemCount: products.length,
            )
          : Container(
              width: double.infinity,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: SwipableStack(
                      allowVerticalSwipe: false,
                      detectableSwipeDirections: const {
                        SwipeDirection.right,
                        SwipeDirection.left,
                      },
                      controller: _controller,
                      stackClipBehaviour: Clip.none,
                      onSwipeCompleted: (index, direction) {
                        if (kDebugMode) {
                          if (direction == SwipeDirection.left) {
                            dir = "left";
                          }

                          if (direction == SwipeDirection.right) {
                            dir = "right";
                          }

                          setState(() {
                            showAnimation = true;
                          });

                          Future.delayed(const Duration(microseconds: 700), () {
                            setState(() {
                              showAnimation = false;
                            });
                          });
                        }
                      },
                      horizontalSwipeThreshold: 0.3,
                      verticalSwipeThreshold: 0.3,
                      builder: (context, properties) {
                        final itemIndex = properties.index % products.length;

                        return Container(
                          width: double.infinity,
                          child: Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                height: MediaQuery.of(context).size.height * 1,
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(top: 0, bottom: 35),
                                child: Stack(children: [
                                  Positioned(
                                      child: Container(
                                    decoration: BoxDecoration(),
                                  )),
                                  Positioned(
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height -
                                              (MediaQuery.of(context)
                                                      .viewPadding
                                                      .top +
                                                  kBottomNavigationBarHeight +
                                                  14.49 +
                                                  140),
                                      width:
                                          MediaQuery.of(context).size.width * 1,
                                      child: Image.asset(
                                        products[itemIndex]["image"],
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    child: Container(
                                      color: Colors.black,
                                      height: 75,
                                      width: MediaQuery.of(context).size.width *
                                          95,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 20,
                                    left: 22,
                                    child: Row(
                                      children: [
                                        Text(
                                          products[itemIndex]["name"],
                                          style: const TextStyle(
                                              fontSize: 28,
                                              fontWeight: FontWeight.w600,
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                        ),
                                      ],
                                    ),
                                  )
                                ]),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 60),
        child: BottomNavigationBar(
          elevation: 0,
          currentIndex: 1,
          onTap: (value) {},
          items: [
            BottomNavigationBarItem(
                icon: !listMode
                    ? Container(
                        height: 37,
                        width: 37,
                        decoration: BoxDecoration(
                            color: showAnimation && dir == 'left'
                                ? Color.fromRGBO(255, 94, 81, 1)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(1000),
                            border: Border.all(
                              width: 2,
                              color: Color.fromRGBO(255, 94, 81, 1),
                            )),
                        child: Icon(
                          Icons.close,
                          size: 25,
                          color: showAnimation && dir == 'left'
                              ? Colors.white
                              : Color.fromRGBO(255, 94, 81, 1),
                        ))
                    : Container(),
                label: ""),
            BottomNavigationBarItem(
                icon: !listMode
                    ? Container(
                        height: 37,
                        width: 37,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(1000),
                            border: Border.all(
                              width: 2,
                              color: Color.fromRGBO(7, 166, 255, 1),
                            )),
                        child: const Icon(
                          Icons.star,
                          size: 25,
                          color: Color.fromRGBO(7, 166, 255, 1),
                        ))
                    : Container(),
                label: ""),
            BottomNavigationBarItem(
                icon: !listMode
                    ? Container(
                        height: 37,
                        width: 37,
                        decoration: BoxDecoration(
                            color: showAnimation && dir == 'right'
                                ? Color.fromRGBO(0, 211, 135, 1)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(1000),
                            border: Border.all(
                              width: 2,
                              color: Color.fromRGBO(0, 211, 135, 1),
                            )),
                        child: Icon(
                          Icons.favorite,
                          size: 25,
                          color: showAnimation && dir == 'right'
                              ? Colors.white
                              : Color.fromRGBO(0, 211, 135, 1),
                        ))
                    : Container(),
                label: ""),
          ],
        ),
      ),
    );
  }
}
