import 'dart:async';
import 'package:PureFit/Core/Shared/app_colors.dart';
import 'package:PureFit/Core/Shared/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Core/Components/media_query.dart';
import '../../Data/Model/exercise_model.dart';
import '../../Logic/training_cubit/training_cubit.dart';

class GetReadyScreen extends StatefulWidget {
  final List<ExerciseModel> exercises;
  final int index;

  const GetReadyScreen(
      {super.key, required this.exercises, required this.index});

  @override
  GetReadyScreenState createState() => GetReadyScreenState();
}

class GetReadyScreenState extends State<GetReadyScreen> {
  late CustomMQ mq;
  Timer? countdownTimer;
  int countdownValue = 1;
  @override
  void initState() {
    super.initState();
    startCountdown();
    countdownValue = context.read<TrainingCubit>().getReadyDuration;
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    super.dispose();
  }

  void startCountdown() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdownValue > 1) {
        setState(() {
          countdownValue--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = CustomMQ(context);
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('${AppString.exercises(context)} ${widget.index + 1}/${widget.exercises.length}',
            style: TextStyle(fontFamily: AppString.font)),
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            ExerciseImage(
              mq: mq,
              exercises: widget.exercises,
              index: widget.index,
            ),
            SizedBox(height: mq.height(3)),
            ReadyMessage(
              index: widget.index,
              mq: mq,
              exercises: widget.exercises,
            ),
            SizedBox(height: mq.height(2)),
            CircularCounter(
              mq: mq,
              countdownValue: countdownValue,
            ),
            SizedBox(height: mq.height(2)),
            NextExerciseInfo(
              index: widget.index,
              mq: mq,
              exercises: widget.exercises,
            ),
          ],
        ),
      ),
    );
  }
}

class ExerciseImage extends StatelessWidget {
  final CustomMQ mq;
  final List<ExerciseModel> exercises;
  final int index;
  const ExerciseImage(
      {super.key,
      required this.mq,
      required this.exercises,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: mq.height(24),
      child: Image.network(
        exercises[index].gifUrl!,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}

class ReadyMessage extends StatelessWidget {
  final CustomMQ mq;
  final List<ExerciseModel> exercises;
  final int index;
  const ReadyMessage(
      {super.key,
      required this.mq,
      required this.exercises,
      required this.index});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Text(
          AppString.readyToGo(context),
          style: TextStyle(
            fontSize: mq.height(3.5),
            fontWeight: FontWeight.bold,
            color: theme.primaryColor,
          ),
        ),
        SizedBox(height: mq.height(1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Center(
            child: Text(
              textAlign: TextAlign.center,
              exercises[index].name,
              style: TextStyle(
                color: ColorManager.greyColor,
                fontSize: mq.height(2.5),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CircularCounter extends StatelessWidget {
  final CustomMQ mq;
  final int countdownValue;

  const CircularCounter({
    super.key,
    required this.mq,
    required this.countdownValue,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: mq.width(50),
      height: mq.width(50),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Circular Timer Indicator
          SizedBox(
            width: mq.width(30),
            height: mq.width(30),
            child: CircularProgressIndicator(
              value: countdownValue /
                  context.read<TrainingCubit>().getReadyDuration,
              strokeWidth: mq.width(2),
              color: theme.scaffoldBackgroundColor.withOpacity(0.6),
              backgroundColor: Colors.grey.shade300,
            ),
          ),
          // Countdown Text
          Text(
            '$countdownValue',
            style:
                TextStyle(fontSize: mq.height(4), fontWeight: FontWeight.bold),
          ),

          Positioned(
            right: mq.width(0),
            child: GestureDetector(
              child: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
                size: mq.width(7),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NextExerciseInfo extends StatelessWidget {
  final CustomMQ mq;
  final int index;

  final List<ExerciseModel> exercises;
  const NextExerciseInfo(
      {super.key,
      required this.mq,
      required this.exercises,
      required this.index});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Next',
          style: TextStyle(
            fontSize: mq.height(2),
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
        ),
        SizedBox(height: mq.height(1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Center(
            child: Text(
              textAlign: TextAlign.center,
              exercises[index].name, // need it ne
              style: TextStyle(
                fontSize: mq.height(2.5),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class NextExerciseScreen extends StatelessWidget {
  const NextExerciseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Next Exercise'),
      ),
      body: const Center(
        child: Text('Incline Push-Ups Screen'),
      ),
    );
  }
}
