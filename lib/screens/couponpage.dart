import 'package:flutter/material.dart';
import 'package:acute_test/components/company_rack.dart';  // Make sure this path matches your actual file structure

class CouponsPage extends StatefulWidget {
  @override
  State<CouponsPage> createState() => _CouponsPageState();
}

class _CouponsPageState extends State<CouponsPage> {
  final List<String> categories = ["All", "Food", "Travel", "Clothing", "Luxury"];

  final List<Map<String, dynamic>> companyData = [
    {
      'companyName': "McDonald's",
      'companyLogoUrl': 'https://logo.clearbit.com/mcdonalds.com',
      'offerTitle': 'Ramadan New Offers',
      'offers': [
        {
          'imageUrl': 'https://via.placeholder.com/100',
          'description': 'Grab your ticket for next purchase',
          'couponDetails': '24 Coupons',
        },
        {
          'imageUrl': 'https://via.placeholder.com/100',
          'description': 'Grab your ticket for next purchase',
          'couponDetails': '24 Coupons',
        },
      ],
    },
    {
      'companyName': "Starbucks",
      'companyLogoUrl': 'https://logo.clearbit.com/starbucks.com',
      'offerTitle': 'Coffee for Couples',
      'offers': [
        {
          'imageUrl': 'https://via.placeholder.com/100',
          'description': 'Grab your ticket for next purchase',
          'couponDetails': '10 Coupons',
        },
        {
          'imageUrl': 'https://via.placeholder.com/100',
          'description': 'Grab your ticket for next purchase',
          'couponDetails': '10 Coupons',
        },
      ],
    },
    
  ];

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
                      onSelected: (selected) {},
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
                    companyName: data['companyName'],
                    companyLogoUrl: data['companyLogoUrl'],
                    offerTitle: data['offerTitle'],
                    offers: List<Map<String, String>>.from(data['offers']),
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
