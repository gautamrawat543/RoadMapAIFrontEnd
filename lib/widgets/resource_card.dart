import 'package:flutter/material.dart';
import 'package:path_finder/styles/color_styles.dart';
import 'package:path_finder/styles/text_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class ResourceCard extends StatefulWidget {
  const ResourceCard({super.key, required this.data, required this.width});

  final Map<String, dynamic> data;
  final double width;

  @override
  State<ResourceCard> createState() => _ResourceCardState();
}

class _ResourceCardState extends State<ResourceCard> {
  Icon _getIconByType(String type, Color iconColor) {
    switch (type.toLowerCase()) {
      case 'video':
        return Icon(Icons.video_collection_rounded, color: iconColor);
      case 'article':
        return Icon(Icons.article_rounded, color: iconColor);
      case 'repo':
        return Icon(Icons.code_rounded, color: iconColor);
      case 'book':
        return Icon(Icons.menu_book_rounded, color: iconColor);
      case 'github':
        return Icon(Icons.hub, color: iconColor);
      case 'other':
      default:
        return Icon(Icons.link_rounded, color: iconColor);
    }
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open URL')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => _launchURL(widget.data['url']),
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon Container
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(right: 14),
              decoration: BoxDecoration(
                color: isDark
                    ? theme.colorScheme.surfaceVariant.withOpacity(0.4)
                    : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: _getIconByType(widget.data['type'], primaryColor),
            ),

            // Title
            SizedBox(
              width: widget.width * 0.68,
              child: Text(
                widget.data['title'],
                style: boldText.copyWith(fontSize: 15),
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
