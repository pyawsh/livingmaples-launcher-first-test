import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  BouncingScrollPhysics _bouncingScrollPhysics = BouncingScrollPhysics();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: PageView(
          children: [
            Container(
child: Center(
  child: Text("SLM"),
),
            ),
            FutureBuilder(
              future: DeviceApps.getInstalledApplications(
                includeSystemApps: true,
                onlyAppsWithLaunchIntent: true,
                includeAppIcons: true
              ),
              builder: (context , snapshot){
                if (snapshot.connectionState == ConnectionState.done){
                  List<Application> allApps = snapshot.data;

                  return GridView.count(
                    crossAxisCount: 3,
                    padding: EdgeInsets.only(top: 60.0),
                    physics: _bouncingScrollPhysics,
                    children: List.generate(allApps.length, (index){
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Image.memory((allApps[index] as ApplicationWithIcon).icon,
                              width: 32,),
                            SizedBox(height: 20,),
                            Text(
                              "${allApps[index].appName}",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      );
                    }),
                  );
                }

                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}


