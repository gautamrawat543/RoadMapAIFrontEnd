import 'package:flutter/material.dart';
import 'package:path_finder/styles/text_styles.dart';
import 'package:path_finder/widgets/resource_card.dart';
import 'package:path_finder/widgets/topic_card.dart';

class DetailView extends StatelessWidget {
  const DetailView({super.key, required this.week});

  final Map<String, dynamic> week;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail View', style: AppTextStyles.appBarTitle(context)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                week['week_title'],
                style: AppTextStyles.cardTitle(context),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 10),
              Text(
                'Week: ${week['week']}',
                style: AppTextStyles.cardDescription(context)
                    .copyWith(fontSize: 18),
              ),
              const SizedBox(height: 25),
              Text('Topics', style: AppTextStyles.sectionTitle(context)),
              const SizedBox(height: 10),
              for (int i = 0; i < week['topics'].length; i++)
                TopicCard(data: week['topics'][i], width: width),
              const SizedBox(height: 25),
              Text('Resources', style: AppTextStyles.sectionTitle(context)),
              const SizedBox(height: 10),
              for (int i = 0; i < week['resources'].length; i++)
                ResourceCard(data: week['resources'][i], width: width),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
