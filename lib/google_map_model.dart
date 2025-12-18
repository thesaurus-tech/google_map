import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_map_submodule/const.dart';
import 'package:google_map_submodule/firebase/address_collection.dart' as firebase;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
// import 'package:stay_on/submodules/google_map_submodule/lib/const.dart';
// import 'package:stay_on/const.dart';
// import 'package:stay_on/ui_components/global_components/custom_widgets/searchble_drop_down.dart';
// import 'package:stay_on/widgets/open_street_map.dart';
import 'package:flutter/services.dart' show rootBundle;
// import 'package:stay_on/models/firebase/address_collection.dart' as firebase;
// import 'package:stay_on/models/protobuf/generated/address.pb.dart' as protobuf;
// import 'package:stay_on/widgets/theme_data.dart' as theme;

enum ValidationState { valid, invalid, empty }

//suggestions prediction type list const
enum SuggestionType { place, country, state, city,suburb,pincode,}

String regionCode = 'IN';

class GoogleMapModel with ChangeNotifier {
  GoogleMapModel();
  TextEditingController controller = TextEditingController();
  final Completer<GoogleMapController> mapController = Completer();
  TextEditingController addressController = TextEditingController();
  final RegExp latLongPattern = RegExp(r'^-?\d+(\.\d+)?,\s*-?\d+(\.\d+)?$');
  static CameraPosition initialPosition = CameraPosition(
    target: LatLng(12.968266, 77.601334),
    zoom: 14,
  );
  LatLng _currentPosition = initialPosition.target;
  Marker? marker;
  Completer<GoogleMapController> googleMapCompleter = Completer();
  GoogleMapController? googleMapController;
  String geoCodeResult = '';
  String reverseGeoCodeResult = '';
  String cameraPosition = '';
  late bool isMapVisible;
  bool isAddressFieldShow = false;
  String formattedAddress = '';
  Map addressData = {};
  String stateName = '';
  TextEditingController countryController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController suburbController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  ValidationState countryValidationState = ValidationState.empty;
  ValidationState stateValidationState = ValidationState.empty;
  ValidationState cityValidationState = ValidationState.empty;
  ValidationState suburbValidationState = ValidationState.empty;
  ValidationState pincodeValidationState = ValidationState.empty;
  Map<String, String> countryCodes = SplayTreeMap<String, String>();
  String geocodeOutput = '';
  List countrySuggestion = [];
  List stateSuggestion = [];
  List citySuggestion = [];
  List suburbSuggestion = [];
  List pincodeSuggestion = [];
  String fCountryName = '';
  String fStateName = '';
  String fCityName = '';
  bool _isAddressGeocoding = false;
  // Variable to store the current zoom level
  double _currentZoom = 15.0; // Default zoom level
  bool _isZooming = true;
  bool showTapMessage = false;
  firebase.Address? addressDb;

  //------------------------------------------------------

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, don't continue.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    final position = await Geolocator.getCurrentPosition();

    _currentPosition = LatLng(position.latitude, position.longitude);
    addMarker(_currentPosition);
    moveCamera(_currentPosition);

    notifyListeners();
  }

  Future<void> initializeMap(LatLng initialLocation) async {
    // Use the initial location provided by the widget.
    _currentPosition = initialLocation;

    // Add a marker at the initial location.
    addMarker(_currentPosition);

    // Move the camera to the initial location.
    // moveCamera(_currentPosition);
    if (mapController.isCompleted) {
    moveCamera(_currentPosition);
  } else {
    mapController.future.then((controller) {
      moveCamera(_currentPosition);
    });
  }
  }

  void addMarker(LatLng position) {
    marker = Marker(
      markerId: MarkerId(position.toString()),
      position: position,
      infoWindow: InfoWindow.noText, // This disables the popup
    );
    notifyListeners();
  }

  // Method to move the camera to a specific position with the current zoom level
  Future<void> moveCamera(LatLng targetLocation) async {
    mapController.future.then((controller) {
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: targetLocation,
            zoom: _currentZoom, // Use the current zoom level
          ),
        ),
      );
    });
    notifyListeners();
  }

  void onCameraMove(CameraPosition position) {
    if (position.zoom != _currentZoom) {
      // The user is zooming
      _isZooming = true;
    } else {
      // The user is panning (moving the map without zooming)
      _isZooming = false;
    }
    // Update the current zoom level
    _currentZoom = position.zoom;
    notifyListeners();
  }

  Future<void> onCameraIdle(LatLng initialLocation, bool isShowOnlyLookUp,
      firebase.Address addressDb, Function(String)? onLookUpDataChange) async {
    print('init ${initialLocation} current ${_currentPosition}');

    if (_isZooming) {
      if (_isAddressGeocoding) {
        _isAddressGeocoding = false; // Reset the flag
        return; // Skip reverse geocoding
      }
      if (isShowOnlyLookUp) {
        reverseGeocode(_currentPosition, addressDb, onLookUpDataChange);
      } else if (initialLocation != _currentPosition) {
        reverseGeocode(_currentPosition, addressDb, onLookUpDataChange);
      }
      addMarker(_currentPosition);
    }
    notifyListeners();
  }

  String convertLatLngToString(LatLng latLng) {
    return '${latLng.latitude}, ${latLng.longitude}';
  }

  Future<void> setRegionCode(String selection) async {
    final response = await http.get(
      Uri.parse(
          'https://maps.googleapis.com/maps/api/geocode/json?address=$selection&key=$apiKey'),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);

      if (data['results'].isNotEmpty) {
        var addressComponents = data['results'][0]['address_components'];

        for (var component in addressComponents) {
          if (component['types'].contains('country')) {
            regionCode = component['short_name'];
            break;
          }
        }

        print('The Region Code is: $regionCode');
      }
    } else {
      print('Failed to get geocoding data');
    }
    notifyListeners();
  }



  String removeFirstWord(String address) {
    // Find the index of the first comma
    int commaIndex = address.indexOf(',');

    // If there's a comma, return the substring starting from the character after the comma
    if (commaIndex != -1) {
      return address.substring(commaIndex + 1).trim();
    }

    // If there's no comma, split by space and remove the first word
    List<String> words = address.split(' ');
    words.removeAt(0); // Remove the first word
    return words
        .join(' ')
        .trim(); // Join the rest of the words back into a string
  }

 // this is to get the distance  between cities and suburbs 
