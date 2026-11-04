import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masrofyy/core/extensions/build_context.dart';
import 'package:masrofyy/features/expenses/controller/expense_controller.dart';
import 'package:masrofyy/features/expenses/view/widgets/months_list.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/data.dart';
import '../../../../core/extensions/num_extension.dart';
import '../../../../core/extensions/widget_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_sizes.dart';
import '../../../expenses/models/expense_entry_model.dart';


class TransactionsTab extends ConsumerStatefulWidget {
  const TransactionsTab({super.key});

  @override
  ConsumerState<TransactionsTab> createState() => _TransactionsTabState();
}

class _TransactionsTabState extends ConsumerState<TransactionsTab> {
  int _setMonth = DateTime.now().month;
  int _setYear = DateTime.now().year;
  @override
  Widget build(BuildContext context) {
    final expensecontroller = ref.watch(expenseControllerProvider);
    final isDark = context.isDarkMode;
    String formatDatelLabel(DateTime date, bool isArabic){
      final now = DateTime.now();
      final today = DateTime(now.year,now.month,now.day);
      final yesterday = today.subtract(const Duration(days: 1));
      final checkDate = DateTime(date.year,date.month,date.day);
      if(checkDate == today){
        return 'اليوم';

      }else if (checkDate == yesterday){
        return 'امس';
      }else{
        return DateFormat('d MMM YYYY','ar').format(date);
      }
    }









    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("المعاملات", style: context.textTheme.titleLarge).center(),
          AppSizes.m.verticalSpace,


          // Summary Card
          expensecontroller.when(data: (data){
            final filterd = data.where((e)=> e.month == _setMonth && e.year == _setYear).toList();
            filterd.sort((a,b)=> b.date.compareTo(a.date));
            final totalExpenses = filterd.fold<double>(0, (sum,e) => sum + e.amount);

            // Fixed: Converted the Set to a List<String> using .toList()
            final List<String> keys = {
              '${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2,'0')}',
              ...data.map((e)=> e.monthYear),
            }.toList()..sort((a,b)=>b.compareTo(a));

            final Map<String,List<ExpenseEntryModel>> group ={};
            for(var entrry in filterd){
              final label = formatDatelLabel(entrry.date, true);
              if(!group.containsKey(label)){
                group[label] = [];

              }
              group[label]!.add(entrry);

            }





            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                _ExpensesSummaryCard(total: totalExpenses.toString(),
                  monthLabel:"${months[_setMonth -1]}-$_setYear",
                ),
                AppSizes.l.verticalSpace,
                MonthsList(monthYearKeys: keys,
                  selectedMonth: _setMonth,
                  selectedYear: _setYear,
                  activeColor: AppColors.expense,
                  onMonthSelected: (m,y)=> setState(() {
                    _setMonth = m;
                    _setYear = y;
                  }),),


              ],

            );




          }, error: (err,stack)=> Text(
            'تعذر تحميل المصروفات',style: context.textTheme.bodyMedium,

          ).center().paddingAll(AppSizes.xl),
            loading: () => CircularProgressIndicator.adaptive().center().paddingAll(AppSizes.xl),),



        ],
      ).paddingAll(AppSizes.screenPadding),
    );
  }
}

class _ExpensesSummaryCard extends StatelessWidget {
  const _ExpensesSummaryCard({required this.total, required this.monthLabel});
  final String total;
  final String monthLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppSizes.m.allPadding,
      decoration: BoxDecoration(
        gradient: AppColors.walletGradient,
        borderRadius: AppSizes.rXL.radius,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.15),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left side: Text info & Period selector
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'إجمالي المصروفات',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontWeight: FontWeight.w500,
                ),
              ),
              AppSizes.xs.verticalSpace,
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(total, style: context.textTheme.headlineMedium),
                  AppSizes.s.horizontalSpace,
                  Text('EGP', style: context.textTheme.titleMedium),
                ],
              ),
              AppSizes.m.verticalSpace,
              // Period selection pill
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: AppSizes.rM.radius,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.white,
                      size: 16,
                    ),
                    AppSizes.xs.horizontalSpace,
                    Text(monthLabel, style: context.textTheme.bodySmall),
                  ],
                ),
              ),
            ],
          ).expanded(),

          // Right side: Expenses illustration image
          AppSizes.s.horizontalSpace,
          Image.asset(
            AppAssets.goals,
            width: 120.w,
            height: 120.h,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}

class _TransactionItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;
  final String amount;
  final IconData icon;
  final Color iconColor;
  final bool isHighlighted;

  const _TransactionItem({
    required this.title,
    required this.subtitle,
    required this.time,
    required this.amount,
    required this.icon,
    required this.iconColor,
    required this.isHighlighted,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.m, vertical: 12.h),
      child: Row(
        children: [
          // Right side: Icon + Text info
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: AppSizes.iconS),
              ),
              AppSizes.m.horizontalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  4.verticalSpace,
                  Text(
                    subtitle,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondaryLight,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const Spacer(),

          // Middle: Time
          Text(
            time,
            style: context.textTheme.bodySmall?.copyWith(
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
            ),
          ),

          const Spacer(),

          // Left: Amount
          Text(
            '$amount EGP',
            style: context.textTheme.bodyLarge?.copyWith(
              color: isHighlighted
                  ? AppColors.expense
                  : (isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}