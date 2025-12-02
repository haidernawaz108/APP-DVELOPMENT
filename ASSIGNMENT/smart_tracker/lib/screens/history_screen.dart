import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/activity.dart';
import 'dart:io';

class HistoryScreen extends StatefulWidget {
  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<Activity> items = [];
  bool loading = true;

  final Color mainColor = Color(0xFF5A4FCF); // Theme color

  loadActivities() async {
    setState(() {
      loading = true;
    });

    var response = await ApiService().getActivities();

    items = response
        .map<Activity>((item) => Activity.fromJson(Map<String, dynamic>.from(item)))
        .toList();

    setState(() {
      loading = false;
    });
  }

  deleteItem(String id) async {
    bool ok = await ApiService().deleteActivity(id);
    if (ok) {
      loadActivities();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to delete item"),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    loadActivities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A1A1A), // DARK THEME

      appBar: AppBar(
        backgroundColor: mainColor,
        centerTitle: true,
        title: Text(
          "ACTIVITY HISTORY",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
      ),

      body: loading
          ? Center(
              child: CircularProgressIndicator(
                color: mainColor,
              ),
            )
          : items.isEmpty
              ? Center(
                  child: Text(
                    "NO ACTIVITY FOUND",
                    style: TextStyle(
                      fontSize: 18,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    var activity = items[index];

                    return Card(
                      color: Color(0xFF2A2A2A),
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        leading: activity.imagePath.isNotEmpty
                            ? Image.file(
                                File(activity.imagePath),
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              )
                            : Icon(Icons.image, color: Colors.white70),

                        title: Text(
                          "Lat: ${activity.lat}, Lng: ${activity.lng}",
                          style: TextStyle(color: Colors.white),
                        ),

                        subtitle: Text(
                          activity.time,
                          style: TextStyle(color: Colors.white70),
                        ),

                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.redAccent),
                          onPressed: () => deleteItem(activity.id),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
