import 'package:fitpro/Core/Components/back_button.dart';
import 'package:fitpro/Core/Components/custom_button.dart';
import 'package:fitpro/Core/Components/custom_sizedbox.dart';
import 'package:fitpro/Core/Components/media_query.dart';
import 'package:fitpro/Core/Shared/app_colors.dart';

import 'package:flutter/material.dart';

import '../Data/Model/diet_model.dart';

class DetailScreen extends StatefulWidget {
  final DietModel dietItem;
  const DetailScreen({super.key, required this.dietItem});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isPressed1 = false;
  bool isPressed2 = false;
  bool isPressed3 = false;

  @override
  Widget build(BuildContext context) {
    final mq = CustomMQ(context);
    final dietItem = widget.dietItem;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: const CustomBackButton(),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_outline, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(mq.width(4.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // dietItem Title and Brand
            Center(
              child: Text(
                dietItem.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: mq.width(7.0),
                  fontWeight: FontWeight.bold,
                  color: ColorManager.primaryColor,
                ),
              ),
            ),
            // CustomSizedbox(
            //   height: mq.height(2.0),
            // ),
            // Center(
            //   child: Text(
            //     'McDonald\'s',
            //     textAlign: TextAlign.center,
            //     style: TextStyle(
            //       fontSize: mq.width(4.0),
            //       color: ColorManager.greyColor,
            //     ),
            //   ),
            // ),
            CustomSizedbox(
              height: mq.height(2.0),
            ),

            // dietItem Image
            Center(
              child: Image.network(
                dietItem.image,
                height: mq.height(30.0),
                width: mq.width(50.0),
              ),
            ),
            CustomSizedbox(
              height: mq.height(2.0),
            ),

            // Nutritional Information
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCustomButton('Per 100 g', isPressed1, () {
                  setState(() {
                    isPressed1 = !isPressed1;
                  });
                }),
                _buildCustomButton('Per Portion', true, () {
                  setState(() {
                    isPressed2 = !isPressed2;
                  });
                }),
                _buildCustomButton('Per Grams', isPressed3, () {
                  setState(() {
                    isPressed3 = !isPressed3;
                  });
                }),
              ],
            ),
            CustomSizedbox(
              height: mq.height(5.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildNutritionData('kcal', '${dietItem.calories}', mq),
                _buildNutritionData('Fat', '${dietItem.fats}', mq),
                // _buildNutritionData('Carbs', '${dietItem.protein}',mq),
                _buildNutritionData('Protein', '${dietItem.protein}', mq),
              ],
            ),
            CustomSizedbox(
              height: mq.height(3.0),
            ),
            // "Add Meal" Button
            Center(
              child: CustomButton(
                label: "Add meal",
                onPressed: () {},
                padding: EdgeInsets.symmetric(
                    vertical: mq.height(2), horizontal: mq.width(30)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomButton(String text, bool isPressed, Function() onTap) {
    final mq = CustomMQ(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: isPressed ? ColorManager.softGreyColor : Colors.transparent,
          borderRadius: BorderRadius.circular(mq.height(3.0)),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: mq.width(3.8),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildNutritionData(String label, String value, CustomMQ mq) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: mq.width(4.0),
            fontWeight: FontWeight.bold,
            color: Colors.grey[600],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: mq.width(5.0),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}