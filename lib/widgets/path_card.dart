import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:path_finder/api/auth_service.dart';
import 'package:path_finder/pages/overview.dart';
import 'package:path_finder/styles/text_styles.dart';
import 'package:path_finder/util/shared_pref_helper.dart';

class PathCard extends StatefulWidget {
  const PathCard({
    super.key,
    required this.width,
    required this.weeks,
    required this.title,
    required this.description,
    required this.id,
    required this.onDeleteSuccess,
  });

  final double width;
  final String weeks;
  final String title;
  final String description;
  final int id;
  final VoidCallback onDeleteSuccess;

  @override
  State<PathCard> createState() => _PathCardState();
}

class _PathCardState extends State<PathCard> {
  bool isDeleting = false;
  final AuthService service = AuthService();

  void _deleteLearningPath() async {
    setState(() => isDeleting = true);
    final token = await SharedPrefHelper.getToken();

    final response = await service.deleteLearningPath(
      learningPathId: widget.id,
      token: token,
    );

    if (response['status'] == 'success') {
      widget.onDeleteSuccess(); // Callback to refresh data
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['message']!)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['message'] ?? 'Delete failed')),
      );
    }

    setState(() => isDeleting = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: widget.width,
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(14),
        color: theme.cardColor,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: theme.dividerColor.withOpacity(0.2)),
          ),
          child: Row(
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Weeks: ${widget.weeks}',
                      style: AppTextStyles.greySmallText,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.title,
                      style: AppTextStyles.headline(context).copyWith(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(
                              'Goal Description',
                              style: AppTextStyles.sectionTitle(context),
                            ),
                            content: TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: MarkdownBody(
                                data: widget.description,
                                styleSheetTheme:
                                    MarkdownStyleSheetBaseTheme.material,
                              ),
                            ),
                          ),
                        );
                      },
                      child: Text(
                        widget.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 36,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: AppTextStyles.greyText.color,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OverView(
                                    learningPathId: widget.id,
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              'View',
                              style: AppTextStyles.bodyMedium(context).copyWith(
                                color: AppTextStyles.whiteText.color,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 36,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: AppTextStyles.greyText.color,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: isDeleting ? null : _deleteLearningPath,
                            child: isDeleting
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    'Delete',
                                    style: AppTextStyles.bodyMedium(context)
                                        .copyWith(
                                      color: AppTextStyles.whiteText.color,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
