import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:path_finder/api/auth_service.dart';
import 'package:path_finder/pages/prompt.dart';
import 'package:path_finder/styles/color_styles.dart';
import 'package:path_finder/styles/text_styles.dart';
import 'package:path_finder/util/shared_pref_helper.dart';
import 'package:path_finder/widgets/path_card.dart';

class RoadMap extends StatefulWidget {
  const RoadMap({super.key});

  @override
  State<RoadMap> createState() => _RoadMapState();
}

class _RoadMapState extends State<RoadMap> {
  String? userName;
  List<dynamic> learningPath = [];
  bool isLoading = true;

  final AuthService service = AuthService();

  @override
  void initState() {
    super.initState();
    loadUserName();
    getLearningPath();
  }

  void loadUserName() async {
    final name = await SharedPrefHelper.getName();
    setState(() {
      userName = name;
    });
  }

  void getLearningPath() async {
    final token = await SharedPrefHelper.getToken();
    final id = await SharedPrefHelper.getId();
    final data = await service.fetchLearningPath(userId: id, token: token);
    setState(() {
      learningPath = data;
      isLoading = false;
    });
    log(learningPath.toString());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Road Map', style: AppTextStyles.appBarTitle(context)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                'Welcome, $userName!',
                style: AppTextStyles.headline(context),
              ),
              const SizedBox(height: 10),
              Text(
                'Your personalized learning journey awaits',
                style: AppTextStyles.greySmallText,
              ),
              const SizedBox(height: 20),
              Text(
                'My Learning Paths',
                style: AppTextStyles.headline(context),
              ),
              const SizedBox(height: 20),
              isLoading
                  ? Center(
                      child: CircularProgressIndicator(color: primaryColor),
                    )
                  : learningPath.isEmpty
                      ? Center(
                          child: Text(
                            'No learning paths found.\nTap "Create Path" to get started!',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.greySmallText.copyWith(
                              fontSize: 16,
                            ),
                          ),
                        )
                      : Column(
                          children: learningPath.map((item) {
                            return PathCard(
                              width: width,
                              weeks: item['durationWeeks'].toString(),
                              title: item['title'],
                              description: item['goalDescription'],
                              id: item['id'],
                              onDeleteSuccess: getLearningPath,
                            );
                          }).toList(),
                        ),
              // : SizedBox(
              //     height: height * 0.5,
              //     child: ListView.builder(
              //       shrinkWrap: true,
              //       physics: const BouncingScrollPhysics(),
              //       itemCount: learningPath.length,
              //       scrollDirection: Axis.vertical,
              //       itemBuilder: (context, index) {
              //         final item = learningPath[index];
              //         return PathCard(
              //           width: width,
              //           weeks: item['durationWeeks'].toString(),
              //           title: item['title'],
              //           description: item['goalDescription'],
              //           id: item['id'],
              //           onDeleteSuccess: getLearningPath,
              //         );
              //       },
              //     ),
              //   ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        height: 40,
        width: 140,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Prompt()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Create Path',
            style: AppTextStyles.whiteText.copyWith(fontSize: 14),
          ),
        ),
      ),
    );
  }
}
