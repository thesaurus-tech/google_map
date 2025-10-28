import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:stay_on/const.dart';
import 'package:stay_on/models/google_map/google_map_model.dart';
import 'package:stay_on/ui_components/base_class_impl_componets/app_theme_colors.dart';
import 'package:stay_on/ui_components/base_class_impl_componets/svg_icons.dart';
import 'package:stay_on/widgets/open_street_map.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:stay_on/models/firebase/address_collection.dart' as firebase;
import 'package:stay_on/models/protobuf/generated/address.pb.dart' as protobuf;
import 'package:stay_on/widgets/theme_data.dart' as theme;


enum AddressFieldType { country, state, city,suburb, pincode }

class GoogleMapServiceController extends StatefulWidget {
  final bool showMap;
  final bool readOnly;
  final bool showAutocomplete;
  final bool? isShowAddressFields;
  final bool isLookUpShowOnMap;
  final firebase.Address addressDb;
  final Function(firebase.Address) onAddressChanged;
  final Function(String)? onLookUpDataChange;
  final LatLng initialLocation;
  final String? lookUpData;
  final String? lookUpLabel;
  final bool isShowOnlyLookUp;
  final bool? isAddressLookupRequired;
  final protobuf.Address? filterAddress;
  final Color? backgroundColor;

  const GoogleMapServiceController({
    super.key,
    this.showMap = false,
    required this.isShowOnlyLookUp,
    this.showAutocomplete = true,
    this.isLookUpShowOnMap = false,
    required this.addressDb,
    required this.onAddressChanged,
    required this.initialLocation,
    this.isShowAddressFields = false,
    this.lookUpData = '',
    required this.readOnly,
    this.onLookUpDataChange,
    this.isAddressLookupRequired = true,
    this.filterAddress,
    this.backgroundColor,
    this.lookUpLabel,
  });

  @override
  State<GoogleMapServiceController> createState() =>
      _GoogleMapServiceControllerState();
}

