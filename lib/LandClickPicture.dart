import 'dart:developer';
import 'dart:typed_data';

import 'package:alemeno/Message.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LandClickPicture extends StatefulWidget {
  LandClickPicture({super.key});

  @override
  State<LandClickPicture> createState() => _LandClickPictureState();
}

class _LandClickPictureState extends State<LandClickPicture>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  List<CameraDescription> cameras = [];
  CameraController? controller;
  bool _isCameraInitialized = false;
  late AnimationController animationController;
  late Animation<double> _animation;
  bool finalSubmission = false;
  Uint8List imageFile = Uint8List.fromList([]);
  bool photoClicked = false;
  Tween<double> tween = Tween(begin: 0.5, end: 1);
  void onNewCameraSelected(CameraDescription cameraDescription) async {
    final previousCameraController = controller;
    // Instantiating the camera controller
    final CameraController cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.high,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    // Dispose the previous controller
    await previousCameraController?.dispose();

    // Replace with the new controller
    if (mounted) {
      setState(() {
        controller = cameraController;
      });
    }

    // Update UI if controller updated
    cameraController.addListener(() {
      if (mounted) setState(() {});
    });

    // Initialize controller
    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      print('Error initializing camera: $e');
    }

    // Update the Boolean
    if (mounted) {
      setState(() {
        _isCameraInitialized = controller!.value.isInitialized;
      });
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      // Free up memory when camera not active
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      // Reinitialize the camera with same properties
      onNewCameraSelected(cameraController.description);
    }
  }

  checkAvailableCameras() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      cameras = await availableCameras();
      onNewCameraSelected(cameras[0]);
    } on CameraException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error in fetching the cameras: $e")));
      print('Error in fetching the cameras: $e');
    }
  }

  Future<XFile?> takePicture() async {
    final CameraController? cameraController = controller;
    cameraController?.setFlashMode(FlashMode.off);
    if (cameraController!.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }
    try {
      XFile file = await cameraController.takePicture();
      return file;
    } on CameraException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error occured while taking picture: $e")));
      print('Error occured while taking picture: $e');
      return null;
    }
  }

  @override
  void initState() {
    animationController =
        AnimationController(duration: Duration(seconds: 5), vsync: this);
    _animation = tween.animate(
        CurvedAnimation(parent: animationController, curve: Curves.bounceOut));

    checkAvailableCameras();
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.topLeft,
              width: MediaQuery.of(context).size.width,
              child: Visibility(
                visible: (finalSubmission == false) ? true : false,
                child: FloatingActionButton(
                  mini: true,
                  backgroundColor: const Color(0xff3e8b3a),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.arrow_back),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            child: ScaleTransition(
              scale: _animation,
              child: Image.asset(
                "assets/images/baby S.png",
              ),
            ),
          ),
          Visibility(
            visible: (finalSubmission == false) ? true : false,
            child: Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.bottomCenter,
                decoration: const BoxDecoration(
                    color: CupertinoColors.systemGrey5,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Padding(
                  padding: const EdgeInsets.only(top: 38.0),
                  child: Stack(
                    children: [
                      _isCameraInitialized
                          ? Visibility(
                              visible: (photoClicked == false) ? true : false,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset(
                                            "assets/images/Vector.png"),
                                      ),
                                      Stack(
                                        children: [
                                          Image.asset(
                                              "assets/images/Corners.png"),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0),
                                            child: Container(
                                                height: 200,
                                                width: 200,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100)),
                                                child: ClipOval(
                                                  child: controller!
                                                      .buildPreview(),
                                                )),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset(
                                            "assets/images/Spoon.png"),
                                      ),
                                    ],
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: Text(
                                      "Click your meal",
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: FloatingActionButton(
                                      backgroundColor: const Color(0xff3e8b3a),
                                      onPressed: () async {
                                        XFile? rawImage = await takePicture();
                                        imageFile =
                                            await rawImage!.readAsBytes();
                                        setState(() {
                                          photoClicked = true;
                                        });
                                      },
                                      child: const Icon(
                                          CupertinoIcons.camera_fill),
                                    ),
                                  )
                                ],
                              ),
                            )
                          : Container(),
                      Visibility(
                        visible: (photoClicked == true) ? true : false,
                        child: Column(
                          children: [
                            Container(
                                height: 200,
                                width: 200,
                                decoration: BoxDecoration(
                                    color: CupertinoColors.systemGrey4,
                                    borderRadius: BorderRadius.circular(100)),
                                child: ClipOval(
                                  child: Image.memory(imageFile),
                                )),
                            const Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                "Will you eat this?",
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w400),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15.0, right: 10),
                                  child: FloatingActionButton(
                                    backgroundColor: const Color(0xff3e8b3a),
                                    onPressed: () async {
                                      tween = Tween(begin: 50, end: 100);
                                      animationController.forward();
                                      setState(() {
                                        finalSubmission = true;
                                      });
                                      await Future.delayed(
                                          const Duration(seconds: 6));
                                      Navigator.popUntil(
                                          context, (route) => route.isFirst);
                                      Navigator.pushReplacement<void, void>(
                                        context,
                                        CupertinoPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              const Message(),
                                        ),
                                      );
                                    },
                                    child:
                                        const Icon(CupertinoIcons.check_mark),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15.0, left: 10),
                                  child: FloatingActionButton(
                                    backgroundColor: Colors.red,
                                    onPressed: () async {
                                      setState(() {
                                        photoClicked = false;
                                      });
                                    },
                                    child: const Icon(Icons.cancel_outlined),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
