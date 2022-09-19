import 'package:flutter/material.dart';

import '../models/cams.dart';
import './parking_item.dart';

class ParkingList extends StatelessWidget {
  final List<Cams> cams;
  ParkingList(
    this.cams,
  );

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: cams
          .map((tx) => ParkingItem(
                key: ValueKey(tx.number),
                cams: tx,
              ))
          .toList(),
    );
  }
}
