import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:path_finder/api/auth_service.dart';
import 'package:path_finder/pages/bottomnav_controller.dart';
import 'package:path_finder/styles/color_styles.dart';
import 'package:path_finder/styles/text_styles.dart';
import 'package:path_finder/util/shared_pref_helper.dart';
import 'package:path_finder/widgets/preview_card.dart';

class Preview extends StatefulWidget {
  const Preview({super.key, required this.data});
  final dynamic data;

  @override
  State<Preview> createState() => _PreviewState();
}

class _PreviewState extends State<Preview> {
  bool isLoading = false;
  AuthService service = AuthService();

  void saveRoadmap() async {
    setState(() => isLoading = true);

    final token = await SharedPrefHelper.getToken();
    final id = await SharedPrefHelper.getId();
    final result =
        await service.saveRoadmap(id: id, token: token, roadmap: widget.data);

    if (result != 200) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Something went wrong')),
      );
    } else {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Roadmap saved successfully')),
      );
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => BottomNavController()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Preview', style: AppTextStyles.appBarTitle(context)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.data['data']['goal'],
                style: AppTextStyles.headline(context),
              ),
              const SizedBox(height: 12),
              for (int i = 0; i < widget.data['data']['weeks'].length; i++)
                PreviewCard(
                  width: width,
                  data: widget.data['data']['weeks'][i],
                  title: widget.data['data']['goal'],
                ),
              const SizedBox(height: 12),
              MarkdownBody(
                data: widget.data['message'],
                styleSheet: MarkdownStyleSheet(
                  p: theme.textTheme.bodyMedium,
                ),
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: isLoading ? null : saveRoadmap,
        child: Container(
          height: 50,
          width: width * 0.4,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : Text('Save', style: AppTextStyles.whiteText),
          ),
        ),
      ),
    );
  }
}
