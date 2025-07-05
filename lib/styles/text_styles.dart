import 'package:flutter/material.dart';

/// Usage: `AppTextStyles.headline(context)`

class AppTextStyles {
  static TextStyle headline(BuildContext context) {
    return Theme.of(context).textTheme.headlineSmall!.copyWith(
          fontWeight: FontWeight.bold,
        );
  }

  static TextStyle bodyMedium(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontWeight: FontWeight.w500,
        );
  }

  static TextStyle sectionTitle(BuildContext context) {
    return Theme.of(context).textTheme.titleMedium!.copyWith(
          fontWeight: FontWeight.bold,
        );
  }

  static TextStyle cardTitle(BuildContext context) {
    return Theme.of(context).textTheme.titleMedium!.copyWith(
          fontWeight: FontWeight.bold,
        );
  }

  static TextStyle cardDescription(BuildContext context) {
    return Theme.of(context).textTheme.bodySmall!;
  }

  static TextStyle statsValue(BuildContext context) {
    return Theme.of(context).textTheme.headlineSmall!.copyWith(
          fontWeight: FontWeight.bold,
        );
  }

  static TextStyle statsLabel(BuildContext context) {
    return Theme.of(context).textTheme.titleMedium!.copyWith(
          fontWeight: FontWeight.bold,
        );
  }

  static TextStyle appBarTitle(BuildContext context) {
  return Theme.of(context).textTheme.titleLarge!.copyWith(
        color: Theme.of(context).appBarTheme.titleTextStyle?.color ??
            Theme.of(context).primaryTextTheme.titleLarge?.color,
        fontWeight: FontWeight.w600,
        fontSize: 20,
      );
}


  // Optional utility styles
  static TextStyle whiteText = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  static TextStyle greyText = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: Colors.grey,
  );

  static TextStyle greySmallText = const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.normal,
    color: Colors.grey,
  );
}

const TextStyle headLineText =
    TextStyle(fontSize: 24, fontWeight: FontWeight.bold);

const TextStyle boldText = TextStyle(fontSize: 18, fontWeight: FontWeight.w500);

const TextStyle whiteText =
    TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white);

const TextStyle greyText =
    TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey);
const TextStyle greySmallText =
    TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Colors.grey);
