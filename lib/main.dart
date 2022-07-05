import 'dart:ui';

import 'package:flutter/material.dart';

void main() => runApp(AppWidget());

class AppWidget extends StatefulWidget {
  AppWidget({Key? key}) : super(key: key) {
    debugPrint("AppWidget - constructor - $hashCode");
  }

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _AppWidgetState createState() {
    debugPrint("AppWidget - createState - $hashCode");
    return _AppWidgetState();
  }
}

class _AppWidgetState extends State<AppWidget> {
  bool _bright = false;
  _AppWidgetState() {
    debugPrint('_AppWidgetState - constructor - $hashCode');
  }
  _brightnessCallback() {
    setState(
      () => _bright = !_bright,
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("_AppWidgetState - build - $hashCode");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: _bright ? Brightness.light : Brightness.dark,
      ),
      home: FlowerWidget(
        imageSrc: _bright
            ? "https://cka.collectiva.in/ckavideos/Files/Flutter/flowers/2018_nissan_gt-r_coupe_nismo_fq_oem_1_150.jpg"
            : "https://cka.collectiva.in/ckavideos/Files/Flutter/flowers/photo-1531603071569-0dd65ad72d53.jpg",
        brightnessCallback: _brightnessCallback,
      ),
    );
  }
}

class FlowerWidget extends StatefulWidget {
  final String imageSrc;
  final VoidCallback brightnessCallback;

  FlowerWidget({
    Key? key,
    required this.imageSrc,
    required this.brightnessCallback,
  }) : super(key: key) {
    debugPrint("FlowerWidget - constructor - $hashCode");
  }

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _FlowerWidgetState createState() {
    debugPrint("FlowerWidget - createState - $hashCode");
    return _FlowerWidgetState();
  }
}

class _FlowerWidgetState extends State<FlowerWidget> {
  double _blur = 0;

  _FlowerWidgetState() {
    debugPrint("_FlowerWidgetState - constructor - $hashCode");
  }

  @override
  initState() {
    debugPrint("_FlowerWidgetState - initState - $hashCode");
    super.initState();
  }

  /// Fired when Flutter detects that the data from another source has changed,
  /// possibly affecting the UI and causing a call to �build�.
  /// In this case it is when the Theme changes (its an InheritedWidget).
  int dChangeDep = 1;
  @override
  // ignore: must_call_super
  void didChangeDependencies() {
    debugPrint(
        "_FlowerWidgetState - ${dChangeDep++} didChangeDependencies - $hashCode");
  }

  @override

  /// Fired when the widget is reconstructed as its widget data has changed,
  /// In this case it is when a new FlowerWidget is created with a different
  /// imageSrc.
  // ignore: must_call_super
  void didUpdateWidget(Widget oldWidget) {
    debugPrint("_FlowerWidgetState - didUpdateWidget - $hashCode");
    // The flower image has changed, so reset the blur.
    _blur = 0;
  }

  void _blurMore() {
    setState(() {
      _blur += 5.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("_FlowerWidgetState - build - $hashCode");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flower"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              widget.brightnessCallback();
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          // dependency on inherited widget - start
          color: Theme.of(context).backgroundColor,
          // dependency on inherited widget - end
          image: DecorationImage(
            //  dependency on data from widget - start
            image: NetworkImage(widget.imageSrc),
            //  dependency on data from widget - end
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          //  dependency on state data - start
          filter: ImageFilter.blur(
            sigmaX: _blur,
            sigmaY: _blur,
          ),
          //  dependency on state data - end
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.0),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _blurMore(),
        tooltip: 'Blur More',
        child: const Icon(Icons.add_a_photo_sharp),
      ),
    );
  }
}
