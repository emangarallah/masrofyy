import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:masrofyy/core/extensions/build_context.dart';
import 'package:masrofyy/core/theme/app_colors.dart';
import 'package:masrofyy/core/theme/app_sizes.dart';
import 'package:masrofyy/core/widgets/custom_app_scaffold.dart';
import 'package:masrofyy/features/auth/view/widgets/app_logo.dart';
import 'package:masrofyy/features/auth/view/widgets/auth_btn.dart';




class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return AppScaffold(isDark: isDark, child:Column(
      children: [
        const Spacer(flex: 2),
        AppLogo(),
        AppSizes.l.verticalSpace,
        Text('مصروفي',style: context.textTheme.displayLarge!.copyWith(
          color: isDark ? AppColors.white : AppColors.primary
        ),),
        AppSizes.l.verticalSpace,
        Text('مرحبا بك في مصروفي',style: context.textTheme.titleSmall!.copyWith(
            color: isDark ? AppColors.grey100 : AppColors.primary
        ),
        ),
        AppSizes.l.verticalSpace,
        Text('ادر مصروفاتك واهدافك وديونك واهدافك في مكان واحد',style: context.textTheme.titleSmall!.copyWith(
            color: isDark ? AppColors.grey100 : AppColors.primary
        ),
        ),
        AppSizes.l.verticalSpace,




        AuthBtn(),

        Spacer(),

      ],
    )
    );





  }
}