import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:masrofyy/core/extensions/build_context.dart';
import 'package:masrofyy/core/extensions/num_extension.dart';
import 'package:masrofyy/core/extensions/widget_extension.dart';
import 'package:masrofyy/core/theme/app_colors.dart';
import 'package:masrofyy/core/theme/app_sizes.dart';
import 'package:masrofyy/core/widgets/custom_app_scaffold.dart';

class DeptsPage extends StatefulWidget {
  const DeptsPage({super.key});

  @override
  State<DeptsPage> createState() => _DeptsPageState();
}

class _DeptsPageState extends State<DeptsPage> {
  int _selectedTabIndex = 0;

  final List<Map<String,dynamic>> _allDebts = [
  {
  'title': 'فرق شخصي',
  'subtitle': 'الأهلي',
  'remaining': '3,000',
  'total': '6,000',
  'percentage': 60,
  'progress': 0.6,
  'color': AppColors.expense,
  'isPaid': false,
  },
  {
  'title': 'بطاقة إئتمان',
  'subtitle': 'البنك العربي الدولي',
  'remaining': '0',
  'total': '6,000',
  'percentage': 100,
  'progress': 1.0,
  'color': AppColors.success,
  'isPaid': true,
  },
  {
  'title': 'دين لصديق',
  'subtitle': 'احمد محمد',
  'remaining': '0',
  'total': '6,000',
  'percentage': 100,
  'progress': 1.0,
  'color': AppColors.success,
  'isPaid': true,
  }
  ];

  Widget _buildTabItem(String label, {required int index}) {
    final isSelected = _selectedTabIndex == index;
    final isDark = context.isDarkMode;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
        });
      },
      child: Column(
        children: [
          Text(
            label,
            style: context.textTheme.titleSmall?.copyWith(
              color: isSelected
                  ? AppColors.expense
                  : (isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight),
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
          AppSizes.xs.verticalSpace,
          Container(
            width: 60.w,
            height: 2.h,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.expense : Colors.transparent,
              borderRadius: 1.r.radius,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final iconColor = context.colorScheme.onSurface;

    final filteredDebt = _allDebts.where((debt) {
      if (_selectedTabIndex == 1) {
        return !debt['isPaid'];
      } else if (_selectedTabIndex == 2) {
        return debt['isPaid'];
      }
      return true; // Index 0: All debts
    }).toList();

    return AppScaffold(
      isDark: context.isDarkMode,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: context.pop,
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: iconColor,
                    size: AppSizes.iconM,
                  ),
                ),
                Text(
                  'الديون',
                  style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.add_rounded,
                    color: iconColor,
                    size: AppSizes.iconM,
                  ),
                ),
              ],
            ),
            AppSizes.m.verticalSpace,

            // Summary Card
            const _DebttsSummaryCard(),
            AppSizes.l.verticalSpace,

            // Custom Tab bar
            Row(
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTabItem("كل الديون", index: 0),
                _buildTabItem("متبقي", index: 1),
                _buildTabItem("مسدده", index: 2),
              ],
            ),
            AppSizes.l.verticalSpace,

            // List of Debts (Using Column instead of ListView inside SingleChildScrollView to prevent height conflict)
            if (filteredDebt.isEmpty)
              Center(
                child: Column(
                  children: [
                    AppSizes.xxl.verticalSpace,
                    Icon(
                      Icons.account_balance_wallet_outlined,
                      size: AppSizes.iconXL,
                      color: AppColors.grey400,
                    ),
                    AppSizes.l.verticalSpace,
                    Text(
                      'لاتوجد ديون حاليا',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: AppColors.grey500,
                      ),
                    ),
                  ],
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => AppSizes.m.verticalSpace,
                itemCount: filteredDebt.length,
                itemBuilder: (context, index) {
                  final debt = filteredDebt[index];
                  return _DebtCard(
                    title: debt['title'] as String,
                    subtitle: debt['subtitle'] as String,
                    remaining: debt['remaining'] as String,
                    total: debt['total'] as String,
                    percentage: debt['percentage'] as int,
                    percentageValue: debt['progress'] as double,
                    progressColor: debt['color'] as Color,
                  );
                },
              ),
          ],
        ).paddingAll(AppSizes.screenPadding),
      ),
    );
  }
}

class _DebtCard extends StatelessWidget {
  const _DebtCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.remaining,
    required this.total,
    required this.percentage,
    required this.percentageValue,
    required this.progressColor,
  });

  final String title;
  final String subtitle;
  final String remaining;
  final String total;
  final int percentage;
  final double percentageValue;
  final Color progressColor;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    return Container(
      padding: 16.allPadding,
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : Colors.white,
        borderRadius: AppSizes.rL.radius,
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title, Subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: context.textTheme.titleMedium),
                    4.verticalSpace,
                    Text(
                      subtitle,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                      ),
                    ),
                  ],
                ),
              ),
              // Remaining amount & Progress
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('$remaining EGP', style: context.textTheme.titleMedium),
                    12.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('%$percentage', style: context.textTheme.labelSmall),
                        8.horizontalSpace,
                        Expanded(
                          child: ClipRRect(
                            borderRadius: 10.r.radius,
                            child: LinearProgressIndicator(
                              value: percentageValue,
                              minHeight: 6.h,
                              backgroundColor: isDark ? AppColors.borderDark : AppColors.grey100,
                              valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                    4.verticalSpace,
                    Text(
                      'الإجمالي: $total EGP',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DebttsSummaryCard extends StatelessWidget {
  const _DebttsSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: 16.allPadding,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFF87171), Color(0xFFEF4444)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: AppSizes.rXL.radius,
        boxShadow: [
          BoxShadow(
            color: AppColors.expense.withValues(alpha: 0.15),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'إجمالي الديون',
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
                    Text(
                      '5,200',
                      style: context.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    AppSizes.s.horizontalSpace,
                    Text(
                      'EGP',
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                AppSizes.xs.verticalSpace,
                Text(
                  'متبقي',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 54.0.w,
                    height: 54.0.h,
                    child: CircularProgressIndicator(
                      value: 0.45,
                      strokeWidth: 5.w,
                      color: Colors.white,
                      backgroundColor: Colors.white.withValues(alpha: 0.25),
                    ),
                  ),
                  Text(
                    '45%',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              AppSizes.s.verticalSpace,
              Text(
                'تم السداد',
                style: context.textTheme.bodySmall?.copyWith(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}