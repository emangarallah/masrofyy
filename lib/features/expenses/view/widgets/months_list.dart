

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masrofyy/core/extensions/build_context.dart';
import 'package:masrofyy/core/theme/app_colors.dart';
import 'package:masrofyy/core/theme/app_sizes.dart';

import '../../../../core/constants/data.dart';

class MonthsList extends StatelessWidget {
  const MonthsList({super.key, required this.monthYearKeys, required this.selectedMonth, required this.selectedYear, required this.activeColor, required this.onMonthSelected});
  final List<String> monthYearKeys;
  final int selectedMonth;
  final int selectedYear;
  final Color activeColor;
  final void Function(int month,int year) onMonthSelected;


  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return SizedBox(
      height: 36.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
          reverse: true,
          itemCount:monthYearKeys.length,
           separatorBuilder: (_, __) => 8.horizontalSpace,
          itemBuilder: (context,i){
          final parts = monthYearKeys[i].split('-');
          final y = int.parse(parts[0]);
          final m = int.parse(parts[1]);
          final isActive = selectedMonth == m &&selectedYear == y;
          return GestureDetector(
            onTap: ()=>
              onMonthSelected(m,y),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 8.h,
              ),
              decoration: BoxDecoration(
                color: isActive ?activeColor : (isDark ? AppColors.cardDark : AppColors.grey100),
                borderRadius: BorderRadius.circular(AppSizes.rM),
                border:isActive ? null  : Border.all(color: isDark ? AppColors.borderDark : AppColors.borderLight
                ) ,
              ),
              child: Text('${months[m - 1]} $y',
                style:  context.textTheme.bodySmall?.copyWith(
                  color: isActive ? Colors.white : (isDark  ? AppColors.textSecondaryDark : AppColors.textSecondaryLight),
                  fontWeight: isActive ? FontWeight.bold : FontWeight.w500,

                ),
            ),


          ),
          );


          },
      ),
    );
  }
}
