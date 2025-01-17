import 'package:PureFit/Features/Auth/Register/Logic/cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ruler_picker/flutter_ruler_picker.dart';

import '../../../Core/Components/media_query.dart';
import '../../../Core/Shared/app_colors.dart';
import '../../../Core/Shared/app_string.dart';

class BodyMetricsScreen extends StatelessWidget {
  const BodyMetricsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = CustomMQ(context);

    return Scaffold(
      backgroundColor: ColorManager.backGroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: mq.width(5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: mq.width(5)),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: mq.width(5)),
                        child: LinearProgressIndicator(
                          value: 0.60,
                          backgroundColor:
                              ColorManager.greyColor.withOpacity(0.5),
                          valueColor: AlwaysStoppedAnimation<Color>(
                              ColorManager.primaryColor),
                          minHeight: mq.height(0.5),
                        ),
                      ),
                    ),
                    SizedBox(width: mq.width(5)),
                    Text(
                      '3/5',
                      style: TextStyle(
                          fontSize: mq.height(2),
                          fontFamily: AppString.font,
                          fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
              SizedBox(height: mq.height(2)),
              Text(
                AppString.tellUsYourWeight(context),
                style: TextStyle(
                  fontSize: mq.width(6),
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: mq.height(1)),
              Text(
                AppString.helpUsCreateYourPersonalizedPlan(context),
                style: TextStyle(
                  fontSize: mq.width(4),
                  color: ColorManager.greyColor,
                ),
              ),
              SizedBox(height: mq.height(4)),
              const Expanded(
                flex: 1,
                child: WeightPicker(),
              ),
              SizedBox(height: mq.height(4)),
              Text(
                AppString.tellUsYourHeight(context),
                style: TextStyle(
                  fontSize: mq.width(6),
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: mq.height(1)),
              const Expanded(
                flex: 1,
                child: HeightPicker(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WeightPicker extends StatefulWidget {
  const WeightPicker({super.key});

  @override
  WeightPickerState createState() => WeightPickerState();
}

class WeightPickerState extends State<WeightPicker> {
  RulerPickerController? _rulerPickerController;
  num currentValue = 58;

  @override
  void initState() {
    super.initState();
    _rulerPickerController = RulerPickerController(value: currentValue);
  }

  @override
  Widget build(BuildContext context) {
    final mq = CustomMQ(context);

    return Center(
      child: Column(
        children: [
          Text(
            '${currentValue.toStringAsFixed(1)} kg',
            style: TextStyle(
              fontSize: mq.width(8),
              fontWeight: FontWeight.bold,
              color: ColorManager.primaryColor,
            ),
          ),
          SizedBox(height: mq.height(2)),
          RulerPicker(
            rulerBackgroundColor: Colors.transparent,
            controller: _rulerPickerController!,
            onBuildRulerScaleText: (index, value) {
              return value.toInt().toString();
            },
            ranges: const [
              RulerRange(begin: 40, end: 150, scale: 1),
            ],
            scaleLineStyleList: const [
              ScaleLineStyle(
                color: Colors.grey,
                width: 1.5,
                height: 30,
                scale: 0,
              ),
              ScaleLineStyle(
                color: Colors.grey,
                width: 1,
                height: 25,
                scale: 5,
              ),
              ScaleLineStyle(
                color: Colors.grey,
                width: 1,
                height: 15,
                scale: -1,
              )
            ],
            onValueChanged: (value) {
              setState(() {
                currentValue = value;
              });

              context.read<RegisterCubit>().userWeight = currentValue.toInt();
            },
            width: MediaQuery.of(context).size.width,
            height: mq.height(8),
            rulerMarginTop: mq.height(0.8),
            marker: Container(
              width: mq.width(1),
              height: mq.height(5),
              decoration: BoxDecoration(
                color: ColorManager.primaryColor.withAlpha(100),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HeightPicker extends StatefulWidget {
  const HeightPicker({super.key});

  @override
  HeightPickerState createState() => HeightPickerState();
}

class HeightPickerState extends State<HeightPicker> {
  RulerPickerController? _rulerPickerController;
  num currentValue = 170;

  @override
  void initState() {
    super.initState();
    _rulerPickerController = RulerPickerController(value: currentValue);
  }

  @override
  Widget build(BuildContext context) {
    final mq = CustomMQ(context);

    return Center(
      child: Column(
        children: [
          Text(
            '${currentValue.toStringAsFixed(1)} cm',
            style: TextStyle(
              fontSize: mq.width(8),
              fontWeight: FontWeight.bold,
              color: ColorManager.primaryColor,
            ),
          ),
          SizedBox(height: mq.height(2)),
          RulerPicker(
            rulerBackgroundColor: Colors.transparent,
            controller: _rulerPickerController!,
            onBuildRulerScaleText: (index, value) {
              return value.toInt().toString();
            },
            ranges: const [
              RulerRange(begin: 100, end: 220, scale: 1),
            ],
            scaleLineStyleList: const [
              ScaleLineStyle(
                color: Colors.grey,
                width: 1.5,
                height: 30,
                scale: 0,
              ),
              ScaleLineStyle(
                color: Colors.grey,
                width: 1,
                height: 25,
                scale: 5,
              ),
              ScaleLineStyle(
                color: Colors.grey,
                width: 1,
                height: 15,
                scale: -1,
              )
            ],
            onValueChanged: (value) {
              setState(() {
                currentValue = value;
              });
              context.read<RegisterCubit>().userHeight = currentValue.toInt();
            },
            width: MediaQuery.of(context).size.width,
            height: mq.height(8),
            rulerMarginTop: mq.height(0.8),
            marker: Container(
              width: mq.width(1),
              height: mq.height(5),
              decoration: BoxDecoration(
                color: ColorManager.primaryColor.withAlpha(100),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
