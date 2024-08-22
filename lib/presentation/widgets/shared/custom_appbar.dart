import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final titleStyle = Theme.of(context).textTheme.titleLarge!.copyWith(
        color: colors.primary, fontWeight: FontWeight.w500, letterSpacing: 1.5);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.movie_filter_outlined,
                  color: colors.primary,
                  size: 27.5,
                ),
                const SizedBox(width: 5),
              ],
            ),
            Text(
              'Cinema Explorer',
              style: titleStyle,
              textAlign: TextAlign.center,
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search_outlined,
                  color: colors.primary, size: 27.5),
            ),
          ],
        ),
      ),
    );
  }
}
