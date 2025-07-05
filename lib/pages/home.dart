import 'package:flutter/material.dart';
import 'package:path_finder/api/auth_service.dart';
import 'package:path_finder/styles/text_styles.dart';
import 'package:path_finder/util/shared_pref_helper.dart';
import 'package:provider/provider.dart';
import 'package:path_finder/provider/theme_provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int totalRoadmaps = 0;
  int usersCount = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  AuthService service = AuthService();

  void loadData() async {
    final token = await SharedPrefHelper.getToken();
    final data1 = await service.getTotalRoadmaps(token: token);
    final data2 = await service.getUsersCount(token: token);
    if (data1 == -1 || data2 == -1) return;
    setState(() {
      totalRoadmaps = data1;
      usersCount = data2;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.currentTheme == ThemeMode.dark;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("RoadMapAI"),
        actions: [
          IconButton(
            icon: Icon(
              isDark ? Icons.dark_mode : Icons.light_mode,
              color: theme.iconTheme.color,
            ),
            onPressed: () => themeProvider.toggleTheme(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            Text(
              "Unlock Your Learning Potential",
              style: AppTextStyles.headline(context),
            ),
            const SizedBox(height: 12),
            Text(
              "RoadmapAI crafts personalized learning paths, guiding you to mastery with AI-powered precision. Explore diverse subjects and achieve your goals efficiently.",
              style: AppTextStyles.bodyMedium(context),
            ),
            const SizedBox(height: 24),
            Text(
              "Features",
              style: AppTextStyles.sectionTitle(context),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                featureCard(
                  context,
                  icon: Icons.menu_book,
                  title: "Personalized Roadmaps",
                  description:
                      "AI-generated learning paths tailored to your goals and skill level.",
                ),
                featureCard(
                  context,
                  icon: Icons.track_changes,
                  title: "Progress Tracking",
                  description:
                      "Monitor your progress, identify strengths, and address areas for improvement.",
                ),
                featureCard(
                  context,
                  icon: Icons.bar_chart_rounded,
                  title: "AI-Driven Resources",
                  description:
                      "Unlock the power of AI into your learning journey with data-driven resources.",
                ),
              ],
            ),
            const SizedBox(height: 24),
            statsCard(context,
                title: "Roadmaps Created", value: totalRoadmaps.toString()),
            const SizedBox(height: 12),
            statsCard(context, title: "Users", value: usersCount.toString()),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget featureCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
  }) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.dividerColor.withOpacity(0.2),
          width: 2,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 28, color: theme.iconTheme.color),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.cardTitle(context)),
                const SizedBox(height: 4),
                Text(description,
                    style: AppTextStyles.cardDescription(context)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget statsCard(
    BuildContext context, {
    required String title,
    required String value,
  }) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: theme.cardColor,
        border: Border.all(
          color: theme.dividerColor.withOpacity(0.2),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.statsLabel(context)),
          const SizedBox(height: 8),
          Text(value, style: AppTextStyles.statsValue(context)),
        ],
      ),
    );
  }
}
