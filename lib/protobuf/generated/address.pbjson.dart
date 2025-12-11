///
//  Generated code. Do not modify.
//  source: address.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use coordinatesDescriptor instead')
const Coordinates$json = const {
  '1': 'Coordinates',
  '2': const [
    const {'1': 'latitude', '3': 1, '4': 1, '5': 1, '10': 'latitude'},
    const {'1': 'longitude', '3': 2, '4': 1, '5': 1, '10': 'longitude'},
  ],
};

/// Descriptor for `Coordinates`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List coordinatesDescriptor = $convert.base64Decode('CgtDb29yZGluYXRlcxIaCghsYXRpdHVkZRgBIAEoAVIIbGF0aXR1ZGUSHAoJbG9uZ2l0dWRlGAIgASgBUglsb25naXR1ZGU=');
@$core.Deprecated('Use addressDescriptor instead')
const Address$json = const {
  '1': 'Address',
  '2': const [
    const {'1': 'coordinates', '3': 1, '4': 1, '5': 11, '6': '.address.Coordinates', '10': 'coordinates'},
    const {'1': 'country', '3': 2, '4': 1, '5': 9, '10': 'country'},
    const {'1': 'state', '3': 3, '4': 1, '5': 9, '10': 'state'},
    const {'1': 'city', '3': 4, '4': 1, '5': 9, '10': 'city'},
    const {'1': 'suburb', '3': 5, '4': 1, '5': 9, '10': 'suburb'},
    const {'1': 'streetAddress', '3': 6, '4': 1, '5': 9, '10': 'streetAddress'},
    const {'1': 'postCode', '3': 7, '4': 1, '5': 9, '10': 'postCode'},
    const {'1': 'completeAddress', '3': 8, '4': 1, '5': 9, '10': 'completeAddress'},
  ],
};

/// Descriptor for `Address`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addressDescriptor = $convert.base64Decode('CgdBZGRyZXNzEjYKC2Nvb3JkaW5hdGVzGAEgASgLMhQuYWRkcmVzcy5Db29yZGluYXRlc1ILY29vcmRpbmF0ZXMSGAoHY291bnRyeRgCIAEoCVIHY291bnRyeRIUCgVzdGF0ZRgDIAEoCVIFc3RhdGUSEgoEY2l0eRgEIAEoCVIEY2l0eRIWCgZzdWJ1cmIYBSABKAlSBnN1YnVyYhIkCg1zdHJlZXRBZGRyZXNzGAYgASgJUg1zdHJlZXRBZGRyZXNzEhoKCHBvc3RDb2RlGAcgASgJUghwb3N0Q29kZRIoCg9jb21wbGV0ZUFkZHJlc3MYCCABKAlSD2NvbXBsZXRlQWRkcmVzcw==');
@$core.Deprecated('Use detailedAddressDescriptor instead')
const DetailedAddress$json = const {
  '1': 'DetailedAddress',
  '2': const [
    const {'1': 'country', '3': 1, '4': 1, '5': 9, '10': 'country'},
    const {'1': 'state', '3': 2, '4': 1, '5': 9, '10': 'state'},
    const {'1': 'city', '3': 3, '4': 1, '5': 9, '10': 'city'},
    const {'1': 'suburb', '3': 4, '4': 1, '5': 9, '10': 'suburb'},
    const {'1': 'streetAddress', '3': 5, '4': 1, '5': 9, '10': 'streetAddress'},
    const {'1': 'postCode', '3': 6, '4': 1, '5': 9, '10': 'postCode'},
  ],
};

/// Descriptor for `DetailedAddress`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List detailedAddressDescriptor = $convert.base64Decode('Cg9EZXRhaWxlZEFkZHJlc3MSGAoHY291bnRyeRgBIAEoCVIHY291bnRyeRIUCgVzdGF0ZRgCIAEoCVIFc3RhdGUSEgoEY2l0eRgDIAEoCVIEY2l0eRIWCgZzdWJ1cmIYBCABKAlSBnN1YnVyYhIkCg1zdHJlZXRBZGRyZXNzGAUgASgJUg1zdHJlZXRBZGRyZXNzEhoKCHBvc3RDb2RlGAYgASgJUghwb3N0Q29kZQ==');
@$core.Deprecated('Use condensedAddressDescriptor instead')
const CondensedAddress$json = const {
  '1': 'CondensedAddress',
  '2': const [
    const {'1': 'details', '3': 1, '4': 1, '5': 9, '10': 'details'},
  ],
};

/// Descriptor for `CondensedAddress`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List condensedAddressDescriptor = $convert.base64Decode('ChBDb25kZW5zZWRBZGRyZXNzEhgKB2RldGFpbHMYASABKAlSB2RldGFpbHM=');
@$core.Deprecated('Use addressWIPDescriptor instead')
const AddressWIP$json = const {
  '1': 'AddressWIP',
  '2': const [
    const {'1': 'coordinates', '3': 1, '4': 1, '5': 11, '6': '.address.Coordinates', '10': 'coordinates'},
    const {'1': 'detailedAddress', '3': 2, '4': 1, '5': 11, '6': '.address.DetailedAddress', '9': 0, '10': 'detailedAddress'},
    const {'1': 'condensedAddress', '3': 3, '4': 1, '5': 11, '6': '.address.CondensedAddress', '9': 0, '10': 'condensedAddress'},
  ],
  '8': const [
    const {'1': 'payload'},
  ],
};

/// Descriptor for `AddressWIP`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addressWIPDescriptor = $convert.base64Decode('CgpBZGRyZXNzV0lQEjYKC2Nvb3JkaW5hdGVzGAEgASgLMhQuYWRkcmVzcy5Db29yZGluYXRlc1ILY29vcmRpbmF0ZXMSRAoPZGV0YWlsZWRBZGRyZXNzGAIgASgLMhguYWRkcmVzcy5EZXRhaWxlZEFkZHJlc3NIAFIPZGV0YWlsZWRBZGRyZXNzEkcKEGNvbmRlbnNlZEFkZHJlc3MYAyABKAsyGS5hZGRyZXNzLkNvbmRlbnNlZEFkZHJlc3NIAFIQY29uZGVuc2VkQWRkcmVzc0IJCgdwYXlsb2Fk');