// Future<Map<String, String>> getDistance({
//   required String origin,
//   required String destination,
// }) async {
//   if (origin.isEmpty || destination.isEmpty) {
//     throw ArgumentError('Both origin and destination must be provided.');
//   }

//   try {
//     final callable = FirebaseFunctions.instance.httpsCallable('getDistance');
//     final result = await callable.call({
//       'origin': origin,
//       'destination': destination,
//     });

//     final data = Map<String, dynamic>.from(result.data);

//     // Return in a clean format
//     return {
//       'distance': data['distance'] ?? '',
//       'duration': data['duration'] ?? '',
//     };
//   } on FirebaseFunctionsException catch (e) {
//     throw Exception('Firebase error: ${e.message}');
//   } catch (e) {
//     throw Exception('Unexpected error: $e');
//   }
// }
Future<Map<String, String>> getDistance({
  required String origin,
  required String destination,
}) async {
  if (origin.isEmpty || destination.isEmpty) {
    throw ArgumentError('Both origin and destination must be provided.');
  }

  final uri = Uri.parse('${dockerPath}getDistance'); 

  final body = jsonEncode({
    'origin': origin,
    'destination': destination,
  });

  try {
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return {
        'distance': data['distance'] ?? '',
        'duration': data['duration'] ?? '',
      };
    } else {
      throw Exception(
          'Go API Error: ${response.statusCode} ${response.reasonPhrase} - ${response.body}');
    }
  } catch (e) {
    throw Exception('Unexpected error calling Go API: $e');
  }
}
  String removeFirstWordIfPlusCode(String address) {
    // Split the address into a list of words using space as the delimiter.
    List<String> words = address.split(' ');

    // Check if the first word in the list matches the Plus Code pattern.
    if (words.isNotEmpty && words[0].contains('+')) {
      // If the first word is a Plus Code, remove it from the list.
      words.removeAt(0);
      print('words removed $words');
    }

    // Join the remaining words back into a single string and remove any leading/trailing spaces.
    return words.join(' ').trim();
  }

// Helper method to determine if a string is a Plus Code.
  bool isPlusCode(String word) {
    // Define a regular expression pattern that matches typical Plus Codes.
    // Plus Codes usually consist of 4-8 alphanumeric characters followed by a '+'
    // Exactly 4 alphanumeric characters, followed by a '+', followed by exactly 3 alphanumeric characters.
    final plusCodePattern = RegExp(r'^[A-Z0-9]{4}\+[A-Z0-9]{3}$');

    // Check if the provided word matches the Plus Code pattern and return true if it does.
    return plusCodePattern.hasMatch(word);
  }

