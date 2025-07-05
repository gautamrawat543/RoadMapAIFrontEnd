import 'package:flutter/material.dart';
import 'package:path_finder/pages/login.dart';
import 'package:path_finder/styles/color_styles.dart';
import 'package:path_finder/styles/text_styles.dart';
import 'package:path_finder/util/shared_pref_helper.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? name;
  String? email;
  String? id;

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  void loadProfile() async {
    final fetchedName = await SharedPrefHelper.getName();
    final fetchedEmail = await SharedPrefHelper.getEmail();
    final fetchedId = (await SharedPrefHelper.getId()).toString();
    setState(() {
      name = fetchedName;
      email = fetchedEmail;
      id = fetchedId;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: AppTextStyles.appBarTitle(context)),
      ),
      body: (name == null || email == null || id == null)
          ? Center(child: CircularProgressIndicator(color: primaryColor))
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                children: [
                  // Avatar & Name
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: primaryColor.withOpacity(0.8),
                    child: Text(
                      name!.isNotEmpty ? name![0].toUpperCase() : '',
                      style: AppTextStyles.whiteText.copyWith(fontSize: 35),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    name!,
                    style:
                        AppTextStyles.headline(context).copyWith(fontSize: 22),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),

                  // Info Cards
                  buildInfoTile(context, 'Email', email!),
                  buildInfoTile(context, 'User ID', id!),
                  const Spacer(),

                  // Logout Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        await SharedPrefHelper.clearUserData();
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                      icon: const Icon(Icons.logout, color: Colors.white),
                      label: Text('Logout', style: AppTextStyles.whiteText),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget buildInfoTile(BuildContext context, String title, String value) {
    final theme = Theme.of(context);

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 16),
      color: theme.cardColor,
      child: ListTile(
        title: Text(title, style: AppTextStyles.cardTitle(context)),
        subtitle: Text(value, style: AppTextStyles.cardDescription(context)),
        leading: Icon(
          title == 'Email' ? Icons.email : Icons.perm_identity,
          color: AppTextStyles.cardTitle(context).color,
        ),
      ),
    );
  }
}
