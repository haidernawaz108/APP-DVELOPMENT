import 'package:flutter/material.dart';
import 'add_activity_screen.dart';
import 'history_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  final Color mainColor = Color(0xFF5A4FCF); // Purple-blue theme

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A1A1A), // dark background

      // 🔹 TOP APP BAR
      appBar: AppBar(
        backgroundColor: mainColor,
        centerTitle: true,
        title: Text(
          "SMART TRACKER",
          style: TextStyle(
            fontSize: 20,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // 🔹 BODY
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 30),

          // ⭐ NEW WELCOME TEXT
          Text(
            "WELCOME TO OUR SMART TRACKER APP",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              letterSpacing: 1.5,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 40),

          // ⭐ Buttons section
          Center(
            child: Column(
              children: [
                // ADD ACTIVITY BUTTON
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainColor,
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => AddActivityScreen()),
                    );
                  },
                  child: Text(
                    "ADD ACTIVITY",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // VIEW HISTORY BUTTON
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainColor,
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => HistoryScreen()),
                    );
                  },
                  child: Text(
                    "VIEW HISTORY",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      // 🔹 BOTTOM NAVIGATION BAR
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: mainColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        currentIndex: currentIndex,
        onTap: (i) {
          setState(() {
            currentIndex = i;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: "About",
          ),
        ],
      ),
    );
  }
}