/* The _parseAddressComponents method is designed to extract specific address components from the geocoding response returned by a mapping API (such as Google Maps API).
 The extracted components include country, state, city, suburb, street address, and postal code. These components are then assigned to their respective fields
  and text controllers in the UI, and a formatted street address is constructed by removing unnecessary components. 
  This method ensures that the parsed address data is stored correctly in the application's data model and is reflected in the UI. */
  void parseAddressComponents(Map<String, dynamic> data,
      firebase.Address addressDb, Function(firebase.Address) onAddressChanged) {
    print('mapAddress + $data');

    // Initialize variables to store the parsed address components.
    // These will hold the values for country, state, city, suburb, route (street name), and postal code.
    String country = '';
    String administrativeAreaLevel1 = '';
    String locality = '';
    String sublocality = '';
    String route = '';
    String postalCode = '';
    String streetAddress = '';

    // Extract latitude and longitude from the geocoding response as strings.
    // These are typically used for displaying the location on a map.
    String addressLat =
        data['results'][0]['geometry']['location']['lat'].toString();
    String addressLong =
        data['results'][0]['geometry']['location']['lng'].toString();

    // Extract the list of address components from the geocoding response.
    // This is a list where each item contains a part of the address and its type (e.g., country, locality).
    List components = data['results'][0]['address_components'];

    // Loop through each component in the address components list.
    for (var component in components) {
      // Check if the component is of type 'country' and assign its value to the 'country' variable.
      // Also, update the respective text controller and data model.
      if (component['types'].contains('country')) {
        country = component['long_name'];
        countryController.text = country;
        addressDb.data.country = country;
      }
      // Check if the component is of type 'administrative_area_level_1' (typically the state or province).
      // Assign its value to the 'administrativeAreaLevel1' variable, and update the text controller and data model.
      else if (component['types'].contains('administrative_area_level_1')) {
        administrativeAreaLevel1 = component['long_name'];
        stateController.text = administrativeAreaLevel1;
        addressDb.data.state = administrativeAreaLevel1;
      }
      // Check if the component is of type 'locality' (typically the city).
      // Assign its value to the 'locality' variable, and update the text controller and data model.
      else if (component['types'].contains('locality')) {
        locality = component['long_name'];
        cityController.text = locality;
        addressDb.data.city = locality;
      }
      // Check if the component is of type 'sublocality' or 'sublocality_level_1' (typically the suburb).
      // Assign its value to the 'sublocality' variable, or default to 'locality' if not found.
      // Update the text controller and data model.
      else if (component['types'].contains('sublocality') ||
          component['types'].contains('sublocality_level_1')) {
        sublocality = component['long_name'] ?? locality;
        suburbController.text = sublocality;
        addressDb.data.suburb = sublocality;
      }
      // Check if the component is of type 'route' (typically the street name).
      // Assign its value to the 'route' variable. The actual assignment to the data model is done later.
      else if (component['types'].contains('route')) {
        route = component['long_name'];
      }
      // Check if the component is of type 'postal_code'.
      // Assign its value to the 'postalCode' variable, and update the text controller and data model.
      else if (component['types'].contains('postal_code')) {
        postalCode = component['long_name'];
        pincodeController.text = postalCode;
        addressDb.data.postCode = postalCode;
      }
      notifyListeners();
    }

    // Split the 'formatted_address' into individual components using a comma as a separator.
    // This will create a list of address parts that can be further processed.
    List<String> addressComponents =
        (data['results'][0]["formatted_address"]).split(',');
    print('addressComponents $addressComponents');

    // Remove components that match any of the extracted address parts (country, state, city, suburb, street name, postal code).
    // This ensures that the remaining parts of the address will be used as the street address.
    addressComponents.removeWhere((component) =>
        component.trim() == country ||
        component.trim() == administrativeAreaLevel1 ||
        component.trim() == locality ||
        component.trim() == sublocality ||
        component.trim() == route ||
        component.trim() == postalCode ||
        component.trim() == '$administrativeAreaLevel1 $postalCode');

    // Join the remaining components to form the street address.
    // This combines the remaining parts of the address into a single string.
    streetAddress = addressComponents.join(',').trim();

    // Optionally remove the first word if it is a plus code.
    // This step is specific to addresses that might start with a plus code (a location code used by Google).
    String formattedAddress = removeFirstWordIfPlusCode(streetAddress);

    // Assign the final formatted address to the text controller and data model.
    addressDb.data.streetAddress = formattedAddress;
    streetController.text = formattedAddress;
    print('streetAddress: $formattedAddress');

    // Notify any listeners that the address has changed after parsing all components.
    onAddressChanged(addressDb);

    print('adresssssss ${addressDb.data.coordinates}');

    notifyListeners();
  }

  /// Performs a geocoding lookup for a given address using the Google Maps Geocoding API,
  /// updates the relevant fields (latitude, longitude, and address components),
  /// and notifies listeners upon completion.
  Future addressGeocode(String address, firebase.Address addressDb,
      Function(String)? onLookUpDataChange) async {
    // Store the API key for Google Maps Geocoding
    var api = apiKey;

    // Set a flag to indicate that the address geocoding process is in progress
    _isAddressGeocoding = true;

    // Set the text field for the address to the provided address
    addressController.text = address;

    // Clear the previous values in the suburb, street, and pincode text fields
    suburbController.clear();
    streetController.clear();
    pincodeController.clear();

    // Encode the address to make it URL-safe (e.g., replace spaces with %20)
    String encodedAddress = Uri.encodeComponent(address);

    try {
      // Send a GET request to the Google Maps Geocoding API with the encoded address and the API key
      final response = await http.get(Uri.parse(
          'https://maps.googleapis.com/maps/api/geocode/json?address=$encodedAddress&key=$api'));

      // Decode the JSON response into a Dart Map
      Map<String, dynamic> data = jsonDecode(response.body);

      // Check if the API request was successful and contains valid results
      if (response.statusCode == 200 &&
          data['status'] == 'OK' &&
          data['results'].isNotEmpty) {
        // Extract the formatted address from the first result in the API response
        String address = data['results'][0]['formatted_address'];

        // Extract the latitude and longitude from the first result
        double latitude = data['results'][0]['geometry']['location']['lat'];
        double longitude = data['results'][0]['geometry']['location']['lng'];

        // Create a LatLng object for the geocoded location
        LatLng currentPosition = LatLng(latitude, longitude);

        // Check if the coordinates object in the addressDb is not null before updating it
        if (addressDb.data.coordinates != null) {
          addressDb.data.coordinates.latitude = latitude;
          addressDb.data.coordinates.longitude = longitude;
        } else {
          // Print a message if the coordinates object is null
          print('Coordinates object is null.');
        }

        // Add a marker at the current geocoded location on the map
        addMarker(currentPosition);

        // Move the camera on the map to the current geocoded location
        moveCamera(currentPosition);

        // Parse address components (like street, suburb, etc.) from the API response
        // and update the addressDb with the new components
        parseAddressComponents(data, addressDb, (updatedAddress) {
          addressDb = updatedAddress;
        });

        // Store the final formatted address in the geoCodeResult variable
        geoCodeResult = address;

        // If the callback function is provided, invoke it with the updated address
        if (onLookUpDataChange != null) {
          onLookUpDataChange(addressController.text);
        }
      } else {
        print('Geocoding failed or no results found.');
      }
    } catch (e) {
      // Catch and print any error that occurs during the HTTP request or processing
      print('Error during geocoding: $e');
    } finally {
      // Notify listeners about the completion of the geocoding process
      notifyListeners();
    }
  }

  Future<String> reverseGeocode(LatLng latLng, firebase.Address addressDb,
      Function(String)? onLookUpDataChange) async {
    // Convert the LatLng object to a string representation (latitude,longitude).
    String coordinates = convertLatLngToString(latLng);
    String address = '';

    // Clear any previously filled values in the related address fields.
    suburbController.clear(); // Clear the suburb (neighborhood) field.
    streetController.clear(); // Clear the street name field.
    pincodeController.clear(); // Clear the postal code field.

    // Split the coordinates string into latitude and longitude components.
    List<String> latlngStr = coordinates.split(",");

    // Check if the coordinates string was properly split into exactly two components.
    if (latlngStr.length == 2) {
      // Parse the latitude and longitude strings into double values.
      double currentLatitude = double.parse(latlngStr[0].trim());
      double currentLongitude = double.parse(latlngStr[1].trim());

      // Update the address database with the parsed latitude and longitude.
      addressDb.data.coordinates.latitude = currentLatitude;
      addressDb.data.coordinates.longitude = currentLongitude;

      // Validate that the latitude and longitude values are within valid ranges.
      if (currentLatitude >= -90 &&
          currentLatitude <= 90 &&
          currentLongitude >= -180 &&
          currentLongitude <= 180) {
        // Create a LatLng object for the current position.
        LatLng currentPosition = LatLng(currentLatitude, currentLongitude);

        // Add a marker on the map at the current position.
        // _addMarker(currentPosition);

        // Send a GET request to the Google Maps Geocoding API with the current latitude and longitude.
        return http
            .get(Uri.parse(
                'https://maps.googleapis.com/maps/api/geocode/json?latlng=${currentPosition.latitude},${currentPosition.longitude}&key=$apiKey'))
            .then((response) {
          // Decode the JSON response from the API.
          Map<String, dynamic> data = jsonDecode(response.body);
          print('data $data');

          // Check if the HTTP response was successful.
          if (response.statusCode == 200) {
            // Check if the geocoding status is OK (i.e., valid results).
            if (data['status'] == 'OK') {
              // Extract the formatted address from the response.
              address = data['results'][0]['formatted_address'];

              // Remove the first word from the formatted address and update the address input field.
              addressController.text = removeFirstWord(address);

              // Print the formatted address for debugging purposes.
              print('Formatted address: $address');

              // Update the state with the formatted address to trigger a UI refresh.
              // setState(() {
              reverseGeoCodeResult = address;
              // });

              // Parse and update the address components using the extracted data.
              parseAddressComponents(data, addressDb, (updatedAddress) {
                addressDb = updatedAddress;
              });

              // Notify any listeners that the lookup data has changed.
              if (onLookUpDataChange != null) {
                onLookUpDataChange!(addressController.text);
              }
            }
          }
          notifyListeners();
          // Return the formatted address as the result of the method.
          return address;
        });
      }
    }

    // Return the reverse geocode result (which could be the formatted address or an empty string).
    return reverseGeoCodeResult;
  }

  void geocode(String address) async {
    String encodedAddress = Uri.encodeComponent(address);
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?address=$encodedAddress&key=$apiKey'));

    Map<String, dynamic> data = jsonDecode(response.body);
    //print(data);
    if (response.statusCode == 200) {
      //print(data['error_message']);
      String address = data['results'][0]['formatted_address'];
      //geocodeOutput=address;
      if (data['status'] == 'OK') {
        double latitude = data['results'][0]['geometry']['location']['lat'];
        double longitude = data['results'][0]['geometry']['location']['lng'];
        LatLng currentPosition = LatLng(latitude, longitude);
        // setState(() {
        geoCodeResult = address;
        // });
      } else {
        print(
            'Geocode was not successful for the following reason: ${data['status']}');
      }
    } else {
      print(data['error_message']);
      print(
          'Geocode was not successful for the following reason: ${response.statusCode}');
    }
    notifyListeners();
  }

  /// A function that retrieves place autocomplete suggestions based on the provided search string.
  /// The suggestions are fetched using the Google Places API.
  Future<List> getPlaceAutocomplete(
      String search, bool isShowOnlyLookUp) async {
    // Define the API endpoint for the autocomplete service.
    final String url = 'https://places.googleapis.com/v1/places:autocomplete';

    // Send an HTTP POST request to the Google Places API with the required headers and body.
    return http
        .post(
            // Convert the URL string to a Uri object.
            Uri.parse(url),
            headers: {
              // Set the content type to JSON, as the request body will be in JSON format.
              'Content-Type': 'application/json',
              // Provide the API key for authentication with the Google Places service.
              'X-Goog-Api-Key': apiKey,
            },
            // Convert the request body to JSON format. The body includes the search input and
            // additional filtering based on the user's location preferences if `isShowOnlyLookUp` is true.
            body: jsonEncode({
              'input':
                  isShowOnlyLookUp // Check if only lookup mode is enabled, and concatenate the search string with location filters.
                      ? '$search,$fCityName, $fStateName,$fCountryName'
                      : search, // : search, // Use only the search string if lookup mode is disabled.
              //  ',
              //---------------------------------------------------------
              // Include query predictions to enhance autocomplete results.
              'includeQueryPredictions': true,
              // Set the language code to English for the results.
              'languageCode': 'en',
            }))
        // Handle the response returned by the API.
        .then((response) {
      // Check if the response status code is 200 (OK), indicating a successful request.
      if (response.statusCode == 200) {
        // Parse the response body as JSON and extract the data.
        Map<String, dynamic> data = json.decode(response.body);
        // Return the list of suggestions from the parsed data, or an empty list if suggestions are not found.
        notifyListeners();

        return data['suggestions'] ?? [];
      } else {
        // If the response status code is not 200, throw an exception to indicate the failure.
        throw Exception('Failed to load autocomplete results');
      }
    });
  }

