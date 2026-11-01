import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../../../core/extensions/build_context.dart';
import '../../../../core/extensions/widget_extension.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../../core/widgets/custom_app_scaffold.dart';
import '../widgets/home_appBar.dart';
import '../widgets/overview_section.dart';
import '../widgets/quick_tools.dart';
import '../widgets/summary_card.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      isDark: context.isDarkMode,
      child: SingleChildScrollView(
        child: Column(
          children: [
            HomeAppBar().paddingAll(AppSizes.s),
            AppSizes.l.verticalSpace,
            SummeryCard().paddingAll(AppSizes.m),
            AppSizes.l.verticalSpace,
            QuickTools(),
            AppSizes.l.verticalSpace,
            OverviewSection()
          ],
        ),
      ),
    );
  }
}