import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:path_finder/pages/detail_view.dart';
import 'package:path_finder/provider/roadmap_provider.dart';
import 'package:path_finder/styles/color_styles.dart';
import 'package:path_finder/styles/text_styles.dart';
import 'package:path_finder/widgets/week_card.dart';
import 'package:provider/provider.dart';

class OverView extends StatefulWidget {
  const OverView({
    super.key,
    required this.learningPathId,
  });

  final int learningPathId;

  @override
  State<OverView> createState() => _OverViewState();
}

class _OverViewState extends State<OverView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RoadmapProvider>(context, listen: false)
          .fetchRoadmap(widget.learningPathId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);

    return Consumer<RoadmapProvider>(
      builder: (context, provider, child) {
        final roadmap = provider.roadmap;

        if (provider.isLoading) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: primaryColor),
            ),
          );
        }

        if (roadmap.isEmpty) {
          return Scaffold(
            body: Center(
              child: Text("No roadmap data found.",
                  style: AppTextStyles.cardDescription(context)),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(title: const Text('Path Overview')),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text('Learning Path Overview',
                      style: AppTextStyles.sectionTitle(context)),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Goal Description'),
                          content: TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: MarkdownBody(data: roadmap['message']),
                          ),
                        ),
                      );
                    },
                    child: Text(
                      roadmap['message'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.cardDescription(context),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Text('Overall Progress',
                      style: AppTextStyles.cardTitle(context)),
                  const SizedBox(height: 10),
                  Stack(
                    children: [
                      Container(
                        width: width,
                        height: 20,
                        decoration: BoxDecoration(
                          color: theme.dividerColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      Container(
                        width: width * ((roadmap['progressPercentage']) / 100),
                        height: 20,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text('${(roadmap['progressPercentage']).toStringAsFixed(1)}% completed',
                      style: AppTextStyles.cardDescription(context)),
                  const SizedBox(height: 20),
                  ListView.builder(
                    itemCount: roadmap['data']['weeks'].length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final week = roadmap['data']['weeks'][index];
                      return GestureDetector(
                        onTap: () async {
                          final shouldRefresh = await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => DetailView(week: week),
                            ),
                          );
                          if (shouldRefresh == true) {
                            provider.fetchRoadmap(widget.learningPathId);
                          }
                        },
                        child: WeekCard(week: week),
                      );
                    },
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