//------------------------------------------------------------------------------------------getCountryList
// A function that retrieves country suggestions based on the provided search string.
//The suggestions are fetched using the Google Places API with a filter to include only countries.
  Future<List> getCountry(String search) async {
    // Initialize an empty list to store the results.
    List result = [];

    // Define the API endpoint for the autocomplete service.
    final String url = 'https://places.googleapis.com/v1/places:autocomplete';

    // Send an HTTP POST request to the Google Places API with the required headers and body.
    return http
        .post(
      // Convert the URL string to a Uri object.
      Uri.parse(url),
      headers: {
        // Set the content type to JSON, as the request body will be in JSON format.
        'Content-Type': 'application/json',
        // Provide the API key for authentication with the Google Places service.
        'X-Goog-Api-Key': apiKey,
      },
      // Convert the request body to JSON format. The body includes the search input and
      // additional filters to ensure only countries are included in the results.
      body: jsonEncode({
        // Pass the search string to the API as the input for place suggestions.
        'input': search,
        // Enable query predictions to enhance the autocomplete results.
        'includeQueryPredictions': true,
        // Set the language code to English for the results.
        'languageCode': 'en',
        // Filter the results to include only countries, excluding other place types.
        'includedPrimaryTypes': ['country']
      }),
    )
        .then((response) {
      // Handle the response returned by the API.
      if (response.statusCode == 200) {
        // Check if the response status code is 200 (OK), indicating a successful request.
        // Parse the response body as JSON and extract the data.
        Map<String, dynamic> data = json.decode(response.body);
        // Assign the list of suggestions from the parsed data to the result variable,
        // or use an empty list if no suggestions are found.
        result = data['suggestions'] ?? [];
      } else {
        // If the response status code is not 200, throw an exception to indicate the failure.
        throw Exception('Failed to load autocomplete results');
      }
      notifyListeners();

      // Return the result list containing the country suggestions.
      return result;
    });
  }

  //--------------------------------------------------------------------state
