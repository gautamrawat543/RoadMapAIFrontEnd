import 'package:flutter/material.dart';
import 'package:path_finder/provider/roadmap_provider.dart';
import 'package:path_finder/styles/color_styles.dart';
import 'package:path_finder/styles/text_styles.dart';
import 'package:provider/provider.dart';

class TopicCard extends StatelessWidget {
  const TopicCard({super.key, required this.data, required this.width});

  final Map<String, dynamic> data;
  final double width;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RoadmapProvider>(context);
    final bool isCompleted = data['isCompleted'] ?? false;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon Container with adaptive color
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(right: 14),
            decoration: BoxDecoration(
              color: isDark
                  ? theme.colorScheme.surfaceVariant.withOpacity(0.4)
                  : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10),
            ),
            child:
                Icon(Icons.menu_book_rounded, color: primaryColor),
          ),

          // Title Text
          Expanded(
            child: Text(
              data['title'],
              style: AppTextStyles.cardTitle(context).copyWith(fontSize: 15),
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
          ),

          const SizedBox(width: 10),

          // Completion Toggle
          GestureDetector(
            onTap: () async {
              if (!provider.isTopicLoading(data['id'])) {
                await provider.toggleTopicCompletion(data);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Please wait... we're updating this topic."),
                    duration: Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            child: provider.isTopicLoading(data['id'])
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.grey,
                      strokeWidth: 2,
                    ),
                  )
                : Icon(
                    isCompleted
                        ? Icons.check_box_rounded
                        : Icons.check_box_outline_blank_rounded,
                    color: Colors.grey,
                  ),
          ),
        ],
      ),
    );
  }
}
