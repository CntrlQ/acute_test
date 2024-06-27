import 'package:flutter/material.dart';
import 'package:acute_test/network/api_handler.dart';
import 'package:acute_test/components/company_rack.dart'; 

class CouponsPage extends StatefulWidget {
  @override
  State<CouponsPage> createState() => _CouponsPageState();
}

class _CouponsPageState extends State<CouponsPage> {
  List<String> categories = ["All"];
  List<Map<String, dynamic>> companyData = [];
  String selectedCategory = "All";

  final String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2MzBhNjlhNTg3ZWVjNDg3MWI3Mzk4NyIsImlhdCI6MTcxNDQ4MDI4NH0.9iVivjFzBB1CV_eGOD34apiS6zuLGHlVWaFjl50V5Nc';

  @override
  void initState() {
    super.initState();
    fetchCategories();
    fetchLoyaltyCards();
  }

  void fetchCategories() async {
    try {
      final fetchedCategories = await ApiService.fetchCategories(token);
      setState(() {
        categories = ["All", ...fetchedCategories];
      });
    } catch (error) {
      print("Failed to fetch categories: $error");
    }
  }

  void fetchLoyaltyCards({String? category}) async {
    try {
      final fetchedLoyaltyCards = await ApiService.fetchLoyaltyCards(token, category: category);
      setState(() {
        companyData = fetchedLoyaltyCards;
      });
    } catch (error) {
      print("Failed to fetch loyalty cards: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Redeem Coupons"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: FilterChip(
                      label: Text(categories[index]),
                      selected: selectedCategory == categories[index],
                      onSelected: (selected) {
                        setState(() {
                          selectedCategory = categories[index];
                        });
                        fetchLoyaltyCards(category: selectedCategory == "All" ? null : selectedCategory);
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: companyData.length,
                itemBuilder: (context, index) {
                  final data = companyData[index];
                  return CompanyRack(
                    companyName: data['brand'] ?? 'Unknown',
                    companyLogoUrl: data['brand_logo'] ?? '',
                    offerTitle: data['title'] ?? 'No Offer',
                    offers: [
                      {
                        'imageUrl': data['image'] ?? '',
                        'description': data['description'] ?? 'No Description',
                        'couponDetails': data['title'] ?? 'No Details',
                      }
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
