import 'package:action_slider/action_slider.dart';
import 'package:event/modules/auth/login_screen.dart';
import 'package:event/utils/constants.dart';
import 'package:flutter/material.dart';

class  StaffRootScreen extends StatelessWidget {



bool isAttend = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: KButtonColor,
          title: const Text('Home',style: TextStyle(
            color: Colors.white
          ),),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: GridView(
                  // Set the number of items in the grid
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    crossAxisSpacing: 20.0, // Spacing between columns
                    mainAxisSpacing: 20.0, // Spacing between rows
                  ),
                 children: [
                  GestureDetector(
                      onTap: () {
                        print('Item  clicked');
                        // Add your navigation logic here
                      },
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: GridTile(
                          footer: Container(
                            color:  KButtonColor,
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              'Add product', // Name of the item
                              style: const TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          child: Image.asset(
                            'assets/images/addproduct.png', // URL of the image
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  
                  
                   GestureDetector(
                      onTap: () {
                        print('Item  clicked');
                        // Add your navigation logic here
                      },
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: GridTile(
                          footer: Container(
                            color:  KButtonColor,
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              'Add Event', // Name of the item
                              style: const TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          child: Image.asset(
                            'assets/images/event.jpeg', // URL of the image
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  
                     
                  
                    GestureDetector(
                      onTap: () {
                        print('Item  clicked');
                        // Add your navigation logic here
                      },
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: GridTile(
                          footer: Container(
                            color:  KButtonColor,
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              'View booking', // Name of the item
                              style: const TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          child: Image.asset(
                            'assets/images/viewbooking.jpeg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                   GestureDetector(
                      onTap: () {
                        print('Item  clicked');
                        // Add your navigation logic here
                      },
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: GridTile(
                          footer: Container(
                            color:  KButtonColor,
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              'View events', // Name of the item
                              style: const TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          child: Image.asset(
                            'assets/images/viewevent.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                       GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen() 
                        ,), (route) => false);
                      },
                      child: Container(
                        
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: GridTile(
                          footer: Container(
                            color:  KButtonColor,
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              'Logout', // Name of the item
                              style: const TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          child: Container(
                            color: Colors.white,
                            child: Icon(Icons.logout,color: Colors.red,size: 50,)),
                        ),
                      ),
                    ),
                  
              
                 ],
                ),
              ),
              isAttend
                    ? SizedBox()
                    : ActionSlider.standard(
                        backgroundColor: KButtonColor,
                        toggleColor: Colors.white,
                        backgroundBorderRadius: BorderRadius.circular(0.0),
                        rolling: true,
                        action: (controller) async {
                         
                        },
                        child: const Text(
                          'Slide to add attendance',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
            
            ],
          ),
        ),
      
    );
  }
}