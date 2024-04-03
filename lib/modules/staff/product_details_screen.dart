import 'package:event/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class StaffProductDetailsScreeen extends StatefulWidget {
  const StaffProductDetailsScreeen({super.key, required this.details});

  final Map<String, dynamic> details;

  @override
  State<StaffProductDetailsScreeen> createState() =>
      _StaffProductDetailsScreeenState();
}

class _StaffProductDetailsScreeenState extends State<StaffProductDetailsScreeen> {
  DateTime? newDateTime;

  bool loading = false;

  final locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image(
                    image: NetworkImage(widget.details['image']),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 2,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListView(
                      children: [
                        const Text(
                          'Name',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.details['name'],
                          maxLines: 8,
                          style: TextStyle(color: Colors.grey.shade400),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Description',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.details['description'],
                          maxLines: 8,
                          style: TextStyle(color: Colors.grey.shade400),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Color',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.details['color'],
                          style: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 16,
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            const Text(
                              'Price',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '₹${widget.details['price']}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            text: 'Upadate',
                            onPressed: () async {
                              
                               
                              
                            },
                          ),
                        ),
                        SizedBox(width: 20,),
                         Expanded(
                          child: CustomButton(
                            text: 'Delete',
                            onPressed: () async {
                              
                               
                              
                            },
                          ),
                        ),
                        

                        
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
