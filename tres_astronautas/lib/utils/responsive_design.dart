// That shows the max width for each screen size
import 'package:flutter/widgets.dart';

/// see https://m3.material.io/foundations/layout/applying-layout/window-size-classedarts
enum ScreenSizeBreakPoints {
  /// mobile < 600
  /// Suggested to use navigation bar, 1 panel and a bottom sheet
  compact(0),

  /// 600 ≤ Tablet in portrait & Foldable in portrait (unfolded) < 840
  /// Suggested to use navigation rail, 1(rec) or 2 panel and a menu
  medium(600),

  /// 840 ≤  Phone/Tablet/Foldable(unfolded) in landscape < 1200
  /// Suggested to use navigation rail, 1 or 2(rec) panel and a menu
  expanded(840);

  const ScreenSizeBreakPoints(this.minWidth);
  final int minWidth;
}

class Resizer extends StatelessWidget {
  const Resizer({
    required this.expanded,
    required this.medium,
    required this.compact,
    super.key,
  });

  ///[expanded] is the view will be displayed on large screens of a desktop/landscape tablet
  ///[compact] is the view will be displayed on the screen of a normal mobile
  ///[medium] is the view will be displayed on the screen of a portrait tablet
  final Widget expanded;
  final Widget compact;
  final Widget medium;

  /// [isCompactSize] returns if screen size is less than the min width of [ScreenSizeBreakPoints.largeMobile]/Mos
  static bool isCompactSize(BuildContext context) {
    return MediaQuery.sizeOf(context).width <=
        ScreenSizeBreakPoints.medium.minWidth;
  }

  /// [isMediumSize] returns if screen size is between the min width of [ScreenSizeBreakPoints.medium] and min width of [ScreenSizeBreakPoints.expanded]
  static bool isMediumSize(BuildContext context) {
    final deviceWidth = MediaQuery.sizeOf(context).width;
    return deviceWidth >= ScreenSizeBreakPoints.compact.minWidth &&
        deviceWidth < ScreenSizeBreakPoints.expanded.minWidth;
  }

  /// [isExpandedSize] returns if screen size is larger than the min width of [ScreenSizeBreakPoints.expanded]
  static bool isExpandedSize(BuildContext context) {
    return MediaQuery.sizeOf(context).width >
        ScreenSizeBreakPoints.expanded.minWidth;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if (size.width < ScreenSizeBreakPoints.medium.minWidth) {
      return compact;
    } else if (size.width < ScreenSizeBreakPoints.expanded.minWidth) {
      return medium;
    } else {
      return expanded;
    }
  }
}