class _GoogleMapServiceControllerState
    extends State<GoogleMapServiceController> {
  late GoogleMapModel googleMapModel;
  bool hasSuburbFieldBeenFocused = false;


  final Map<AddressFieldType, bool> isSelectedFromAutocomplete = {
    AddressFieldType.country: false,
    AddressFieldType.state: false,
    AddressFieldType.city: false,
    AddressFieldType.pincode: false,
  };


  @override
  void initState() {
    super.initState();
    googleMapModel = GoogleMapModel();
    // Safely assign fCountryName, fStateName, and fCityName
    googleMapModel.fCountryName = widget.filterAddress?.country ?? '';
    googleMapModel.fStateName = widget.filterAddress?.state ?? '';
    googleMapModel.fCityName = widget.filterAddress?.city ?? '';

    if (widget.initialLocation == GoogleMapModel.initialPosition.target) {
      googleMapModel.getCurrentLocation();
    } else {
      googleMapModel.initializeMap(widget.initialLocation);
    }

    if (widget.lookUpData != '') {
      googleMapModel.addressController.text = widget.lookUpData!;
    }

    googleMapModel.isMapVisible = widget.showMap;
    googleMapModel.isAddressFieldShow =
        widget.showMap || widget.isShowAddressFields! == true ? true : false;

    googleMapModel.countryController.text = widget.addressDb.data.country;
    googleMapModel.stateController.text = widget.addressDb.data.state;
    googleMapModel.cityController.text = widget.addressDb.data.city;
    googleMapModel.suburbController.text = widget.addressDb.data.suburb;
    googleMapModel.streetController.text = widget.addressDb.data.streetAddress;
    googleMapModel.pincodeController.text = widget.addressDb.data.postCode;
    googleMapModel.addressDb = widget.addressDb;
  }

  TextStyle addressFieldLabelTextStyle() {
    return const TextStyle(
      color: Color(0xFF0972FD),
      fontSize: 8,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w700,
    );
  }
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;
          // You can use constraints.maxWidth and constraints.maxHeight here
          return Container(
            height: 210,
            color: widget.backgroundColor ?? Colors.transparent,
            // width: googleMapModel.isMapVisible ? maxWidth : 850,
            width: maxWidth,
            child: !widget.isLookUpShowOnMap!
                ? Column(
                    children: [
                      if (!widget.isShowOnlyLookUp!)
                        Container(
                          height: googleMapModel.isMapVisible ? 210 : null,
                          child: Row(
                            children: [
                              if (googleMapModel.isMapVisible)
                                SizedBox(
                                  width: maxWidth * 0.3,
                                  // height: 500,
                                  child: Stack(
                                    children: [
                                      Container(
                                        child: widget.readOnly
                                            ? GoogleMap(
                                                initialCameraPosition:
                                                    GoogleMapModel
                                                        .initialPosition,
                                                onMapCreated:
                                                    (GoogleMapController
                                                        controller) {
                                                  googleMapModel.mapController
                                                      .complete(controller);
                                                },
                                                onCameraMove:
                                                    googleMapModel.onCameraMove,
                                                zoomGesturesEnabled: false,
                                                markers: googleMapModel
                                                            .marker !=
                                                        null
                                                    ? {googleMapModel.marker!}
                                                    : {},
                                              )
                                            : GoogleMap(
                                                initialCameraPosition:
                                                    GoogleMapModel
                                                        .initialPosition,
                                                onMapCreated:
                                                    (GoogleMapController
                                                        controller) async {
                                                  googleMapModel.mapController
                                                      .complete(controller);
                                                  // controller.setMapStyle(
                                                  //     await _loadMapStyle());
                                                },
                                                onTap: (LatLng tappedLocation) {
                                                  googleMapModel.reverseGeocode(
                                                      tappedLocation,
                                                      widget.addressDb,
                                                      widget
                                                          .onLookUpDataChange);
                                                  googleMapModel.addMarker(
                                                      tappedLocation);
                                                  googleMapModel.moveCamera(
                                                      tappedLocation);
                                                },
                                                onCameraMove:
                                                    googleMapModel.onCameraMove,
                                                // onCameraIdle: _onCameraIdle,
                                                markers: googleMapModel
                                                            .marker !=
                                                        null
                                                    ? {googleMapModel.marker!}
                                                    : {},
                                              ),
                                      ),
                                      if (widget.readOnly)
                                        Positioned.fill(
                                          child: GestureDetector(
                                            onTap: _onOverlayTap,
                                            child: Container(
                                              color: Colors.black.withOpacity(
                                                  0.3), // Transparent black color
                                              child: Column(
                                                children: [
                                                  Align(
                                                      alignment:
                                                          Alignment.topRight,
                                                      child: Icon(
                                                        Icons.edit_location,
                                                        size: 30,
                                                      )),
                                                  Center(
                                                    child: googleMapModel
                                                            .showTapMessage
                                                        ? const Text(
                                                            'Turn on edit mode',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 30,
                                                              wordSpacing: 3,
                                                              // fontWeight:
                                                              //     FontWeight.w600,
                                                            ),
                                                          )
                                                        : null,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              if (googleMapModel.isAddressFieldShow ||
                                  widget.isShowAddressFields!)
                                Expanded(
                                  child: Container(
                                      // color: Color.fromARGB(87, 115, 123, 107),
                                      // width: 500,
                                      height: googleMapModel.isMapVisible
                                          ? 210
                                          : null,
                                      child:

                                          //---------------------------------------------------------is Map visible------------------//
                                          Column(
                                        children: [
                                          Wrap(
                                            spacing: 20,
                                            runSpacing: 20,
                                            alignment:
                                                WrapAlignment.spaceEvenly,
                                            runAlignment:
                                                WrapAlignment.spaceEvenly,
                                            children: [
                                              //-----------------------------------------------------------lookup

                                              if (widget
                                                  .isAddressLookupRequired!)
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      if (widget.lookUpLabel !=
                                                          null)
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            horizontal: 6.0,
                                                          ),
                                                          child: Text(
                                                            '*${widget.lookUpLabel}',
                                                            style: TextStyle(
                                                              color: AppColors
                                                                  .primary200,
                                                              fontSize: 10,
                                                              fontFamily:
                                                                  'Inter',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ),
                                                      if (widget.lookUpLabel !=
                                                          null)
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                      Container(
                                                        width: googleMapModel
                                                                .isMapVisible
                                                            ? maxWidth * 0.4
                                                            : maxWidth * 0.6,
                                                        height: 25,
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 6,
                                                                vertical: 3),
                                                        decoration:
                                                            ShapeDecoration(
                                                          color: Colors.white,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            side: BorderSide(
                                                              width: 1,
                                                              color: const Color(
                                                                  0xFFB9DDFE),
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                          ),
                                                        ),
                                                        child: Autocomplete<
                                                            String>(
                                                          optionsBuilder:
                                                              (TextEditingValue
                                                                  textEditingValue) async {
                                                            // If the widget is in read-only mode or the input field is empty, return an empty list
                                                            if (widget
                                                                    .readOnly ||
                                                                textEditingValue
                                                                        .text ==
                                                                    '') {
                                                              return const Iterable<
                                                                  String>.empty();
                                                            } else {
                                                              return googleMapModel.fetchSuggestions(
                                                                  textEditingValue
                                                                      .text,
                                                                  SuggestionType
                                                                      .place,
                                                                  isShowOnlyLookUp:
                                                                      widget
                                                                          .isShowOnlyLookUp);
                                                            }
                                                          },
                                                          // onSelected: (String
                                                          //     selection) {
                                                          //   // When a suggestion is selected, update the text in the address controller
                                                          //   googleMapModel
                                                          //       .addressController
                                                          //       .text = selection;

                                                          //   // Perform geocoding based on the selected address
                                                          //   googleMapModel
                                                          //       .addressGeocode(
                                                          //     googleMapModel
                                                          //         .addressController
                                                          //         .text,
                                                          //     widget.addressDb,
                                                          //     widget
                                                          //         .onLookUpDataChange,
                                                          //   )
                                                          //       .then((_) {
                                                          //     setState(() {
                                                          //       widget.addressDb !=
                                                          //           googleMapModel
                                                          //               .addressDb!;
                                                          //       widget.onAddressChanged(
                                                          //           googleMapModel
                                                          //               .addressDb!);
                                                          //       print(
                                                          //           'indside service ${googleMapModel.addressDb!}');
                                                          //     });
                                                          //   });
                                                          // },
                                                          onSelected: (String selection) {
                                                              googleMapModel.addressController.text = selection;

                                                              googleMapModel.addressGeocode(
                                                                googleMapModel.addressController.text,
                                                                widget.addressDb,
                                                                widget.onLookUpDataChange,
                                                              ).then((_) {
                                                                setState(() {
                                                                  widget.onAddressChanged(googleMapModel.addressDb!);

                                                                  // Mark fields as valid only if values are filled from lookup
                                                                  isSelectedFromAutocomplete[AddressFieldType.country] = true;
                                                                  isSelectedFromAutocomplete[AddressFieldType.state] = true;
                                                                  isSelectedFromAutocomplete[AddressFieldType.city] = true;
                                                                  isSelectedFromAutocomplete[AddressFieldType.suburb] = true;
                                                                  isSelectedFromAutocomplete[AddressFieldType.pincode] = true;

                                                                  googleMapModel.countryValidationState =
                                                                      googleMapModel.countryController.text.isNotEmpty
                                                                          ? ValidationState.valid
                                                                          : ValidationState.invalid;

                                                                  googleMapModel.stateValidationState =
                                                                      googleMapModel.stateController.text.isNotEmpty
                                                                          ? ValidationState.valid
                                                                          : ValidationState.invalid;

                                                                  googleMapModel.cityValidationState =
                                                                      googleMapModel.cityController.text.isNotEmpty
                                                                          ? ValidationState.valid
                                                                          : ValidationState.invalid;

                                                                  googleMapModel.suburbValidationState =
                                                                      googleMapModel.suburbController.text.isNotEmpty
                                                                          ? ValidationState.valid
                                                                          : ValidationState.invalid;

                                                                  googleMapModel.pincodeValidationState =
                                                                      googleMapModel.pincodeController.text.isNotEmpty
                                                                          ? ValidationState.valid
                                                                          : ValidationState.invalid;

                                                                  googleMapModel.isAddressFieldShow = true;
                                                                });
                                                              });
                                                            },

                                                          optionsViewBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  AutocompleteOnSelected<
                                                                          String>
                                                                      onSelected,
                                                                  Iterable<
                                                                          String>
                                                                      options) {
                                                            // Builds the dropdown list to show autocomplete suggestions
                                                            return Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              child: Material(
                                                                elevation:
                                                                    4.0, // Adds a shadow to the dropdown
                                                                child:
                                                                    Container(
                                                                  width:
                                                                      300, // Set the width of the dropdown
                                                                  height:
                                                                      200, // Set the height of the dropdown
                                                                  child: ListView
                                                                      .builder(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            10.0),
                                                                    itemCount:
                                                                        options
                                                                            .length, // Number of options to show
                                                                    itemBuilder:
                                                                        (BuildContext
                                                                                context,
                                                                            int index) {
                                                                      final String
                                                                          option =
                                                                          options
                                                                              .elementAt(index);
                                                                      // Check if the current option is highlighted (focused)
                                                                      final bool
                                                                          highlightedIndex =
                                                                          AutocompleteHighlightedOption.of(context) ==
                                                                              index;

                                                                      return GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          // When an option is tapped, call the onSelected callback with the selected option
                                                                          onSelected(
                                                                              option);
                                                                          setState(
                                                                              () {
                                                                            googleMapModel.isAddressFieldShow =
                                                                                true; // Show additional fields if necessary
                                                                          });
                                                                        },
                                                                        child:
                                                                            ListTile(
                                                                          // Change the background color if the option is highlighted
                                                                          tileColor: highlightedIndex
                                                                              ? Colors.black12
                                                                              : null,
                                                                          title:
                                                                              Text(
                                                                            option,
                                                                            style:
                                                                                theme.kAddressTextStyle,
                                                                          ), // Display the option text
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          fieldViewBuilder: (BuildContext
                                                                  context,
                                                              TextEditingController
                                                                  fieldTextEditingController,
                                                              FocusNode
                                                                  fieldFocusNode,
                                                              VoidCallback
                                                                  onFieldSubmitted) {
                                                            // Ensure the lookup data is shown if the field is empty and isShowOnlyLookUp is true
                                                            SchedulerBinding
                                                                .instance
                                                                ?.addPostFrameCallback(
                                                                    (_) {
                                                              if (widget
                                                                      .isShowOnlyLookUp &&
                                                                  fieldTextEditingController
                                                                      .text
                                                                      .isEmpty) {
                                                                fieldTextEditingController
                                                                        .text =
                                                                    widget
                                                                        .lookUpData!;
                                                              }
                                                            });

                                                            // Builds the text field for address input
                                                            return TextFormField(
                                                              style: theme
                                                                  .kAddressTextStyle,
                                                              controller: googleMapModel
                                                                      .addressController =
                                                                  fieldTextEditingController,
                                                              focusNode:
                                                                  fieldFocusNode,

                                                              readOnly: widget
                                                                  .readOnly, // Disable editing if in read-only mode
                                                              decoration:
                                                                  InputDecoration(
                                                                contentPadding:
                                                                    EdgeInsets
                                                                        .only(
                                                                            top:
                                                                                2),
                                                                isCollapsed:
                                                                    true,
                                                                isDense: true,
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                prefixIcon: AppIcons
                                                                    .search
                                                                    .extraSmall,

                                                                prefixIconConstraints:
                                                                    BoxConstraints(
                                                                  maxHeight: 20,
                                                                  maxWidth: 20,
                                                                ),
                                                                suffixIcon: widget
                                                                        .showMap
                                                                    ? Container(
                                                                        // width: 50,
                                                                        child:
                                                                            IconButton(
                                                                          padding:
                                                                              EdgeInsets.all(0),
                                                                          iconSize:
                                                                              15,
                                                                          icon:
                                                                              Icon(Icons.map_rounded),
                                                                          constraints:
                                                                              BoxConstraints(),
                                                                          onPressed:
                                                                              () {
                                                                            // Toggle the visibility of the map when the map icon is pressed
                                                                            setState(() {
                                                                              googleMapModel.isMapVisible = !googleMapModel.isMapVisible;
                                                                            });
                                                                          },
                                                                        ),
                                                                      )
                                                                    : null, // No icon if showMap is false
                                                                suffixIconConstraints:
                                                                    BoxConstraints(
                                                                  maxHeight: 20,
                                                                  maxWidth: 20,
                                                                ),
                                                                hintText:
                                                                    'Enter address to lookup ', // Placeholder text
                                                                // hintStyle: theme.kAddressHintTextStyle
                                                              ),
                                                              onFieldSubmitted:
                                                                  (value) {
                                                                onFieldSubmitted(); // Handle field submission
                                                              },
                                                              onSaved: (value) {
                                                                // Optionally save the value or perform additional actions
                                                              },
                                                              onChanged:
                                                                  (value) {
                                                                // Handle changes to the text field, e.g., reset related data
                                                              },
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                              //-----------------------------------------------------------country
                                              
                                              Container(
                                        width: googleMapModel.isMapVisible ? maxWidth * 0.21 : maxWidth * 0.3,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Country', style: addressFieldLabelTextStyle()),
                                            SizedBox(height: 5),

                                            /// --- Autocomplete for Country ---
                                            Autocomplete<String>(
                                              initialValue: TextEditingValue(text: widget.addressDb.data.country),
                                              // Generate suggestions as the user types
                                              optionsBuilder: (TextEditingValue textEditingValue) async {
                                                if (widget.readOnly || textEditingValue.text.isEmpty) {
                                                  // Mark field as empty if nothing is typed or in read-only
                                                  setState(() => googleMapModel.countryValidationState = ValidationState.empty);
                                                  return const Iterable<String>.empty();
                                                }
                                                return googleMapModel.fetchSuggestions(
                                                  textEditingValue.text,
                                                  SuggestionType.country,
                                                );
                                              },

                                              // Called when user taps a suggestion
                                              onSelected: (String selection) async {
                                                // Set flag to true → selected from dropdown
                                                isSelectedFromAutocomplete[AddressFieldType.country] = true;

                                                // Update controller with the selection
                                                googleMapModel.countryController.text = selection;

                                                // Update region code for filtering dependent fields
                                                googleMapModel.setRegionCode(selection);

                                                // Mark validation as valid and save to model
                                                setState(() {
                                                  googleMapModel.countryValidationState = ValidationState.valid;
                                                  widget.addressDb.data.country = selection;
                                                  widget.onAddressChanged(googleMapModel.addressDb!);
                                                });

                                                // Trigger geocode lookup
                                                googleMapModel.geocode(selection);
                                              },

                                              // UI for dropdown list of suggestions
                                              optionsViewBuilder: (
                                                BuildContext context,
                                                AutocompleteOnSelected<String> onSelected,
                                                Iterable<String> options,
                                              ) {
                                                ScrollController scrollController = ScrollController();

                                                return Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Material(
                                                    elevation: 4.0,
                                                    child: Container(
                                                      width: 300,
                                                      height: 200,
                                                      child: ListView.builder(
                                                        controller: scrollController,
                                                        padding: EdgeInsets.all(10.0),
                                                        itemCount: options.length,
                                                        itemBuilder: (BuildContext context, int index) {
                                                          final bool highlight = AutocompleteHighlightedOption.of(context) == index;
                                                          final String option = options.elementAt(index);

                                                          // Auto-scroll to highlighted item
                                                          if (highlight && scrollController.hasClients) {
                                                            WidgetsBinding.instance.addPostFrameCallback((_) {
                                                              scrollController.animateTo(
                                                                index * 40.0,
                                                                duration: const Duration(milliseconds: 100),
                                                                curve: Curves.easeInOut,
                                                              );
                                                            });
                                                          }

                                                          return GestureDetector(
                                                            onTap: () => onSelected(option),
                                                            child: ListTile(
                                                              tileColor: highlight ? Colors.black12 : null,
                                                              title: Text(option, style: theme.kAddressTextStyle),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },

                                              // Build the input field
                                              fieldViewBuilder: (
                                                BuildContext context,
                                                TextEditingController fieldTextEditingController,
                                                FocusNode fieldFocusNode,
                                                VoidCallback onFieldSubmitted,
                                              ) {
                                                // Prefill value and validate on first render
                                                SchedulerBinding.instance.addPostFrameCallback((_) {
                                                  if (fieldTextEditingController.text.isEmpty) {
                                                    fieldTextEditingController.text = widget.addressDb.data.country;
                                                  }

                                                  // Validation state depends on selection source
                                                  googleMapModel.countryValidationState =
                                                    isSelectedFromAutocomplete[AddressFieldType.country] == true
                                                        ? ValidationState.valid
                                                        : ValidationState.invalid;
                                                });

                                                return TextFormField(
                                                  style: theme.kAddressTextStyle,
                                                  controller: googleMapModel.countryController = fieldTextEditingController,
                                                  readOnly: widget.readOnly,
                                                  focusNode: fieldFocusNode,
                                                  decoration: InputDecoration(
                                                            isDense: true,
                                                            enabledBorder: UnderlineInputBorder(
                                                              borderSide: BorderSide(color: AppColors.primary200, width: 1),
                                                            ),
                                                            focusedBorder: UnderlineInputBorder(
                                                              borderSide: BorderSide(color: Color(0xFF0972FD), width: 1),
                                                            ),
                                                            suffixIconConstraints: BoxConstraints(minWidth: 20, minHeight: 20),
                                                            suffixIcon: Builder(
                                                              builder: (context) {
                                                                final isSelected = isSelectedFromAutocomplete[AddressFieldType.country] ?? false;
                                                                final text = googleMapModel.countryController.text.trim();

                                                                if (text.isEmpty) {
                                                                  return Icon(Icons.close, color: Colors.red);
                                                                } else if (isSelected) {
                                                                  return Icon(Icons.check, color: Colors.green);
                                                                } else {
                                                                  return Icon(Icons.close, color: Colors.red);
                                                                }
                                                              },
                                                            ),
                                                          ),
                                                  onFieldSubmitted: (value) => onFieldSubmitted(),

                                                  // If user types manually, invalidate
                                                  onChanged: (value) {
                                                    setState(() {
                                                      isSelectedFromAutocomplete[AddressFieldType.country] = false;
                                                      googleMapModel.countryValidationState = ValidationState.invalid;

                                                      // Update model
                                                      widget.addressDb.data.country = value;
                                                      widget.onAddressChanged(googleMapModel.addressDb!);

                                                      // Clear dependent address fields
                                                      googleMapModel.stateController.clear();
                                                      googleMapModel.cityController.clear();
                                                      googleMapModel.suburbController.clear();
                                                      googleMapModel.streetController.clear();
                                                      googleMapModel.pincodeController.clear();

                                                      widget.addressDb.data.state = '';
                                                      widget.addressDb.data.city = '';
                                                      widget.addressDb.data.suburb = '';
                                                      widget.addressDb.data.streetAddress = '';
                                                      widget.addressDb.data.postCode = '';

                                                      isSelectedFromAutocomplete[AddressFieldType.state] = false;
                                                      isSelectedFromAutocomplete[AddressFieldType.city] = false;
                                                      isSelectedFromAutocomplete[AddressFieldType.suburb] = false;
                                                    });
                                                  },
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),


                                              //----------------------------------------------------------------state

                                          Container(
                                                    width: googleMapModel.isMapVisible ? maxWidth * 0.21 : maxWidth * 0.3,
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text('State', style: addressFieldLabelTextStyle()),
                                                        SizedBox(height: 5),
                                                        Autocomplete<String>(
                                                          initialValue: TextEditingValue(text: widget.addressDb.data.state),
                                                          // Suggestion generator based on input
                                                          optionsBuilder: (TextEditingValue textEditingValue) async {
                                                            if (widget.readOnly || textEditingValue.text.isEmpty) {
                                                              setState(() => googleMapModel.stateValidationState = ValidationState.empty);
                                                              return const Iterable<String>.empty();
                                                            } else {
                                                              return googleMapModel.fetchSuggestions(
                                                                textEditingValue.text,
                                                                SuggestionType.state,
                                                              );
                                                            }
                                                          },

                                                          // Called when user selects from dropdown
                                                          onSelected: (String selection) async {
                                                            googleMapModel.stateController.text = selection;
                                                            isSelectedFromAutocomplete[AddressFieldType.state] = true; //  Mark as selected from dropdown

                                                            setState(() {
                                                              googleMapModel.stateValidationState = ValidationState.valid;
                                                              widget.addressDb.data.state = selection;
                                                              widget.onAddressChanged(googleMapModel.addressDb!);
                                                            });

                                                            // Optional geocoding
                                                            googleMapModel.geocode(selection);
                                                          },

                                                          // Dropdown list UI
                                                          optionsViewBuilder: (
                                                            BuildContext context,
                                                            AutocompleteOnSelected<String> onSelected,
                                                            Iterable<String> options,
                                                          ) {
                                                            ScrollController scrollController = ScrollController();

                                                            return Align(
                                                              alignment: Alignment.topLeft,
                                                              child: Material(
                                                                elevation: 4.0,
                                                                child: Container(
                                                                  width: 300,
                                                                  height: 200,
                                                                  child: ListView.builder(
                                                                    controller: scrollController,
                                                                    padding: EdgeInsets.all(10.0),
                                                                    itemCount: options.length,
                                                                    itemBuilder: (BuildContext context, int index) {
                                                                      final bool highlight = AutocompleteHighlightedOption.of(context) == index;
                                                                      final String option = options.elementAt(index);

                                                                      if (highlight && scrollController.hasClients) {
                                                                        WidgetsBinding.instance.addPostFrameCallback((_) {
                                                                          scrollController.animateTo(
                                                                            index * 40.0,
                                                                            duration: const Duration(milliseconds: 100),
                                                                            curve: Curves.easeInOut,
                                                                          );
                                                                        });
                                                                      }

                                                                      return GestureDetector(
                                                                        onTap: () => onSelected(option),
                                                                        child: ListTile(
                                                                          tileColor: highlight ? Colors.black12 : null,
                                                                          title: Text(option, style: theme.kAddressTextStyle),
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },

                                                          // TextField UI
                                                          fieldViewBuilder: (
                                                            BuildContext context,
                                                            TextEditingController fieldTextEditingController,
                                                            FocusNode fieldFocusNode,
                                                            VoidCallback onFieldSubmitted,
                                                          ) {
                                                            // Prefill with saved value
                                                            SchedulerBinding.instance.addPostFrameCallback((_) {
                                                              if (fieldTextEditingController.text.isEmpty) {
                                                                fieldTextEditingController.text = widget.addressDb.data.state;
                                                              }

                                                              // Set validation icon correctly on first build
                                                              googleMapModel.stateValidationState =
                                                                isSelectedFromAutocomplete[AddressFieldType.state] == true
                                                                    ? ValidationState.valid
                                                                    : fieldTextEditingController.text.isEmpty
                                                                        ? ValidationState.invalid
                                                                        : ValidationState.invalid;
                                                            });

                                                            return TextFormField(
                                                              style: theme.kAddressTextStyle,
                                                              controller: googleMapModel.stateController = fieldTextEditingController,
                                                              readOnly: widget.readOnly,
                                                              focusNode: fieldFocusNode,
                                                             decoration: InputDecoration(
                                                            isDense: true,
                                                            enabledBorder: UnderlineInputBorder(
                                                              borderSide: BorderSide(color: AppColors.primary200, width: 1),
                                                            ),
                                                            focusedBorder: UnderlineInputBorder(
                                                              borderSide: BorderSide(color: Color(0xFF0972FD), width: 1),
                                                            ),
                                                            suffixIconConstraints: BoxConstraints(minWidth: 20, minHeight: 20),
                                                            suffixIcon: Builder(
                                                              builder: (context) {
                                                                final isSelected = isSelectedFromAutocomplete[AddressFieldType.state] ?? false;
                                                                final text = googleMapModel.stateController.text.trim();

                                                                if (text.isEmpty) {
                                                                  return Icon(Icons.close, color: Colors.red);
                                                                } else if (isSelected) {
                                                                  return Icon(Icons.check, color: Colors.green);
                                                                } else {
                                                                  return Icon(Icons.close, color: Colors.red);
                                                                }
                                                              },
                                                            ),
                                                          ),
                                                              onSaved: (value) {},

                                                              onFieldSubmitted: (value) => onFieldSubmitted(),

                                                              onChanged: (value) {
                                                                setState(() {
                                                                  isSelectedFromAutocomplete[AddressFieldType.state] = false; //  User typing manually
                                                                  googleMapModel.stateValidationState = ValidationState.invalid;

                                                                  widget.addressDb.data.state = value;
                                                                  widget.onAddressChanged(googleMapModel.addressDb!);

                                                                  //  Reset dependent fields
                                                                  googleMapModel.cityController.clear();
                                                                  googleMapModel.suburbController.clear();
                                                                  googleMapModel.streetController.clear();
                                                                  googleMapModel.pincodeController.clear();

                                                                  widget.addressDb.data.city = '';
                                                                  widget.addressDb.data.suburb = '';
                                                                  widget.addressDb.data.streetAddress = '';
                                                                  widget.addressDb.data.postCode = '';

                                                                  isSelectedFromAutocomplete[AddressFieldType.city] = false;
                                                                  isSelectedFromAutocomplete[AddressFieldType.suburb] = false;
                                                                });
                                                              },
                                                            );
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),


                                              

                                              //--------------------------------------------------city

                                              Container(
                                                width:
                                                    googleMapModel.isMapVisible
                                                        ? maxWidth * 0.21
                                                        : maxWidth * 0.3,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text('City',
                                                        style:
                                                            addressFieldLabelTextStyle()),
                                                    SizedBox(height: 5),
                                               
                                                    Autocomplete<String>(
                                                      initialValue: TextEditingValue(text: widget.addressDb.data.city),
                                                      optionsBuilder: (TextEditingValue textEditingValue) async {
                                                        if (widget.readOnly || textEditingValue.text.isEmpty) {
                                                          setState(() => googleMapModel.cityValidationState = ValidationState.empty);
                                                          return const Iterable<String>.empty();
                                                        }
                                                        return googleMapModel.fetchSuggestions(textEditingValue.text, SuggestionType.city);
                                                      },
                                                      onSelected: (String selection) async {
                                                        googleMapModel.cityController.text = selection;

                                                        //  Mark this field as selected from autocomplete
                                                        isSelectedFromAutocomplete[AddressFieldType.city] = true;

                                                        setState(() {
                                                          googleMapModel.cityValidationState = ValidationState.valid;
                                                          widget.addressDb.data.city = selection;
                                                          widget.onAddressChanged(googleMapModel.addressDb!);
                                                        });

                                                        googleMapModel.geocode(selection);
                                                      },
                                                      optionsViewBuilder: (BuildContext context, AutocompleteOnSelected<String> onSelected, Iterable<String> options) {
                                                        ScrollController scrollController = ScrollController();

                                                        return Align(
                                                          alignment: Alignment.topLeft,
                                                          child: Material(
                                                            elevation: 4.0,
                                                            child: Container(
                                                              width: 300,
                                                              height: 200,
                                                              child: ListView.builder(
                                                                controller: scrollController,
                                                                padding: EdgeInsets.all(10.0),
                                                                itemCount: options.length,
                                                                itemBuilder: (BuildContext context, int index) {
                                                                  final bool highlight = AutocompleteHighlightedOption.of(context) == index;
                                                                  final String option = options.elementAt(index);

                                                                  if (highlight && scrollController.hasClients) {
                                                                    WidgetsBinding.instance.addPostFrameCallback((_) {
                                                                      scrollController.animateTo(index * 40.0, duration: Duration(milliseconds: 100), curve: Curves.easeInOut);
                                                                    });
                                                                  }

                                                                  return GestureDetector(
                                                                    onTap: () => onSelected(option),
                                                                    child: ListTile(
                                                                      tileColor: highlight ? Colors.black12 : null,
                                                                      title: Text(option, style: theme.kAddressTextStyle),
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      fieldViewBuilder: (BuildContext context, TextEditingController fieldTextEditingController, FocusNode fieldFocusNode, VoidCallback onFieldSubmitted) {
                                                        // Assign the controller
                                                        googleMapModel.cityController = fieldTextEditingController;

                                                        return TextFormField(
                                                          style: theme.kAddressTextStyle,
                                                          controller: fieldTextEditingController,
                                                          readOnly: widget.readOnly,
                                                          focusNode: fieldFocusNode,
                                                          decoration: InputDecoration(
                                                            isDense: true,
                                                            enabledBorder: UnderlineInputBorder(
                                                              borderSide: BorderSide(color: AppColors.primary200, width: 1),
                                                            ),
                                                            focusedBorder: UnderlineInputBorder(
                                                              borderSide: BorderSide(color: Color(0xFF0972FD), width: 1),
                                                            ),
                                                            suffixIconConstraints: BoxConstraints(minWidth: 20, minHeight: 20),
                                                            suffixIcon: Builder(
                                                              builder: (context) {
                                                                final isSelected = isSelectedFromAutocomplete[AddressFieldType.city] ?? false;
                                                                final text = googleMapModel.cityController.text.trim();

                                                                if (text.isEmpty) {
                                                                  return Icon(Icons.close, color: Colors.red);
                                                                } else if (isSelected) {
                                                                  return Icon(Icons.check, color: Colors.green);
                                                                } else {
                                                                  return Icon(Icons.close, color: Colors.red);
                                                                }
                                                              },
                                                            ),
                                                          ),
                                                          onSaved: (value) {},
                                                          onFieldSubmitted: (value) => onFieldSubmitted(),
                                                          onChanged: (value) {
                                                            setState(() {
                                                              //  Invalidate validation until user selects suggestion
                                                              isSelectedFromAutocomplete[AddressFieldType.city] = false;
                                                              googleMapModel.cityValidationState = ValidationState.invalid;

                                                              widget.addressDb.data.city = value;
                                                              widget.onAddressChanged(googleMapModel.addressDb!);

                                                              // Clear dependent fields
                                                              googleMapModel.suburbController.clear();
                                                              googleMapModel.streetController.clear();
                                                              googleMapModel.pincodeController.clear();

                                                              widget.addressDb.data.suburb = '';
                                                              widget.addressDb.data.streetAddress = '';
                                                              widget.addressDb.data.postCode = '';

                                                              isSelectedFromAutocomplete[AddressFieldType.suburb] = false;
                                                            });
                                                          },
                                                        );
                                                      },
                                                    ),

                                                  ],
                                                ),
                                              ),
                                              //--------------------------------------------------suburb
                                          
                                          Container(
                                            width: googleMapModel.isMapVisible ? maxWidth * 0.21 : maxWidth * 0.3,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('Suburb', style: addressFieldLabelTextStyle()),
                                                SizedBox(height: 5),

                                                IgnorePointer(
                                                  ignoring: widget.addressDb.data.country.isEmpty ||
                                                            widget.addressDb.data.state.isEmpty ||
                                                            widget.addressDb.data.city.isEmpty ||
                                                            isSelectedFromAutocomplete[AddressFieldType.country] != true||
                                                            isSelectedFromAutocomplete[AddressFieldType.state] != true||
                                                            isSelectedFromAutocomplete[AddressFieldType.city] != true,
                                                  child: Autocomplete<String>(
                                                    optionsBuilder: (TextEditingValue textEditingValue) async {
                                                      if (widget.readOnly || textEditingValue.text.isEmpty) {
                                                        return const Iterable<String>.empty();
                                                      }

                                                      return googleMapModel.fetchSuggestions(
                                                        textEditingValue.text,
                                                        SuggestionType.suburb , // Or SuggestionType.suburb if you create a new type
                                                        isShowOnlyLookUp: true,
                                                      );
                                                    },

                                                    onSelected: (String selection) {
                                                      isSelectedFromAutocomplete[AddressFieldType.suburb] = true;
                                                      googleMapModel.suburbController.text = selection;

                                                      setState(() {
                                                        widget.addressDb.data.suburb = selection;
                                                        widget.onAddressChanged(googleMapModel.addressDb!);
                                                        // Optional: suburbValidationState = ValidationState.valid;
                                                      });
                                                    },

                                                    optionsViewBuilder: (context, onSelected, options) {
                                                      ScrollController scrollController = ScrollController();

                                                      return Align(
                                                        alignment: Alignment.topLeft,
                                                        child: Material(
                                                          elevation: 4.0,
                                                          child: Container(
                                                            width: 300,
                                                            height: 200,
                                                            child: ListView.builder(
                                                              controller: scrollController,
                                                              padding: EdgeInsets.all(10.0),
                                                              itemCount: options.length,
                                                              itemBuilder: (context, index) {
                                                                final highlight = AutocompleteHighlightedOption.of(context) == index;
                                                                final option = options.elementAt(index);

                                                                if (highlight && scrollController.hasClients) {
                                                                  WidgetsBinding.instance.addPostFrameCallback((_) {
                                                                    scrollController.animateTo(
                                                                      index * 40.0,
                                                                      duration: const Duration(milliseconds: 100),
                                                                      curve: Curves.easeInOut,
                                                                    );
                                                                  });
                                                                }

                                                                return GestureDetector(
                                                                  onTap: () => onSelected(option),
                                                                  child: ListTile(
                                                                    tileColor: highlight ? Colors.black12 : null,
                                                                    title: Text(option, style: theme.kAddressTextStyle),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },

                                                    fieldViewBuilder: (
                                                      BuildContext context,
                                                      TextEditingController fieldTextEditingController,
                                                      FocusNode fieldFocusNode,
                                                      VoidCallback onFieldSubmitted,
                                                    ) {
                                                      SchedulerBinding.instance.addPostFrameCallback((_) {
                                                        if (fieldTextEditingController.text.isEmpty) {
                                                          fieldTextEditingController.text = widget.addressDb.data.suburb;
                                                        }
                                                      });

                                                      //   fieldFocusNode.addListener(() {
                                                      //   if (fieldFocusNode.hasFocus && !hasSuburbFieldBeenFocused) {
                                                      //     setState(() {
                                                      //       hasSuburbFieldBeenFocused = true;
                                                      //     });
                                                      //   }
                                                      // });

                                                      googleMapModel.suburbController = fieldTextEditingController;

                                                      return TextFormField(
                                                        style: theme.kAddressTextStyle,
                                                        controller: fieldTextEditingController,
                                                        readOnly: widget.readOnly ||
                                                                  widget.addressDb.data.country.isEmpty ||
                                                                  widget.addressDb.data.state.isEmpty ||
                                                                  widget.addressDb.data.city.isEmpty,
                                                        focusNode: fieldFocusNode,
                                                        decoration: addressFieldInputDecoration().copyWith(
                                                          hintText: () {
                                                          if (isSelectedFromAutocomplete[AddressFieldType.country] != true) {
                                                            return 'Select country';
                                                          } else if (isSelectedFromAutocomplete[AddressFieldType.state] != true) {
                                                            return 'Select state';
                                                          }  else if (isSelectedFromAutocomplete[AddressFieldType.city] != true) {
                                                            return 'Select city';
                                                          } else {
                                                            return 'Enter suburb';
                                                          }
                                                        }(),

                                                          suffixIcon: () {
                                                            final text = googleMapModel.suburbController.text;
                                                            if (text.isEmpty &&
                                                                widget.addressDb.data.country.isNotEmpty &&
                                                                widget.addressDb.data.state.isNotEmpty &&
                                                                widget.addressDb.data.city.isNotEmpty) {
                                                              return Icon(Icons.close, color: Colors.red, size: 18);
                                                            } else if (isSelectedFromAutocomplete[AddressFieldType.suburb] == true) {
                                                              return Icon(Icons.check, color: Colors.green, size: 18);
                                                            } else {
                                                              return Icon(Icons.close, color: Colors.red, size: 18);
                                                            }
                                                          }(),
                                                          suffixIconConstraints: BoxConstraints(minWidth: 20, minHeight: 20),
                                                        ),
                                                        onFieldSubmitted: (_) => onFieldSubmitted(),
                                                        onChanged: (value) {
                                                          setState(() {
                                                            isSelectedFromAutocomplete[AddressFieldType.suburb] = false;
                                                            widget.addressDb.data.suburb = value;
                                                            widget.onAddressChanged(googleMapModel.addressDb!);
                                                          });
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),


                                              //--------------------------------------------------pincode
                                             
                                                 Container(
                                                width: googleMapModel.isMapVisible ? maxWidth * 0.21 : maxWidth * 0.3,
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Pincode', style: addressFieldLabelTextStyle()),
                                                    SizedBox(height: 5),

                                                    IgnorePointer(
                                                      ignoring: widget.addressDb.data.country.isEmpty ||
                                                                widget.addressDb.data.state.isEmpty ||
                                                                widget.addressDb.data.city.isEmpty || 
                                                                isSelectedFromAutocomplete[AddressFieldType.country] != true ||
                                                                isSelectedFromAutocomplete[AddressFieldType.state] != true ||
                                                                isSelectedFromAutocomplete[AddressFieldType.city] != true,
                                                      child:
                                                      
                                                       Autocomplete<String>(
                                                        optionsBuilder: (TextEditingValue textEditingValue) async {
                                                          if (widget.readOnly || textEditingValue.text.isEmpty) {
                                                            setState(() => googleMapModel.pincodeValidationState = ValidationState.empty);
                                                            return const Iterable<String>.empty();
                                                          }

                                                          return googleMapModel.fetchSuggestions(
                                                            textEditingValue.text,
                                                            SuggestionType.pincode,
                                                          );
                                                        },

                                                        onSelected: (String selection) async {
                                                          isSelectedFromAutocomplete[AddressFieldType.pincode] = true;
                                                          googleMapModel.pincodeController.text = selection;

                                                          setState(() {
                                                            googleMapModel.pincodeValidationState = ValidationState.valid;
                                                            widget.addressDb.data.postCode = selection;
                                                            widget.onAddressChanged(googleMapModel.addressDb!);
                                                          });

                                                          googleMapModel.geocode(selection);
                                                        },
                                      


                                                        optionsViewBuilder: (context, onSelected, options) {
                                                          ScrollController scrollController = ScrollController();

                                                          return Align(
                                                            alignment: Alignment.topLeft,
                                                            child: Material(
                                                              elevation: 4.0,
                                                              child: Container(
                                                                width: 300,
                                                                height: 200,
                                                                child: ListView.builder(
                                                                  controller: scrollController,
                                                                  padding: EdgeInsets.all(10.0),
                                                                  itemCount: options.length,
                                                                  itemBuilder: (context, index) {
                                                                    final highlight = AutocompleteHighlightedOption.of(context) == index;
                                                                    final option = options.elementAt(index);

                                                                    if (highlight && scrollController.hasClients) {
                                                                      WidgetsBinding.instance.addPostFrameCallback((_) {
                                                                        scrollController.animateTo(
                                                                          index * 40.0,
                                                                          duration: const Duration(milliseconds: 100),
                                                                          curve: Curves.easeInOut,
                                                                        );
                                                                      });
                                                                    }

                                                                    return GestureDetector(
                                                                      onTap: () => onSelected(option),
                                                                      child: ListTile(
                                                                        tileColor: highlight ? Colors.black12 : null,
                                                                        title: Text(option, style: theme.kAddressTextStyle),
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },

                                                        fieldViewBuilder: (
                                                          BuildContext context,
                                                          TextEditingController fieldTextEditingController,
                                                          FocusNode fieldFocusNode,
                                                          VoidCallback onFieldSubmitted,
                                                        ) {
                                                          SchedulerBinding.instance.addPostFrameCallback((_) {
                                                            if (fieldTextEditingController.text.isEmpty) {
                                                              fieldTextEditingController.text = widget.addressDb.data.postCode;
                                                            }

                                                            googleMapModel.pincodeValidationState =
                                                              isSelectedFromAutocomplete[AddressFieldType.pincode] == true
                                                                  ? ValidationState.valid
                                                                  : ValidationState.invalid;
                                                          });

                                                          googleMapModel.pincodeController = fieldTextEditingController;

                                                          return TextFormField(
                                                            style: theme.kAddressTextStyle,
                                                            controller: fieldTextEditingController,
                                                            readOnly: widget.readOnly ||
                                                                      widget.addressDb.data.country.isEmpty ||
                                                                      widget.addressDb.data.state.isEmpty ||
                                                                      widget.addressDb.data.city.isEmpty,
                                                            focusNode: fieldFocusNode,
                                                            decoration:  addressFieldInputDecoration().copyWith(
                                                              isDense: true,
                                                               hintText: () {
                                                          if (isSelectedFromAutocomplete[AddressFieldType.country] != true) {
                                                            return 'Select country';
                                                          } else if (isSelectedFromAutocomplete[AddressFieldType.state] != true) {
                                                            return 'Select state';
                                                          }  else if (isSelectedFromAutocomplete[AddressFieldType.city] != true) {
                                                            return 'Select city';
                                                          } else {
                                                            return 'Enter pincode';
                                                          }
                                                        }(),
                                                             suffixIcon: () {
                                                            final text = googleMapModel.pincodeController.text;
                                                            if (text.isEmpty &&
                                                                widget.addressDb.data.country.isNotEmpty &&
                                                                widget.addressDb.data.state.isNotEmpty &&
                                                                widget.addressDb.data.city.isNotEmpty) {
                                                              return Icon(Icons.close, color: Colors.red, size: 18);
                                                            } else if (isSelectedFromAutocomplete[AddressFieldType.pincode] == true) {
                                                              return Icon(Icons.check, color: Colors.green, size: 18);
                                                            } else {
                                                              return Icon(Icons.close, color: Colors.red, size: 18);
                                                            }
                                                          }(),
                                                          suffixIconConstraints: BoxConstraints(minWidth: 20, minHeight: 20),
                                                            ),
                                                            onFieldSubmitted: (value) => onFieldSubmitted(),
                                                            onChanged: (value) {
                                                              setState(() {
                                                                isSelectedFromAutocomplete[AddressFieldType.pincode] = false;
                                                                googleMapModel.pincodeValidationState = ValidationState.invalid;

                                                                widget.addressDb.data.postCode = value;
                                                                widget.onAddressChanged(googleMapModel.addressDb!);
                                                              });
                                                            },
                                                          );
                                                        },
                                                      ),


                                                    ),
                                                  ],
                                                ),
                                              ),

                                              //--------------------------------------------------street
                                              Container(
                                                width:
                                                    googleMapModel.isMapVisible
                                                        ? maxWidth * 0.21
                                                        : maxWidth * 0.3,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        'Building Name And Street',
                                                        style:
                                                            addressFieldLabelTextStyle()),
                                                    SizedBox(height: 5),
                                                    TextFormField(
                                                      style: theme
                                                          .kAddressTextStyle,
                                                      controller: googleMapModel
                                                          .streetController,
                                                      readOnly: widget.readOnly,
                                                      decoration:
                                                          addressFieldInputDecoration(),
                                                      onSaved: (value) {
                                                        setState(() {
                                                          // address = value ?? '';
                                                        });
                                                      },
                                                      onChanged: (value) {
                                                        widget.addressDb.data
                                                                .streetAddress =
                                                            value;
                                                        widget.onAddressChanged(
                                                            googleMapModel
                                                                .addressDb!);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                ),
                            ],
                          ),
                        ),
                    ],
                  )
                : Container(),
          );
        },
      ),
    );
  }

  InputDecoration addressFieldInputDecoration() {
    return InputDecoration(
      isDense: true,
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary200, width: 1),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF0972FD), width: 1),
      ),
    );
  }

  void _onOverlayTap() {
    setState(() {
      googleMapModel.showTapMessage = true;
    });

    // Hide the message after 2 seconds
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          googleMapModel.showTapMessage = false;
        });
      }
    });
  }
}

// Future<String> _loadMapStyle() async {
//   return await rootBundle.loadString('assets/map_style.json');
// }
