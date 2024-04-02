import 'package:event/Db/db_service.dart';
import 'package:event/services/api_service.dart';
import 'package:event/utils/constants.dart';
import 'package:event/widgets/custom_button.dart';
import 'package:event/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class UserAddComplaintScreen extends StatefulWidget {
  const UserAddComplaintScreen({super.key});

  @override
  State<UserAddComplaintScreen> createState() => _UserAddComplaintScreenState();
}

class _UserAddComplaintScreenState extends State<UserAddComplaintScreen> {
  final addComplaint = TextEditingController();

   bool loading =  false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: SizedBox(width: MediaQuery.of(context).size.width,
      child: CustomButton(
        text: 'Add complaint', onPressed: () {

          showModalBottomSheet(context: context, builder: (context) {
            return Container(
              padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              child: Column(

                children: [

                  CustomTextField(
                    hintText: 'Add Complaint', 
                    controller: addComplaint,
                    borderColor: Colors.grey,
                    maxLines: 10,
                    ),

                    const SizedBox(height: 20,),

                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: loading ?   Center(child: CircularProgressIndicator(color: KButtonColor,),) : CustomButton(text: 'Save', onPressed: () async{
                      print('ggg');
                      try{

                        if(addComplaint.text.isNotEmpty){
                          print('geee');

                           setState(() {
                             loading =  true;
                           });
                           await    ApiService().addComplaint(DbService.getLoginId(), addComplaint.text,context);
                             Navigator.pop(context);
                          setState(() {
                            loading = false;
                          });
                        
                        
                        }


                      }catch(e){

                        
                      }

                      
                    },
                    ),
                  )



                ],

              ),
            );
            
          },);
          
        },),
      ),
      appBar: AppBar(
        title: const Text('Complaint'),
      ),
      body:FutureBuilder<List<dynamic>>(
        future: ApiService().fetchComplaints(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: KButtonColor));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final complaint = snapshot.data![index];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.message),
                    title: Text(complaint['complaint']),
                    
                    onTap: () {

                      showDialog(context: context, builder: (context) => AlertDialog(
                        content: Text('Our team contact you soon!!!'),
                        actions: [
                          TextButton(onPressed: () {
                            Navigator.pop(context);
                          }, child: Text('Ok'))
                        ],
                      
                        
                      ),);
                      // Handle item tap
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    
    );
  }
}
