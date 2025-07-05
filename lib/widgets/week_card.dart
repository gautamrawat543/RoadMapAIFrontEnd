import 'package:flutter/material.dart';
import 'package:path_finder/styles/text_styles.dart';

class WeekCard extends StatelessWidget {
  const WeekCard({super.key, required this.week});

  final week;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 18),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Week ${week['week'].toString()}',
              style: AppTextStyles.cardTitle(context),
            ),
            const SizedBox(height: 4),
            Text(
              'Title: ${week['week_title']}',
              style: AppTextStyles.cardDescription(context),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Topics: ${week['topics'].length}',
                  style: AppTextStyles.cardDescription(context),
                ),
                Text(
                  'Resources: ${week['resources'].length}',
                  style: AppTextStyles.cardDescription(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
