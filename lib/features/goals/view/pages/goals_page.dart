import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:masrofyy/core/constants/app_assets.dart';
import 'package:masrofyy/core/extensions/build_context.dart';
import 'package:masrofyy/core/extensions/num_extension.dart';
import 'package:masrofyy/core/extensions/widget_extension.dart';
import 'package:masrofyy/core/theme/app_colors.dart';
import 'package:masrofyy/core/theme/app_sizes.dart';
import 'package:masrofyy/core/widgets/custom_app_scaffold.dart';

class GoalsPage extends StatefulWidget {
  const GoalsPage({super.key});

  @override
  State<GoalsPage> createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
  int _selectedTabIndex = 0;
  final List<Map<String, dynamic>> _allGoals = [
    {
      'title': 'شراء سياره',
      'current': '150,000',
      'target': '250,000',
      'percentage': 60,
      'progress': 0.6,
      'icon': Icons.directions_car_rounded,
      'color': AppColors.blue,
      'isActive': true,
    },
    {
      'title': 'سفر تركياء',
      'current': '150,000',
      'target': '250,000',
      'percentage': 100,
      'progress': 1.0,
      'icon': Icons.directions_car_rounded,
      'color': AppColors.blue,
      'isActive': false,
    },
    {
      'title': 'صندوق الطوارئ',
      'current': '150,000',
      'target': '250,000',
      'percentage': 60,
      'progress': 0.6,
      'icon': Icons.directions_car_rounded,
      'color': AppColors.blue,
      'isActive': true,
    },
    {
      'title': 'شراء منزل',
      'current': '150,000',
      'target': '250,000',
      'percentage': 60,
      'progress': 0.6,
      'icon': Icons.directions_car_rounded,
      'color': AppColors.blue,
      'isActive': false,
    }
  ];

  @override
  Widget build(BuildContext context) {
    final iconColor = context.colorScheme.onSurface;

    // تم تصحيح المنطق هنا: إذا كانت القائمة فارغة تظهر رسالة "لاتوجد هنا"، لذا العكس هو الصحيح في الشرط
    final filteredGoals = _allGoals.where((goal) {
      if (_selectedTabIndex == 1) {
        return !goal['isActive'];
      }
      return goal['isActive'];
    }).toList();

    return AppScaffold(
      isDark: context.isDarkMode,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => context.pop(),
                  color: iconColor,
                  icon: Icon(Icons.arrow_back_rounded, size: AppSizes.iconM),
                ),
                Text('الأهداف المالية', style: context.textTheme.titleLarge),
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
            const _GoalsSummaryCards(),
            AppSizes.l.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTabItem('نشطة', index: 0),
                AppSizes.l.horizontalSpace,
                // تم تصحيح الـ index هنا ليكون 1 بدلاً من 0
                _buildTabItem('مكتملة', index: 1),
              ],
            ),
            AppSizes.l.verticalSpace,

            // تم تصحيح الشرط هنا لعرض الـ ListView عندما تكون القائمة غير فارغة، ورسالة الفراغ عندما تكون فارغة
            if (filteredGoals.isEmpty)
              Center(
                child: Column(
                  children: [
                    AppSizes.xxl.verticalSpace,
                    Icon(
                      Icons.track_changes_outlined,
                      size: AppSizes.iconXL,
                      color: AppColors.grey400,
                    ),
                    AppSizes.m.verticalSpace,
                    Text(
                      'لا توجد هنا',
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
                itemCount: filteredGoals.length, // تم تصحيح lengt إلى length
                separatorBuilder: (context, index) => AppSizes.m.verticalSpace,
                itemBuilder: (context, index) { // تم تصحيح context.index إلى (context, index)
                  final goal = filteredGoals[index];
                  return _GoalCard(
                    title: goal['title'] as String,
                    current: goal['current'] as String,
                    target: goal['target'] as String,
                    percentage: goal['percentage'] as int,
                    progressValue: goal['progress'] as double,
                    icon: goal['icon'] as IconData,
                    color: goal['color'] as Color, // تم إكمال النوع Color الناقص
                  );
                },
              ),
          ],
        ).paddingAll(AppSizes.screenPadding),
      ),
    );
  }

  Widget _buildTabItem(String label, {required int index}) {
    final isSelected = _selectedTabIndex == index; // تصحيح الإملاء isSelexted إلى isSelected
    final isDark = context.isDarkMode;
    final activeColor = AppColors.purple;
    return GestureDetector(
      onTap: () => setState(() {
        _selectedTabIndex = index;
      }),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label, // تصحيح lable إلى label
            style: context.textTheme.titleSmall?.copyWith(
              color: isSelected
                  ? activeColor
                  : (isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight),
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
          AppSizes.xs.verticalSpace,
          Container(
            width: 70.w,
            height: 2.h,
            decoration: BoxDecoration(
              color: isSelected ? activeColor : Colors.transparent,
              borderRadius: 1.r.radius,
            ),
          ),
        ],
      ),
    );
  }
}

class _GoalsSummaryCards extends StatelessWidget {
  const _GoalsSummaryCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: 16.allPadding,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6366F1), Color(0xFF4F46E5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppSizes.rXL),
        boxShadow: [
          BoxShadow(
            color: AppColors.purple.withValues(alpha: 0.18),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'إجمالي الأهداف',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                AppSizes.xs.verticalSpace,
                Text(
                  '4',
                  style: context.textTheme.displayMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AppSizes.s.verticalSpace,
                Text(
                  'المكتملة من 5',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
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

class _GoalCard extends StatelessWidget {
  const _GoalCard({
    super.key,
    required this.icon,
    required this.color,
    required this.title, // أضفنا title هنا لأنه مطلوب في الـ Constructor
    required this.current,
    required this.target,
    required this.percentage,
    required this.progressValue,
  });

  final IconData icon;
  final Color color;
  final String title;
  final String current;
  final String target;
  final int percentage;
  final double progressValue;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    return Container(
      padding: 16.allPadding,
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.rL),
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
      ),
      // تم تصحيح هيكل الـ Widget لتكون العناصر مرتبة بشكل صحيح داخل Column أو استخدام عناصر مناسبة بدلاً من وضع Row خارج الـ child الرئيسي
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 44.w,
                    height: 44.h,
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(AppSizes.rM),
                    ),
                    child: Icon(icon, color: color),
                  ),
                  AppSizes.m.horizontalSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: context.textTheme.titleMedium),
                      4.verticalSpace,
                      Text(
                        '$current EGP',
                        style: context.textTheme.bodyMedium,
                      ),
                      2.verticalSpace,
                      Text(
                        'من $target EGP',
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
            ],
          ),
          AppSizes.m.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '$percentage%',
                style: context.textTheme.bodySmall?.copyWith(
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                ),
              ),
              8.horizontalSpace,
              SizedBox(
                width: 80.w,
                child: ClipRRect( // تصحيح الحرف الكبير C في ClipRRect
                  borderRadius: 10.r.radius, // تصحيح الإملاء borderRsdiues إلى borderRadius
                  child: LinearProgressIndicator(
                    value: progressValue,
                    backgroundColor:
                    isDark ? AppColors.borderDark : AppColors.grey100,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}