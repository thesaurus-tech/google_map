import 'package:google_map_submodule/protobuf/generated/address.pb.dart' as protobuf;

import 'dbcollection.dart';
import 'dart:convert';
// import 'package:stay_on/models/protobuf/generated/address.pb.dart' as protobuf;


typedef Address = DbObject<protobuf.Address>;
typedef AddressList = List<DbObject<protobuf.Address>>;
// typedef AddressListStream = Stream<AddressList>;

class AddressCollection extends DbCollection<protobuf.Address>{
  AddressCollection({required super.collectionPath});

  @override
  protobuf.Address fromProto3Json(Object json) {
      protobuf.Address object = protobuf.Address();
    object.mergeFromProto3Json(json);
    return object;
  }

  @override
  String toProto3Json(protobuf.Address object) {
    return jsonEncode(object.toProto3Json());
  

}
}