import 'package:flutter/material.dart';
import 'package:path_finder/styles/color_styles.dart';
import 'package:path_finder/styles/text_styles.dart';

class PreviewCard extends StatefulWidget {
  const PreviewCard({
    super.key,
    required this.width,
    required this.data,
    required this.title,
  });

  final double width;
  final String title;
  final Map<String, dynamic> data;

  @override
  State<PreviewCard> createState() => _PreviewCardState();
}

class _PreviewCardState extends State<PreviewCard> {
  Icon _getIconByType(String type) {
    switch (type.toLowerCase()) {
      case 'video':
        return Icon(Icons.video_collection_rounded, color: primaryColor);
      case 'article':
        return Icon(Icons.article_rounded, color: primaryColor);
      case 'repo':
        return Icon(Icons.code_rounded, color: primaryColor);
      case 'book':
        return Icon(Icons.menu_book_rounded, color: primaryColor);
      case 'github':
        return Icon(Icons.hub, color: primaryColor);
      case 'other':
      default:
        return Icon(Icons.link_rounded, color: primaryColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: widget.width,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          width: 1.2,
          color: theme.dividerColor.withOpacity(0.2),
        ),
      ),
      child: ExpansionTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Week ${widget.data['week']} :',
              style: AppTextStyles.sectionTitle(context),
            ),
            const SizedBox(height: 4),
            SizedBox(
              width: widget.width * 0.75,
              child: Text(
                widget.data['week_title'],
                style: AppTextStyles.cardDescription(context),
              ),
            ),
          ],
        ),
        tilePadding: EdgeInsets.zero,
        childrenPadding: const EdgeInsets.only(top: 12, bottom: 6),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Topics:', style: AppTextStyles.cardTitle(context)),
          const SizedBox(height: 6),
          for (int i = 0; i < widget.data['topics'].length; i++)
            Padding(
              padding: const EdgeInsets.only(left: 12.0, bottom: 4),
              child: Text(
                '${i + 1}. ${widget.data['topics'][i]['title']}',
                style: AppTextStyles.cardDescription(context),
              ),
            ),
          const SizedBox(height: 12),
          Text('Resources:', style: AppTextStyles.cardTitle(context)),
          const SizedBox(height: 6),
          for (int i = 0; i < widget.data['resources'].length; i++)
            ListTile(
              contentPadding: const EdgeInsets.only(left: 4, right: 4),
              leading: _getIconByType(widget.data['resources'][i]['type']),
              title: Text(
                '${i + 1}. ${widget.data['resources'][i]['title']}',
                style: AppTextStyles.cardDescription(context),
              ),
            ),
        ],
      ),
    );
  }
}