/* A function that retrieves state (administrative area level 1) suggestions 
 based on the provided search string. The suggestions are filtered by a specific region code
and are fetched using the Google Places API.*/
  Future<List> getState(String search) async {
    // Initialize an empty list to store the results.
    List result = [];

    // Define the API endpoint for the autocomplete service.
    final String url = 'https://places.googleapis.com/v1/places:autocomplete';

    // Send an HTTP POST request to the Google Places API with the required headers and body.

    return http
        .post(
      // Convert the URL string to a Uri object.
      Uri.parse(url),
      headers: {
        // Set the content type to JSON, as the request body will be in JSON format.
        'Content-Type': 'application/json',
        // Provide the API key for authentication with the Google Places service.
        'X-Goog-Api-Key': apiKey,
      },
      // Convert the request body to JSON format. The body includes the search input and
      // additional filters to ensure only states (administrative area level 1) within a specific region are included.
      body: jsonEncode({
        // Pass the search string to the API as the input for place suggestions.
        'input': search,
        // Enable query predictions to enhance the autocomplete results.
        'includeQueryPredictions': true,
        // Set the language code to English for the results.
        'languageCode': 'en',
        // Filter the results by the specified region code to limit suggestions to a specific geographic area.
        'includedRegionCodes': [
          '$regionCode', // Substitute the placeholder with the actual region code.
        ],
        // Filter the results to include only administrative areas at level 1 (states or regions).
        'includedPrimaryTypes': ['administrative_area_level_1'],
      }),
    )
        .then((response) {
      // Handle the response returned by the API.
      if (response.statusCode == 200) {
        // Check if the response status code is 200 (OK), indicating a successful request.
        // Parse the response body as JSON and extract the data.
        Map<String, dynamic> data = json.decode(response.body);
        // Assign the list of suggestions from the parsed data to the result variable,
        // or use an empty list if no suggestions are found.
        result = data['suggestions'] ?? [];
      } else {
        // If the response status code is not 200, throw an exception to indicate the failure.
        throw Exception('Failed to load autocomplete results');
      }
      notifyListeners();

      // Return the result list containing the state suggestions.
      return result;
    });
  }

  //----------------------------------------------------------------------------cities
  /* A function that retrieves city (locality) suggestions based on the provided search string 
 and filters them based on the provided state name. The suggestions are fetched using 
 the Google Places API and filtered locally by matching the state name.*/
  Future<List> getCity(String search, String stateName) async {
    // Initialize an empty list to store the filtered results.
    List result = [];

    // Define the API endpoint for the autocomplete service.
    final String url = 'https://places.googleapis.com/v1/places:autocomplete';

    // Send an HTTP POST request to the Google Places API with the required headers and body.
    return http
        .post(
      // Convert the URL string to a Uri object.
      Uri.parse(url),
      headers: {
        // Set the content type to JSON, as the request body will be in JSON format.
        'Content-Type': 'application/json',
        // Provide the API key for authentication with the Google Places service.
        'X-Goog-Api-Key': apiKey,
      },
      // Convert the request body to JSON format. The body includes the search input and
      // additional filters to ensure only cities (localities) within a specific region are included.
      body: jsonEncode({
        // Pass the search string to the API as the input for place suggestions.
        'input': search,
        // Enable query predictions to enhance the autocomplete results.
        'includeQueryPredictions': true,
        // Set the language code to English for the results.
        'languageCode': 'en',
        // Filter the results by the specified region code to limit suggestions to a specific geographic area.
        'includedRegionCodes': [
          '$regionCode'
        ], // Substitute with the actual region code.
        // Filter the results to include only localities (cities or towns).
        'includedPrimaryTypes': 'locality',
      }),
    )
        .then((response) {
      // Handle the response returned by the API.
      if (response.statusCode == 200) {
        // Check if the response status code is 200 (OK), indicating a successful request.
        // Parse the response body as JSON and extract the data.
        Map<String, dynamic> data = json.decode(response.body);
        // Extract the list of suggestions from the parsed data or use an empty list if not found.
        List suggestions = data['suggestions'] ?? [];
        print('City sugg : $suggestions');
        // Filter the suggestions based on the provided stateName.
        // Each suggestion is checked to see if its secondary text (usually the state name)
        // contains the provided state name, ignoring case sensitivity.
        print('statename=${stateController.text}');
        result = suggestions.where((suggestion) {
          // Extract the secondary text (state name) from the suggestion's structured format.
          String? secondaryText = suggestion['placePrediction']
              ['structuredFormat']['secondaryText']['text'];
          return secondaryText != null &&
              secondaryText
                  .toLowerCase()
                  .contains(stateController.text.toLowerCase());
        }).toList(); // Convert the filtered results to a list.
      } else {
        // If the response status code is not 200, throw an exception to indicate the failure.
        throw Exception('Failed to load autocomplete results');
      }
      notifyListeners();

      // Return the filtered result list containing the city suggestions.
      return result;
    });
  }

