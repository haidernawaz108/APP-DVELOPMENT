import 'dart:io';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../services/location_service.dart';
import '../services/image_service.dart';
import '../services/api_service.dart';
import '../models/activity.dart';

class AddActivityScreen extends StatefulWidget {
  @override
  State<AddActivityScreen> createState() => _AddActivityScreenState();
}

class _AddActivityScreenState extends State<AddActivityScreen> {
  double? lat;
  double? lng;
  String? imagePath;
  String? address;

  bool loading = false;

  final Color mainColor = Color(0xFF5A4FCF); 

  getLocation() async {
    var pos = await LocationService().getLocation();

    if (pos != null) {
      var addr = await LocationService()
          .getAddressFromLatLng(pos.latitude, pos.longitude);

      setState(() {
        lat = pos.latitude;
        lng = pos.longitude;
        address = addr;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Location not available / permission denied"),
        ),
      );
    }
  }
  takePicture() async {
    var filePath = await ImageService().pickFromCamera();
    if (filePath != null) {
      setState(() {
        imagePath = filePath;
      });
    }
  }
  saveActivity() async {
    if (lat == null || lng == null || imagePath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("PLEASE GET LOCATION AND IMAGE FIRST!!!"),
        ),
      );
      return;
    }

    setState(() {
      loading = true;
    });

    var id = Uuid().v4();

    Activity obj = Activity(
      id: id,
      imagePath: imagePath!,
      lat: lat!,
      lng: lng!,
      time: DateTime.now().toIso8601String(),
    );

    bool ok = await ApiService().addActivity(obj.toJson());

    setState(() {
      loading = false;
    });

    if (ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Activity Saved Successfully!"),
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A1A1A), // dark theme

      appBar: AppBar(
        backgroundColor: mainColor,
        centerTitle: true,
        title: Text(
          "ADD ACTIVITY",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
      ),

      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainColor,
                      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: getLocation,
                    child: Text(
                      "GET LOCATION",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  lat == null
                      ? Text(
                          "NO LOCATION YET",
                          style: TextStyle(color: Colors.white),
                        )
                      : Column(
                          children: [
                            Text(
                              "Lat: $lat",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            Text(
                              "Lng: $lng",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            SizedBox(height: 10),
                            address == null
                                ? Text(
                                    "FETCHING ADDRESS...",
                                    style: TextStyle(color: Colors.white70),
                                  )
                                : Text(
                                    address!.toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      letterSpacing: 1.2,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ],
                        ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              color: Color(0xFF2A2A2A),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainColor,
                      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: takePicture,
                    child: Text(
                      "TAKE PHOTO",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  imagePath == null
                      ? Container(
                          height: 180,
                          color: Colors.grey[700],
                          child: Center(
                            child: Text(
                              "NO IMAGE",
                              style:
                                  TextStyle(color: Colors.white70, fontSize: 16),
                            ),
                          ),
                        )
                      : Image.file(
                          File(imagePath!),
                          height: 180,
                          fit: BoxFit.cover,
                        ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: loading
                ? CircularProgressIndicator(color: mainColor)
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainColor,
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 80),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: saveActivity,
                    child: Text(
                      "SAVE ACTIVITY",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
