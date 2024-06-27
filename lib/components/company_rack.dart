import 'package:flutter/material.dart';

class CompanyRack extends StatelessWidget {
  final String companyName;
  final String companyLogoUrl;
  final String offerTitle;
  final List<Map<String, String>> offers;

  const CompanyRack({
    Key? key,
    required this.companyName,
    required this.companyLogoUrl,
    required this.offerTitle,
    required this.offers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 3.0,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(companyLogoUrl),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      companyName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      offerTitle,
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 180, // Adjusted height for offers
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: offers.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      showOfferRedeemDialog(
                        context,
                        offers[index]['description']!,
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: buildOfferCard(offers[index]),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOfferCard(Map<String, String> offer) {
    return Container(
      width: 140,
      decoration: BoxDecoration(
        color: Colors.amber.shade100,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4.0,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              offer['imageUrl']!,
              fit: BoxFit.cover,
              height: 80,
              width: double.infinity,
            ),
            SizedBox(height: 8),
            Text(
              offer['description']!,
              style: TextStyle(
                fontSize: 12,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            Text(
              offer['couponDetails']!,
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showOfferRedeemDialog(BuildContext context, String offerDescription) {
    final TextEditingController pinController = TextEditingController();
    const correctPin = '1234'; // This is a hardcoded correct PIN. Replace it with actual logic if needed.

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Redeem Offer"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(offerDescription),
              SizedBox(height: 10),
              TextField(
                controller: pinController,
                maxLength: 4,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Enter 4-digit PIN",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (pinController.text == correctPin) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Offer redeemed successfully!"),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Navigator.of(context).pop(); // Close the dialog
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Incorrect PIN. Please try again."),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: Text("Redeem"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }
}
