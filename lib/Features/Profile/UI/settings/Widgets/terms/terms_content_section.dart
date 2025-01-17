// Terms Content Section
import 'package:flutter/material.dart';

import '../../../../../../Core/Components/media_query.dart';
import 'terms_item.dart';

class TermsContentSection extends StatelessWidget {
  final CustomMQ mq;

  const TermsContentSection({super.key, required this.mq});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TermsItem(
            mq: mq,
            title: '1 - Terms and Conditions',
            content: 'Don\'t misuse our Services. You may use our Services '
                'only as permitted by law, including applicable export and '
                're-export control laws and regulations. We may suspend or stop '
                'providing our Services to you if you do not comply with our terms '
                'or policies or if we are investigating suspected misconduct.',
          ),
          TermsItem(
            mq: mq,
            title: '2 - Privacy Policy',
            content: 'Don\'t misuse our Services. You may use our Services '
                'only as permitted by law, including applicable export and '
                're-export control laws and regulations. We may suspend or stop '
                'providing our Services to you if you do not comply with our terms '
                'or policies or if we are investigating suspected misconduct.',
          ),
          TermsItem(
            mq: mq,
            title: '3 - Privacy Policy',
            content: 'Don\'t misuse our Services. You may use our Services '
                'only as permitted by law, including applicable export and '
                're-export control laws and regulations. We may suspend or stop '
                'providing our Services to you if you do not comply with our terms '
                'or policies or if we are investigating suspected misconduct.',
          ),
        ],
      ),
    );
  }
}