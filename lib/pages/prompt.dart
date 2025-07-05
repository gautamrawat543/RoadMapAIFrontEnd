import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:path_finder/api/auth_service.dart';
import 'package:path_finder/pages/preview.dart';
import 'package:path_finder/styles/color_styles.dart';
import 'package:path_finder/styles/text_styles.dart';
import 'package:path_finder/util/shared_pref_helper.dart';

class Prompt extends StatefulWidget {
  const Prompt({super.key});

  @override
  State<Prompt> createState() => _PromptState();
}

class _PromptState extends State<Prompt> {
  String? selectedDuration;
  final List<String> durations = ['1 Month', '3 Months', '6 Months', '1 Year'];
  final TextEditingController _goalController = TextEditingController();

  bool isLoading = false;

  AuthService service = AuthService();

  void createPrompt() async {
    if (_goalController.text.isEmpty || selectedDuration == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a goal and select a duration')),
      );
      return;
    }

    setState(() => isLoading = true);

    final token = await SharedPrefHelper.getToken();
    final int weeks = _durationToWeeks(selectedDuration!);

    final data = await service.createRoadmap(
      goal: _goalController.text,
      weeks: weeks,
      token: token,
    );

    setState(() => isLoading = false);

    if (data['status'] == 'error') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(data['message'])),
      );
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => Preview(data: data)),
    );

    log(data.toString());
  }

  int _durationToWeeks(String duration) {
    switch (duration) {
      case '1 Month':
        return 4;
      case '3 Months':
        return 12;
      case '6 Months':
        return 24;
      case '1 Year':
        return 52;
      default:
        return 4;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Prompt', style: AppTextStyles.appBarTitle(context)),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Craft Your Learning Journey',
                  style: AppTextStyles.headline(context),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 25),
                TextField(
                  controller: _goalController,
                  keyboardType: TextInputType.text,
                  maxLines: 3,
                  scrollPhysics: const BouncingScrollPhysics(),
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelText: 'What\'s your learning goal?',
                    labelStyle: AppTextStyles.greySmallText,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                          color: theme.colorScheme.primary, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                          color: theme.colorScheme.primary, width: 1.5),
                    ),
                  ),
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 30),
                DropdownButtonFormField<String>(
                  value: selectedDuration,
                  hint: Text('Select Duration',
                      style: AppTextStyles.greySmallText),
                  items: durations.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child:
                          Text(value, style: AppTextStyles.bodyMedium(context)),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() => selectedDuration = newValue);
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: theme.dividerColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: theme.dividerColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                          color: theme.colorScheme.primary, width: 1.5),
                    ),
                  ),
                  icon: const Icon(Icons.arrow_drop_down),
                  dropdownColor: theme.cardColor,
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 25),
                SizedBox(
                  height: 50,
                  width: 180,
                  child: ElevatedButton(
                    onPressed: createPrompt,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            'Generate Path',
                            style:
                                AppTextStyles.whiteText.copyWith(fontSize: 14),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
