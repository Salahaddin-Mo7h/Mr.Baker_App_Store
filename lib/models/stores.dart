

import 'package:cloud_firestore/cloud_firestore.dart';

class Stores {
  Timestamp? close_at = Timestamp(100000, 12000);
  Timestamp? open_at = Timestamp(600000, 40000);

  Stores({this.close_at,this.open_at});

  factory Stores.fromJson(Map<String, dynamic> json) {
    return Stores(
        close_at: json['close_at'],
        open_at: json['open_at']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['close_at'] = this.close_at;
    data['open_at'] = this.open_at;
    return data;
  }
}