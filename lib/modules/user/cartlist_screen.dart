import 'package:event/Db/db_service.dart';
import 'package:event/modules/user/user_check_out_screen.dart';
import 'package:event/services/api_service.dart';
import 'package:event/widgets/custom_button.dart';
import 'package:flutter/material.dart';


class UserCartListScreen extends StatefulWidget {
  const UserCartListScreen({Key? key}) : super(key: key);

  @override
  State<UserCartListScreen> createState() => _UserCartListScreenState();
}

class _UserCartListScreenState extends State<UserCartListScreen> {
  

  @override
  void initState() {
    getData();

    super.initState();
  }

  double total = 0;

  getData() async {


    var cartitemsList = await ApiService().viewCart(DbService.getLoginId());

    cartitemsList.forEach((element) {
      total = double.parse(element['subtotal'].toString()) + total;

      setState(() {});
    });
  }

  int qty = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total:',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w800),
                ),
                Text(
                  '₹$total',
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: CustomButton(
                text: 'Check Out',
                onPressed: () {

                  Navigator.push(context, MaterialPageRoute(builder: (context) => CheckOut(total: total.toString(),),));
                },
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: ApiService().viewCart(DbService.getLoginId()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final cartItems = snapshot.data!;

            return ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];

                qty = item['quantity'];

                return Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10),
                  child: ItemCard(
                    name: item['name'],
                    imageUrl: item['image'],
                    quantity: qty,
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

class ItemCard extends StatefulWidget {
  final String name;
  final String imageUrl;
  int quantity;

  ItemCard({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.quantity,
  });

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  bool loading = false;

  void _increment() {
    setState(() {
      widget.quantity++;
    });
  }

  void _decrement() {
    setState(() {
      if (widget.quantity > 0) {
        widget.quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Image.network(
              widget.imageUrl,
              height: 70,
              width: 50,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16.0),
          Text(
            widget.name,
            style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: _decrement,
          ),
          Text(
            '${widget.quantity}',
            style: const TextStyle(fontSize: 16.0),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _increment,
          ),
        ],
      ),
    );
  }
}
