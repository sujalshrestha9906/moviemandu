import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_offline/flutter_offline.dart';

class ConnectionWidget extends StatelessWidget {
  final Widget widget;
  ConnectionWidget({required this.widget});

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder: (context, connectivity, child) {
        final bool connected = connectivity != ConnectivityResult.none;
        return widget;
      },
      child: Container(),
    );
  }
}
