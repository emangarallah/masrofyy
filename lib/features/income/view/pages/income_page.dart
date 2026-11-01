

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masrofyy/core/constants/app_assets.dart';
import 'package:masrofyy/core/extensions/build_context.dart';
import 'package:masrofyy/core/extensions/num_extension.dart';
import 'package:masrofyy/core/extensions/widget_extension.dart';
import 'package:masrofyy/core/theme/app_colors.dart';
import 'package:masrofyy/core/theme/app_sizes.dart';
import 'package:masrofyy/core/widgets/custom_app_bar.dart';
import 'package:masrofyy/core/widgets/custom_app_scaffold.dart';

class IncomePage extends StatelessWidget {
  const IncomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String,dynamic>> incomeSource = [
      {
        'title':'الراتب الشهري',
        'subtitle':'الشركة الحالمة',
        'amount':'20,000',
        'frequency':'كل شخر',
        'icon':Icons.business_center_rounded,
        'color':AppColors.primary,

      },

      {
        'title':'عمل حر',
        'subtitle':'مشاريع مستقله',
        'amount':'5,0000',
        'frequency':'كل شهر',
        'icon':Icons.laptop_mac_outlined,

        'color':AppColors.primary,

      },
      {
        'title':'أخرى',
        'subtitle':'دخل اضافي',
        'amount':'350',
        'frequency':'عدد الحاجة',
        'icon':Icons.more_horiz_outlined,
        'color':AppColors.purple,

      },
    ];
      return AppScaffold(
      isDark: context.isDarkMode,
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomAppBar(title: 'مصدر الدخل'),
          AppSizes.m.verticalSpace,
          //Summary Card
          const _IncomeSummaryCard(),
          AppSizes.l.verticalSpace,
          //List of incomes source
          ListView.separated(
            shrinkWrap: true,
            itemCount: incomeSource.length,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context,index) => AppSizes.m.verticalSpace,
            itemBuilder: (context,index){
              final item = incomeSource[index];
              return _IncomeSourceCard(
                title:item['title'] as String,
                subtitle:item['subtitle'] as String,
                amount:item['amount'] as String,
                frequency:item['frequency'] as String,
                icon: item['icon'] as IconData,
                color: item['color'] as Color,

              );
            },
          ),



        ],
      ).paddingAll(AppSizes.screenPadding),
    );

  }
}

class _IncomeSourceCard  extends StatelessWidget {
  const _IncomeSourceCard ({super.key, required this.title, required this.subtitle, required this.amount, required this.frequency, required this.icon, required this.color});
  final String  title ;
  final String   subtitle ;
  final String   amount;
  final String    frequency ;
  final IconData icon ;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    return Container(
      padding:AppSizes.m.allPadding,
      decoration: BoxDecoration(


        color: isDark ? AppColors.cardDark: AppColors.white,
        borderRadius: AppSizes.rL.radius,
        border: Border.all(
          color: isDark ? AppColors.borderDark: AppColors.borderLight,
        )

      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Row(children: [
            Container(
              width:44.w ,
              height: 44.h,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppSizes.rM),


              ),
              child: Icon(icon,color: color,size: AppSizes.iconM),

            ),
            AppSizes.m.horizontalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(title,style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold

                ),),
                AppSizes.xs.horizontalSpace,
                Text(subtitle,style: context.textTheme.bodySmall?.copyWith(
                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight
                ),
                )



              ],
            )


          ],),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$amount EGP',style: context.textTheme.titleMedium?.copyWith(
                color: AppColors.income,
                fontWeight: FontWeight.bold
              ),),
              AppSizes.s.verticalSpace,
              Row(
                children: [
                  Icon(Icons.calendar_today_outlined,
                  size: AppSizes.iconXS,
                    color: isDark ? AppColors.textSecondaryDark
                        :AppColors.textSecondaryLight
                    ,
                  ),
                  AppSizes.xs.horizontalSpace,
                  Text(frequency,style: context.textTheme.bodySmall?.copyWith(
                    color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight
                  ),),
                ],
              ),

            ],
          ),



        ],
      ),






      

    );
  }
}


class _IncomeSummaryCard extends StatelessWidget {
  const _IncomeSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: 16.allPadding,
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
          Column(
            children: [
              Text('أجمالي الدخل',style: context.textTheme.bodyMedium?.copyWith(
                color: Colors.white.withValues(alpha: 0.8),
                fontWeight: FontWeight.w500,
              ),
              ),
              AppSizes.xs.verticalSpace,
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text('27,850',style: context.textTheme.headlineMedium),
                  AppSizes.s.horizontalSpace,
                  Text('EGP',style: context.textTheme.titleMedium),
                ],
              ),
              AppSizes.m.verticalSpace,
              //period selection pill
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w ,vertical: 6.h),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: AppSizes.rM.radius,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.keyboard_arrow_down_rounded,
                      color: Colors.white,
                      size: AppSizes.iconXS,
                    ),
                    AppSizes.xs.horizontalSpace,
                    Text('هذا الشهر',style: context.textTheme.bodySmall),



                ],),
              ),

            ],

          ).expanded(),

          AppSizes.s.horizontalSpace,

          Image.asset(
            AppAssets.income,
            width: 120.w,
            height: 120.h,
            fit: BoxFit.contain,
          ),



        ],
      ),
    );
  }
}