//----------------------------------------------------------------------------suburb
Future<List> getSuburb(String search, String stateName, String cityName, String countryName) async {
  List result = [];

  final String url = 'https://places.googleapis.com/v1/places:autocomplete';

  final response = await http.post(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
      'X-Goog-Api-Key': apiKey,
    },
    body: jsonEncode({
      'input': search,
      'includeQueryPredictions': true,
      'languageCode': 'en',
      'includedRegionCodes': [regionCode], // e.g., ['IN']
      'includedPrimaryTypes': ['sublocality'], // suburb filtering
    }),
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final suggestions = data['suggestions'] ?? [];

    print('Raw suburb suggestions: $suggestions');

    result = suggestions.where((suggestion) {
      final secondaryText = suggestion['placePrediction']
              ?['structuredFormat']?['secondaryText']?['text'] ??
          '';

      return secondaryText.toLowerCase().contains(stateName.toLowerCase()) &&
          secondaryText.toLowerCase().contains(cityName.toLowerCase()) &&
          secondaryText.toLowerCase().contains(countryName.toLowerCase());
    }).toList();
  } else {
    print('Failed to load suburb suggestions: ${response.statusCode}');
    throw Exception('Failed to load suburb suggestions');
  }

  notifyListeners();
  return result;
}


  //----------------------------------------------------------------------------pincode
