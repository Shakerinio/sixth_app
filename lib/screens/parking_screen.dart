import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/theme_provider.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter_mjpeg/flutter_mjpeg.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;

import '../widgets/change_theme_button_widget.dart';

class ParkingScreen extends StatefulWidget {
  @override
  State<ParkingScreen> createState() => _ParkingScreenState();
}

class _ParkingScreenState extends State<ParkingScreen> {
  final videoPlayerController = VideoPlayerController.network(
      'https://video-weaver.fra05.hls.ttvnw.net/v1/playlist/CskF82J_alfkffZDAo303vNmuwBsFV5st36QqWbxCUazgsrRZe2oyxbmuZYdSC-YbDKFX66kYmikdVH_THA4u8ob3AqBp2cH5ZOHWfXcG5XvqlaalXCN2yi9Yb3ycOfgz3jIXKUgBJYflIBfODIQaV6uIJpbGLkPMRiVU74mgwewWW6OBYlZMUwxo_3NldgiA422jMHrkxfrfv9cVk3SwgnpNpaThY8IW2jYQUK6rd4cZpCHli_mSaemyaFDG3y-OV3U7o-svgXQYGn1N5DIFXNqxhAe7rRrzwppfxlC2CS-NZYVO71kVjmw1rXvbDAFNmtEZpg0DE5YNCZMWMjxXKcI9qtCkc9ups7Qd8Dcn7ysQ9Kx6ZRELRhip_XizVvVrBbsif44clwIOSvkyZHjtEgd4IVFKgDB74E89WyUoQZ2NXXn_Rs9sX86M8Ny-LcSraX7zIIxiD1_eT3agOsxUvIIZdfvtansJpPmcExRk4lHWndG-LlEjufD5JJRFFbLfNk220QFrozU6IItLLa1Nslx3Ny0eqKZ5p75xRnnH6mao_z1g71LxzGvaxvXGNnugoFpjSvgRgKyWidR-EjXbM-pCtPXIudM_dl9iyAUro8bXObYxmJqsvG5WIHrTFYgiaHK_DYAKGzcgTNIzbCxQJ9QmKnuGblxCcWOrsbHaJBpo40WXRHEJSnFHM1Stti3Wf68Go-CnwPY7KuRqAnMmmlNwsvmbOlXTL4bNq1-7NM0eV7m84AtsOScMeQ-jSX6rhBQ9Qv4jN2GesVbZKKLKBW51s0Clga7FDThFuibbgUkBCubcfubGkPRMRkD-V53x28CJ0Qq1_zVx5-PuVKaw2M7YIb47faDDdOntzp2sZeA-D5SEsqnVTOptsBx1nni12HRmJRev3UKBM1PEIeiMbRnGqWD1Gut9VEl2Zkj0V0AEKB2JJLY8uqCelgaDHJrrMygnuAabQv9fSABKglldS13ZXN0LTIwsgQ.m3u8');
  late ChewieController chewieController;
  var url =
      'http://136.169.226.9/001-999-190/preview.mp4?token=27810dc662e84e1dba44d0d681d057b2';

  @override
  void initState() {
    // TODO: implement initState
    // super.initState();
    // chewieController = ChewieController(
    //   videoPlayerController: videoPlayerController,
    //   aspectRatio: 3 / 2,
    //   autoPlay: true,
    //   looping: true,
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dark & Light theme'),
        actions: [
          DropdownButton(
            underline: Container(),
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.exit_to_app),
                      SizedBox(width: 8),
                      Text('Logout'),
                    ],
                  ),
                ),
                value: 'logout',
              ),
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          ),
        ],
      ),
      body: Container(
        //child: Chewie(controller: chewieController),
        child: WebView(
          initialUrl:
              'http://136.169.226.202/1502958676/preview.mp4?token=fe1831250a4849c9b7804d3dcc148aaf',
        ),
      ),
    );
  }
}
