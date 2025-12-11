///
//  Generated code. Do not modify.
//  source: address.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class Coordinates extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Coordinates', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'address'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'latitude', $pb.PbFieldType.OD)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'longitude', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  Coordinates._() : super();
  factory Coordinates({
    $core.double? latitude,
    $core.double? longitude,
  }) {
    final _result = create();
    if (latitude != null) {
      _result.latitude = latitude;
    }
    if (longitude != null) {
      _result.longitude = longitude;
    }
    return _result;
  }
  factory Coordinates.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Coordinates.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Coordinates clone() => Coordinates()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Coordinates copyWith(void Function(Coordinates) updates) => super.copyWith((message) => updates(message as Coordinates)) as Coordinates; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Coordinates create() => Coordinates._();
  Coordinates createEmptyInstance() => create();
  static $pb.PbList<Coordinates> createRepeated() => $pb.PbList<Coordinates>();
  @$core.pragma('dart2js:noInline')
  static Coordinates getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Coordinates>(create);
  static Coordinates? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get latitude => $_getN(0);
  @$pb.TagNumber(1)
  set latitude($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLatitude() => $_has(0);
  @$pb.TagNumber(1)
  void clearLatitude() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get longitude => $_getN(1);
  @$pb.TagNumber(2)
  set longitude($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLongitude() => $_has(1);
  @$pb.TagNumber(2)
  void clearLongitude() => clearField(2);
}

class Address extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Address', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'address'), createEmptyInstance: create)
    ..aOM<Coordinates>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'coordinates', subBuilder: Coordinates.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'country')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'state')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'city')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'suburb')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'streetAddress', protoName: 'streetAddress')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'postCode', protoName: 'postCode')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'completeAddress', protoName: 'completeAddress')
    ..hasRequiredFields = false
  ;

  Address._() : super();
  factory Address({
    Coordinates? coordinates,
    $core.String? country,
    $core.String? state,
    $core.String? city,
    $core.String? suburb,
    $core.String? streetAddress,
    $core.String? postCode,
    $core.String? completeAddress,
  }) {
    final _result = create();
    if (coordinates != null) {
      _result.coordinates = coordinates;
    }
    if (country != null) {
      _result.country = country;
    }
    if (state != null) {
      _result.state = state;
    }
    if (city != null) {
      _result.city = city;
    }
    if (suburb != null) {
      _result.suburb = suburb;
    }
    if (streetAddress != null) {
      _result.streetAddress = streetAddress;
    }
    if (postCode != null) {
      _result.postCode = postCode;
    }
    if (completeAddress != null) {
      _result.completeAddress = completeAddress;
    }
    return _result;
  }
  factory Address.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Address.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Address clone() => Address()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Address copyWith(void Function(Address) updates) => super.copyWith((message) => updates(message as Address)) as Address; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Address create() => Address._();
  Address createEmptyInstance() => create();
  static $pb.PbList<Address> createRepeated() => $pb.PbList<Address>();
  @$core.pragma('dart2js:noInline')
  static Address getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Address>(create);
  static Address? _defaultInstance;

  @$pb.TagNumber(1)
  Coordinates get coordinates => $_getN(0);
  @$pb.TagNumber(1)
  set coordinates(Coordinates v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasCoordinates() => $_has(0);
  @$pb.TagNumber(1)
  void clearCoordinates() => clearField(1);
  @$pb.TagNumber(1)
  Coordinates ensureCoordinates() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get country => $_getSZ(1);
  @$pb.TagNumber(2)
  set country($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCountry() => $_has(1);
  @$pb.TagNumber(2)
  void clearCountry() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get state => $_getSZ(2);
  @$pb.TagNumber(3)
  set state($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasState() => $_has(2);
  @$pb.TagNumber(3)
  void clearState() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get city => $_getSZ(3);
  @$pb.TagNumber(4)
  set city($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCity() => $_has(3);
  @$pb.TagNumber(4)
  void clearCity() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get suburb => $_getSZ(4);
  @$pb.TagNumber(5)
  set suburb($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasSuburb() => $_has(4);
  @$pb.TagNumber(5)
  void clearSuburb() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get streetAddress => $_getSZ(5);
  @$pb.TagNumber(6)
  set streetAddress($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasStreetAddress() => $_has(5);
  @$pb.TagNumber(6)
  void clearStreetAddress() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get postCode => $_getSZ(6);
  @$pb.TagNumber(7)
  set postCode($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasPostCode() => $_has(6);
  @$pb.TagNumber(7)
  void clearPostCode() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get completeAddress => $_getSZ(7);
  @$pb.TagNumber(8)
  set completeAddress($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasCompleteAddress() => $_has(7);
  @$pb.TagNumber(8)
  void clearCompleteAddress() => clearField(8);
}

class DetailedAddress extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DetailedAddress', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'address'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'country')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'state')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'city')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'suburb')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'streetAddress', protoName: 'streetAddress')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'postCode', protoName: 'postCode')
    ..hasRequiredFields = false
  ;

  DetailedAddress._() : super();
  factory DetailedAddress({
    $core.String? country,
    $core.String? state,
    $core.String? city,
    $core.String? suburb,
    $core.String? streetAddress,
    $core.String? postCode,
  }) {
    final _result = create();
    if (country != null) {
      _result.country = country;
    }
    if (state != null) {
      _result.state = state;
    }
    if (city != null) {
      _result.city = city;
    }
    if (suburb != null) {
      _result.suburb = suburb;
    }
    if (streetAddress != null) {
      _result.streetAddress = streetAddress;
    }
    if (postCode != null) {
      _result.postCode = postCode;
    }
    return _result;
  }
  factory DetailedAddress.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DetailedAddress.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DetailedAddress clone() => DetailedAddress()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DetailedAddress copyWith(void Function(DetailedAddress) updates) => super.copyWith((message) => updates(message as DetailedAddress)) as DetailedAddress; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DetailedAddress create() => DetailedAddress._();
  DetailedAddress createEmptyInstance() => create();
  static $pb.PbList<DetailedAddress> createRepeated() => $pb.PbList<DetailedAddress>();
  @$core.pragma('dart2js:noInline')
  static DetailedAddress getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DetailedAddress>(create);
  static DetailedAddress? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get country => $_getSZ(0);
  @$pb.TagNumber(1)
  set country($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCountry() => $_has(0);
  @$pb.TagNumber(1)
  void clearCountry() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get state => $_getSZ(1);
  @$pb.TagNumber(2)
  set state($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasState() => $_has(1);
  @$pb.TagNumber(2)
  void clearState() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get city => $_getSZ(2);
  @$pb.TagNumber(3)
  set city($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCity() => $_has(2);
  @$pb.TagNumber(3)
  void clearCity() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get suburb => $_getSZ(3);
  @$pb.TagNumber(4)
  set suburb($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSuburb() => $_has(3);
  @$pb.TagNumber(4)
  void clearSuburb() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get streetAddress => $_getSZ(4);
  @$pb.TagNumber(5)
  set streetAddress($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasStreetAddress() => $_has(4);
  @$pb.TagNumber(5)
  void clearStreetAddress() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get postCode => $_getSZ(5);
  @$pb.TagNumber(6)
  set postCode($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasPostCode() => $_has(5);
  @$pb.TagNumber(6)
  void clearPostCode() => clearField(6);
}

class CondensedAddress extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CondensedAddress', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'address'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'details')
    ..hasRequiredFields = false
  ;

  CondensedAddress._() : super();
  factory CondensedAddress({
    $core.String? details,
  }) {
    final _result = create();
    if (details != null) {
      _result.details = details;
    }
    return _result;
  }
  factory CondensedAddress.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CondensedAddress.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CondensedAddress clone() => CondensedAddress()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CondensedAddress copyWith(void Function(CondensedAddress) updates) => super.copyWith((message) => updates(message as CondensedAddress)) as CondensedAddress; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CondensedAddress create() => CondensedAddress._();
  CondensedAddress createEmptyInstance() => create();
  static $pb.PbList<CondensedAddress> createRepeated() => $pb.PbList<CondensedAddress>();
  @$core.pragma('dart2js:noInline')
  static CondensedAddress getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CondensedAddress>(create);
  static CondensedAddress? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get details => $_getSZ(0);
  @$pb.TagNumber(1)
  set details($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDetails() => $_has(0);
  @$pb.TagNumber(1)
  void clearDetails() => clearField(1);
}

enum AddressWIP_Payload {
  detailedAddress, 
  condensedAddress, 
  notSet
}

class AddressWIP extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, AddressWIP_Payload> _AddressWIP_PayloadByTag = {
    2 : AddressWIP_Payload.detailedAddress,
    3 : AddressWIP_Payload.condensedAddress,
    0 : AddressWIP_Payload.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AddressWIP', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'address'), createEmptyInstance: create)
    ..oo(0, [2, 3])
    ..aOM<Coordinates>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'coordinates', subBuilder: Coordinates.create)
    ..aOM<DetailedAddress>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'detailedAddress', protoName: 'detailedAddress', subBuilder: DetailedAddress.create)
    ..aOM<CondensedAddress>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'condensedAddress', protoName: 'condensedAddress', subBuilder: CondensedAddress.create)
    ..hasRequiredFields = false
  ;

  AddressWIP._() : super();
  factory AddressWIP({
    Coordinates? coordinates,
    DetailedAddress? detailedAddress,
    CondensedAddress? condensedAddress,
  }) {
    final _result = create();
    if (coordinates != null) {
      _result.coordinates = coordinates;
    }
    if (detailedAddress != null) {
      _result.detailedAddress = detailedAddress;
    }
    if (condensedAddress != null) {
      _result.condensedAddress = condensedAddress;
    }
    return _result;
  }
  factory AddressWIP.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddressWIP.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddressWIP clone() => AddressWIP()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddressWIP copyWith(void Function(AddressWIP) updates) => super.copyWith((message) => updates(message as AddressWIP)) as AddressWIP; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AddressWIP create() => AddressWIP._();
  AddressWIP createEmptyInstance() => create();
  static $pb.PbList<AddressWIP> createRepeated() => $pb.PbList<AddressWIP>();
  @$core.pragma('dart2js:noInline')
  static AddressWIP getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddressWIP>(create);
  static AddressWIP? _defaultInstance;

  AddressWIP_Payload whichPayload() => _AddressWIP_PayloadByTag[$_whichOneof(0)]!;
  void clearPayload() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  Coordinates get coordinates => $_getN(0);
  @$pb.TagNumber(1)
  set coordinates(Coordinates v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasCoordinates() => $_has(0);
  @$pb.TagNumber(1)
  void clearCoordinates() => clearField(1);
  @$pb.TagNumber(1)
  Coordinates ensureCoordinates() => $_ensure(0);

  @$pb.TagNumber(2)
  DetailedAddress get detailedAddress => $_getN(1);
  @$pb.TagNumber(2)
  set detailedAddress(DetailedAddress v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasDetailedAddress() => $_has(1);
  @$pb.TagNumber(2)
  void clearDetailedAddress() => clearField(2);
  @$pb.TagNumber(2)
  DetailedAddress ensureDetailedAddress() => $_ensure(1);

  @$pb.TagNumber(3)
  CondensedAddress get condensedAddress => $_getN(2);
  @$pb.TagNumber(3)
  set condensedAddress(CondensedAddress v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasCondensedAddress() => $_has(2);
  @$pb.TagNumber(3)
  void clearCondensedAddress() => clearField(3);
  @$pb.TagNumber(3)
  CondensedAddress ensureCondensedAddress() => $_ensure(2);
}