Future<List> getPincode(String search, String stateName, String cityName) async {
  List result = [];

  final String url = 'https://places.googleapis.com/v1/places:autocomplete';

  final response = await http.post(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
      'X-Goog-Api-Key': apiKey,
    },
    body: jsonEncode({
      'input': search,
      'includeQueryPredictions': true,
      'languageCode': 'en',
      'includedRegionCodes': [regionCode], // e.g., ['IN']
      'includedPrimaryTypes': ['postal_code'], //  filter for pincodes
    }),
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final suggestions = data['suggestions'] ?? [];

    print('Raw pincode response: ${response.body}');

    final regex = RegExp(r'\b\d{6}\b'); // Indian pincode pattern

    result = suggestions.where((suggestion) {
      final mainText = suggestion['placePrediction']
          ?['structuredFormat']?['mainText']?['text'];
      final secondaryText = suggestion['placePrediction']
          ?['structuredFormat']?['secondaryText']?['text'];

      final matchesPincode = (mainText != null && regex.hasMatch(mainText)) ||
          (secondaryText != null && regex.hasMatch(secondaryText));

      final matchesLocation = (secondaryText != null) &&
          secondaryText.toLowerCase().contains(stateName.toLowerCase()) &&
          secondaryText.toLowerCase().contains(cityName.toLowerCase());

      return matchesPincode && matchesLocation;
    }).toList();
  } else {
    print('Failed to load pincode suggestions: ${response.statusCode}');
    throw Exception('Failed to load pincode suggestions');
  }

  notifyListeners();
  return result;
}
// returns both city and state
Future<List<Map<String, String>>> getcitystate(String search) async {
  final List<Map<String, String>> result = [];

  const String url = 'https://places.googleapis.com/v1/places:autocomplete';

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'X-Goog-Api-Key': apiKey,
      },
      body: jsonEncode({
        'input': search,
        'includeQueryPredictions': true,
        'languageCode': 'en',
        'includedRegionCodes': [regionCode], // e.g. 'US'
        'includedPrimaryTypes': ['locality'],
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List suggestions = data['suggestions'] ?? [];

      for (var suggestion in suggestions) {
        final placePrediction = suggestion['placePrediction'];
        final structuredFormat = placePrediction?['structuredFormat'];

        final city = structuredFormat?['mainText']?['text'];
        final state = structuredFormat?['secondaryText']?['text'];

        if (city != null && state != null) {
          result.add({
            'city': city,
            'state': state,
          });
        }
      }

      print('City-State results: $result');
    } else {
      print('API error: ${response.statusCode} - ${response.body}');
      throw Exception('Failed to fetch autocomplete results');
    }
  } catch (e) {
    print('Exception in getCity: $e');
  }

  notifyListeners(); // Optional, only if you're using ChangeNotifier
  return result;
}


// This function helps in fetching Airport code 
// Future<List<Map<String, dynamic>>> fetchAirportSuggestions(String input) async {
//   try {
//     final callable = FirebaseFunctions.instance.httpsCallable('getAirportSuggestions');
//     final response = await callable.call(<String, dynamic>{
//       'input': input,
//     });


//     List suggestions = response.data['suggestions'];
//      // Print each airport
//    for (var airport in suggestions) {
//   debugPrint("Airport Description: ${airport['description']}, Place ID: ${airport['place_id']}");
// }

//     return List<Map<String, dynamic>>.from(suggestions);
//   } catch (e) {
//     debugPrint("Cloud function error: $e");
//     return [];
//   }
// }

// Future<List<Map<String, dynamic>>> fetchAirportSuggestions(
//     String city, {
//     int radius = 50000, // 100 km in meters
//   }) async {
//   try {
//     final callable =
//         FirebaseFunctions.instance.httpsCallable('getAirportSuggestions');
//     final response = await callable.call(<String, dynamic>{
//       'input': city,
//       'radius': radius, // in meters
//     });

//     List suggestions = response.data['suggestions'];

//     for (var airport in suggestions) {
//       debugPrint(
//           "Airport: ${airport['name']}, Address: ${airport['address']}, Place ID: ${airport['placeId']}");
//     }

//     return List<Map<String, dynamic>>.from(suggestions);
//   } catch (e) {
//     debugPrint("Cloud function error: $e");
//     return [];
//   }
// }
// Future<List<Map<String, dynamic>>> fetchAirportSuggestions(
//   String city, {
//   int radius = 50000, // default 50 km in meters
// }) async {
//   try {
//     final callable =
//         FirebaseFunctions.instance.httpsCallable('getAirportSuggestions');
//     final response = await callable.call(<String, dynamic>{
//       'input': city,
//       'radius': radius, // in meters
//     });

//     List suggestions = response.data['suggestions'];

//     for (var airport in suggestions) {
//       debugPrint(
//         "Airport: ${airport['name']}, "
//         "Address: ${airport['address']}, "
//         "Place ID: ${airport['placeId']}, "
//         "Distance: ${airport['distanceKm']?.toStringAsFixed(1)} km",
//       );
//     }

//     return List<Map<String, dynamic>>.from(suggestions);
//   } catch (e) {
//     debugPrint("Cloud function error: $e");
//     return [];
//   }
// }
Future<List<Map<String, dynamic>>> fetchAirportSuggestions({
  required String city,
  int radius = 50000, // default 50 km (in meters)
}) async {
  if (city.isEmpty) {
    throw ArgumentError('City name must be provided.');
  }

  final uri = Uri.parse('${dockerPath}getAirportSuggestions'); // same base path style

  final body = jsonEncode({
    'input': city,
    'radius': radius,
  });

  try {
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List suggestions = data['suggestions'] ?? [];

      for (var airport in suggestions) {
        debugPrint(
          "Airport: ${airport['name']}, "
          "Address: ${airport['address']}, "
          "Place ID: ${airport['placeId']}, "
          "Distance: ${airport['distanceKm']?.toStringAsFixed(1)} km",
        );
      }

      return List<Map<String, dynamic>>.from(suggestions);
    } else {
      throw Exception(
        'Go API Error: ${response.statusCode} ${response.reasonPhrase} - ${response.body}',
      );
    }
  } catch (e) {
    throw Exception('Unexpected error calling Go API: $e');
  }
}



  Timer? _debounce;

  Future<Iterable<String>> fetchSuggestions(
  String inputText,
  SuggestionType type, {
  bool isShowOnlyLookUp = false,
}) async {
  if (_debounce?.isActive ?? false) _debounce!.cancel();

  final completer = Completer<Iterable<String>>();

  _debounce = Timer(const Duration(milliseconds: 300), () async {
    try {
      List suggestions = [];

      switch (type) {
        case SuggestionType.place:
          suggestions = await getPlaceAutocomplete(inputText, isShowOnlyLookUp);
          break;
        case SuggestionType.country:
          suggestions = await getCountry(inputText);
          countrySuggestion = suggestions;
          break;
        case SuggestionType.state:
          suggestions = await getState(inputText);
          stateSuggestion = suggestions;
          break;
        case SuggestionType.city:
          suggestions = await getCity(inputText, stateName);
          citySuggestion = suggestions;
          break;
       case SuggestionType.suburb:
           suggestions = await getSuburb(
           inputText,
           stateController.text,
           cityController.text,
           countryController.text,
           );
           suburbSuggestion = suggestions;
           break;

        case SuggestionType.pincode:
          suggestions = await getPincode(inputText, stateName, cityController.text);
          pincodeSuggestion = suggestions;
          break;
      }

      notifyListeners();

      final result = (type == SuggestionType.pincode || type == SuggestionType.suburb)
    ? suggestions.map<String>((suggestion) {
        return suggestion['placePrediction']
                ?['structuredFormat']?['mainText']?['text'] ??
            '';
      })
          : suggestions.map<String>((suggestion) {
              String fullSuggestion = suggestion['placePrediction']?['text']?['text'] ??
                  suggestion['queryPrediction']?['text']?['text'] ??
                  '';

              return (type == SuggestionType.state || type == SuggestionType.city)
                  ? fullSuggestion.split(',').first.trim()
                  : fullSuggestion;
            });

      completer.complete(result);
    } catch (e) {
      if (type == SuggestionType.country) {
        countryValidationState = ValidationState.invalid;
      } else if (type == SuggestionType.state) {
        stateValidationState = ValidationState.invalid;
      } else if (type == SuggestionType.city) {
        cityValidationState = ValidationState.invalid;
      }

      notifyListeners();
      completer.complete(const Iterable<String>.empty());
    }
  });

  return completer.future;
}

}
