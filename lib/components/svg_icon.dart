import 'package:flutter/material.dart';

class AppIconsWidget {
  static const String _fontFamily = 'AppIconsWidget';

  static const IconData visible = IconData(0xe91a, fontFamily: _fontFamily,);
  static const IconData invisible = IconData(0xe91e, fontFamily: _fontFamily);
  static const IconData informationSolid = IconData(0xe920, fontFamily: _fontFamily);
  static const IconData informationOutline = IconData(0xe921, fontFamily: _fontFamily);
  static const IconData search = IconData(0xe926, fontFamily: _fontFamily);
  static const IconData error = IconData(0xe928, fontFamily: _fontFamily);
  static const IconData warning = IconData(0xe91b, fontFamily: _fontFamily);//need to change
  static const IconData checkMarkCircle = IconData(0xe902, fontFamily: _fontFamily);
  static const IconData star = IconData(0xe917, fontFamily: _fontFamily);
  static const IconData discard = IconData(0xe905, fontFamily: _fontFamily);

  static const IconData tickMark = IconData(0xe918, fontFamily: _fontFamily);
  static const IconData downArrow = IconData(0xe908, fontFamily: _fontFamily);
  static const IconData remove = IconData(0xe903, fontFamily: _fontFamily);
  static const IconData profileCircleOutline = IconData(0xe915, fontFamily: _fontFamily);//need to discus
  static const IconData profileCircleSolid = IconData(0xe923, fontFamily: _fontFamily);
  static const IconData profileSolid = IconData(0xe916, fontFamily: _fontFamily);
  static const IconData mail = IconData(0xe922, fontFamily: _fontFamily);
  static const IconData suitcase = IconData(0xe919, fontFamily: _fontFamily);
  static const IconData hotel = IconData(0xe90b, fontFamily: _fontFamily);
  static const IconData notification = IconData(0xe90f, fontFamily: _fontFamily);//need to discus

  static const IconData pin = IconData(0xe913, fontFamily: _fontFamily);
  static const IconData phone = IconData(0xe912, fontFamily: _fontFamily);
  static const IconData bed = IconData(0xe901, fontFamily: _fontFamily);
  static const IconData menuDots = IconData(0xe90e, fontFamily: _fontFamily);
  static const IconData menuLine = IconData(0xe90d, fontFamily: _fontFamily);
  static const IconData add = IconData(0xe900, fontFamily: _fontFamily);
  static const IconData comment = IconData(0xe904, fontFamily: _fontFamily);
  static const IconData edit = IconData(0xe909, fontFamily: _fontFamily);
  static const IconData doNotDisturb = IconData(0xe906, fontFamily: _fontFamily);
  static const IconData idle = IconData(0xe90c, fontFamily: _fontFamily);

  static const IconData emojiSmile = IconData(0xe90a, fontFamily: _fontFamily);
  static const IconData online = IconData(0xe911, fontFamily: _fontFamily);
  static const IconData offline = IconData(0xe910, fontFamily: _fontFamily);
  static const IconData filter = IconData(0xe91f, fontFamily: _fontFamily);//need to discus
  static const IconData copy = IconData(0xe91d, fontFamily: _fontFamily);
  static const IconData calender = IconData(0xe91c, fontFamily: _fontFamily);
  static const IconData time = IconData(0xe927, fontFamily: _fontFamily);
  static const IconData policy = IconData(0xe914, fontFamily: _fontFamily);
  static const IconData policy1 = Icons.abc_sharp;
 
  // Add more icons as needed, referencing the Unicode values from `selection.json`.
}


class AppIconsWidgetSizes {
  static const double  extraSmall = 10.0;
  static const double  small = 12.0;
  static const double medium = 14.0;
  static const double large = 16.0;
  static const double extraLarge = 20.0;
}

/// A class to store predefined icon colors
class CustomIconColors {
  static const Color primary = Colors.blue;
  static const Color secondary = Colors.grey;
  static const Color success = Color(0xFF00b870);
  static const Color error = Color(0xFFe00925);
  static const Color warning = Color(0xFFf27e03);
  static const Color info = Color(0xFF0972fd);
}


class AppIconColors {
  static const Color visible =  Color(0xFF0232D8); // Assign a specific color
  static const Color invisible =Color(0xFF968D8D);
  static const Color informationSolid =Color(0xFF0972FD);
  static const Color informationOutline =Color(0xFFEC8C6F);
  static const Color search =Color(0xFF0972FD);
  static const Color error = Color(0xFFe00925);
  static const Color warning = Color(0xFFf27e03); // Updated as required
  static const Color checkMarkCircle = Color(0xFF00b870);
  static const Color star =Color(0xFFE86B46);
  static const Color discard =Color(0xFF000000);
  static const Color tickMark = Color(0xFF0972FD);
  static const Color downArrow =Color(0xFF2E2E2E);
  static const Color remove =Color(0xFF2E2E2E);

  static const Color profileCircleOutline = Color(0xFF2E2E2E); // Need to discuss
  static const Color profileCircleSolid = Color(0xFFECBBAC);
  static const Color profileSolid =Color(0xFFEC8C6F);
  static const Color mail = Color(0xFFEC8C6F);
  static const Color suitcase = Color(0xFF0972FD);
  static const Color hotel = Color(0xFF131927);
  static const Color notification = Color(0xFF5A5A5A); // Need to discuss
  static const Color pin = Color(0xFF2E2E2E);
  static const Color phone =Color(0xFFEC8C6F);
  static const Color bed = Color(0xFF2E2E2E);
  static const Color menuDots = Color(0xFF5A5A5A);
  static const Color menuLine = Color(0xFF5A5A5A);

  static const Color add =  Color(0xFF2E2E2E);
  static const Color comment =  Color(0xFF2E2E2E);
  static const Color edit =  Color(0xFF2E2E2E);
  static const Color doNotDisturb = Color(0xFFE00925);
  static const Color idle = Color(0xFFF1C512);
  static const Color emojiSmile = Color(0xFF322929);
  static const Color online =  Color(0xFF00BB70);
  static const Color offline = Color(0xFF898989);
  static const Color filter = Color(0xFF898989);// Need to discuss
  static const Color copy = Color(0xFF2E2E2E);
  static const Color calendar = Color(0xFF2E2E2E);
  static const Color time =  Color(0xFF2E2E2E);
  static const Color policy = Color(0xFF2E2E2E);

  // Add more colors for new icons as needed
}



class AppIcons {
  /// Visible Icon
  static const VisibleIcon visible = VisibleIcon();

  static const InvisibleIcon invisible = InvisibleIcon();

  static const InformationSolidIcon informationSolid = InformationSolidIcon();

  static const InformationOutlineIcon informationOutline = InformationOutlineIcon();

  static const SearchIcon search = SearchIcon();

  static const ErrorIcon error = ErrorIcon();

  static const WarningIcon warning = WarningIcon();

  static const CheckMarkCircleIcon checkMarkCircle = CheckMarkCircleIcon();

  static const StarIcon star = StarIcon();
  
  static const DiscardIcon discard = DiscardIcon();

  static const TickMarkIcon tickMark = TickMarkIcon();

  static const DownArrowIcon downArrow = DownArrowIcon();

  static const RemoveIcon remove = RemoveIcon();

  static const ProfileCircleOutlineIcon profileCircleOutline = ProfileCircleOutlineIcon();

  static const ProfileCircleSolidIcon profileCircleSolid = ProfileCircleSolidIcon();

  static const ProfileSolidIcon profileSolid = ProfileSolidIcon();

  static const MailIcon mail = MailIcon();

  static const SuitcaseIcon suitcase = SuitcaseIcon();

  static const HotelIcon hotel = HotelIcon();
  
  static const NotificationIcon notification = NotificationIcon();

  static const PinIcon pin = PinIcon();

  static const PhoneIcon phone = PhoneIcon();

  static const BedIcon bed = BedIcon();

  static const MenuDotsIcon menuDots = MenuDotsIcon();

  static const MenuLineIcon menuLine = MenuLineIcon();

  static const AddIcon add = AddIcon();

  static const CommentIcon comment = CommentIcon();

  static const EditIcon edit = EditIcon();

  static const DoNotDisturbIcon doNotDisturb = DoNotDisturbIcon();

  static const IdleIcon idle = IdleIcon();

  static const EmojiSmileIcon emojiSmile = EmojiSmileIcon();

  static const OnlineIcon online = OnlineIcon();
  
  static const OfflineIcon offline = OfflineIcon();

  static const FilterIcon filter = FilterIcon();

  static const CopyIcon copy = CopyIcon();

  static const CalendarIcon calender = CalendarIcon();

  static const TimeIcon time = TimeIcon();

  static const PolicyIcon policy = PolicyIcon();






  /// Custom dynamic icon generator
  static Icon custom({
    required IconData iconData,
    double size = AppIconsWidgetSizes.medium,
    Color color = CustomIconColors.primary,
  }) {
    return Icon(
      iconData,
      size: size,
      color: color,
    );
  }
}
//--------------------------------------------------------------------------------------------------------

// Visible Icon with multiple sizes
class VisibleIcon {
  const VisibleIcon();

  Icon get extraSmall => const Icon(
        AppIconsWidget.visible,
        size: AppIconsWidgetSizes.extraSmall,
        color:AppIconColors.visible,
      );

  Icon get small => const Icon(
        AppIconsWidget.visible,
        size: AppIconsWidgetSizes.small,
        color: AppIconColors.visible,
      );

  Icon get medium => const Icon(
        AppIconsWidget.visible,
        size: AppIconsWidgetSizes.medium,
        color: AppIconColors.visible,
      );

  Icon get large => const Icon(
        AppIconsWidget.visible,
        size: AppIconsWidgetSizes.large,
        color: AppIconColors.visible,
      );

  Icon get extraLarge => const Icon(
        AppIconsWidget.visible,
        size: AppIconsWidgetSizes.extraLarge,
        color: AppIconColors.visible,
      );
}

// Invisible Icon with multiple sizes
class InvisibleIcon {
  const InvisibleIcon();

  Icon get extraSmall => const Icon(
        AppIconsWidget.invisible,
        size: AppIconsWidgetSizes.extraSmall,
        color: AppIconColors.invisible,
      );

  Icon get small => const Icon(
        AppIconsWidget.invisible,
        size: AppIconsWidgetSizes.small,
        color: AppIconColors.invisible,
      );

  Icon get medium => const Icon(
        AppIconsWidget.invisible,
        size: AppIconsWidgetSizes.medium,
        color: AppIconColors.invisible,
      );

  Icon get large => const Icon(
        AppIconsWidget.invisible,
        size: AppIconsWidgetSizes.large,
        color: AppIconColors.invisible,
      );

  Icon get extraLarge => const Icon(
        AppIconsWidget.invisible,
        size: AppIconsWidgetSizes.extraLarge,
        color: AppIconColors.invisible,
      );
}

// Information Solid Icon with multiple sizes
class InformationSolidIcon {
  const InformationSolidIcon();

  Icon get extraSmall => const Icon(
        AppIconsWidget.informationSolid,
        size: AppIconsWidgetSizes.extraSmall,
        color: AppIconColors.informationSolid,
      );

  Icon get small => const Icon(
        AppIconsWidget.informationSolid,
        size: AppIconsWidgetSizes.small,
        color:  AppIconColors.informationSolid,
      );

  Icon get medium => const Icon(
        AppIconsWidget.informationSolid,
        size: AppIconsWidgetSizes.medium,
        color:  AppIconColors.informationSolid,
      );

  Icon get large => const Icon(
        AppIconsWidget.informationSolid,
        size: AppIconsWidgetSizes.large,
        color: AppIconColors.informationSolid,
      );

  Icon get extraLarge => const Icon(
        AppIconsWidget.informationSolid,
        size: AppIconsWidgetSizes.extraLarge,
        color:  AppIconColors.informationSolid,
      );
}

// Information Outline Icon with multiple sizes
class InformationOutlineIcon {
  const InformationOutlineIcon();

  Icon get extraSmall => const Icon(
        AppIconsWidget.informationOutline,
        size: AppIconsWidgetSizes.extraSmall,
        color:  AppIconColors.informationOutline,
      );

  Icon get small => const Icon(
        AppIconsWidget.informationOutline,
        size: AppIconsWidgetSizes.small,
        color: AppIconColors.informationOutline,
      );

  Icon get medium => const Icon(
        AppIconsWidget.informationOutline,
        size: AppIconsWidgetSizes.medium,
        color:  AppIconColors.informationOutline,
      );

  Icon get large => const Icon(
        AppIconsWidget.informationOutline,
        size: AppIconsWidgetSizes.large,
        color: AppIconColors.informationOutline,
      );

  Icon get extraLarge => const Icon(
        AppIconsWidget.informationOutline,
        size: AppIconsWidgetSizes.extraLarge,
        color:  AppIconColors.informationOutline,
      );
}

// Search Icon with multiple sizes
class SearchIcon {
  const SearchIcon();

  Icon get extraSmall => const Icon(
        AppIconsWidget.search,
        size: AppIconsWidgetSizes.extraSmall,
        color:  AppIconColors.search,
      );

  Icon get small => const Icon(
        AppIconsWidget.search,
        size: AppIconsWidgetSizes.small,
        color:  AppIconColors.search,
      );

  Icon get medium => const Icon(
        AppIconsWidget.search,
        size: AppIconsWidgetSizes.medium,
        color:  AppIconColors.search,
      );

  Icon get large => const Icon(
        AppIconsWidget.search,
        size: AppIconsWidgetSizes.large,
        color: AppIconColors.search,
      );

  Icon get extraLarge => const Icon(
        AppIconsWidget.search,
        size: AppIconsWidgetSizes.extraLarge,
        color:  AppIconColors.search,
      );
}

// Error Icon with multiple sizes
class ErrorIcon {
  const ErrorIcon();

  Icon get extraSmall => const Icon(
        AppIconsWidget.error,
        size: AppIconsWidgetSizes.extraSmall,
        color: AppIconColors.error,
      );

  Icon get small => const Icon(
        AppIconsWidget.error,
        size: AppIconsWidgetSizes.small,
        color: AppIconColors.error,
      );

  Icon get medium => const Icon(
        AppIconsWidget.error,
        size: AppIconsWidgetSizes.medium,
        color: AppIconColors.error,
      );

  Icon get large => const Icon(
        AppIconsWidget.error,
        size: AppIconsWidgetSizes.large,
        color: AppIconColors.error,
      );

  Icon get extraLarge => const Icon(
        AppIconsWidget.error,
        size: AppIconsWidgetSizes.extraLarge,
        color: AppIconColors.error,
      );
}

// Warning Icon with multiple sizes
class WarningIcon {
  const WarningIcon();

  Icon get extraSmall => const Icon(
        AppIconsWidget.warning,
        size: AppIconsWidgetSizes.extraSmall,
        color: AppIconColors.warning,
      );

  Icon get small => const Icon(
        AppIconsWidget.warning,
        size: AppIconsWidgetSizes.small,
        color: AppIconColors.warning,
      );

  Icon get medium => const Icon(
        AppIconsWidget.warning,
        size: AppIconsWidgetSizes.medium,
        color: AppIconColors.warning,
      );

  Icon get large => const Icon(
        AppIconsWidget.warning,
        size: AppIconsWidgetSizes.large,
        color: AppIconColors.warning,
      );

  Icon get extraLarge => const Icon(
        AppIconsWidget.warning,
        size: AppIconsWidgetSizes.extraLarge,
        color: AppIconColors.warning,
      );
}

// Check Mark Circle Icon with multiple sizes
class CheckMarkCircleIcon {
  const CheckMarkCircleIcon();

  Icon get extraSmall => const Icon(
        AppIconsWidget.checkMarkCircle,
        size: AppIconsWidgetSizes.extraSmall,
        color: AppIconColors.checkMarkCircle,
      );

  Icon get small => const Icon(
        AppIconsWidget.checkMarkCircle,
        size: AppIconsWidgetSizes.small,
        color: AppIconColors.checkMarkCircle,
      );

  Icon get medium => const Icon(
        AppIconsWidget.checkMarkCircle,
        size: AppIconsWidgetSizes.medium,
        color: AppIconColors.checkMarkCircle,
      );

  Icon get large => const Icon(
        AppIconsWidget.checkMarkCircle,
        size: AppIconsWidgetSizes.large,
        color: AppIconColors.checkMarkCircle,
      );

  Icon get extraLarge => const Icon(
        AppIconsWidget.checkMarkCircle,
        size: AppIconsWidgetSizes.extraLarge,
        color: AppIconColors.checkMarkCircle,
      );
}

// Star Icon with multiple sizes
class StarIcon {
  const StarIcon();

  Icon get extraSmall => const Icon(
        AppIconsWidget.star,
        size: AppIconsWidgetSizes.extraSmall,
        color: AppIconColors.star,
      );

  Icon get small => const Icon(
        AppIconsWidget.star,
        size: AppIconsWidgetSizes.small,
        color: AppIconColors.star,
      );

  Icon get medium => const Icon(
        AppIconsWidget.star,
        size: AppIconsWidgetSizes.medium,
        color: AppIconColors.star,
      );

  Icon get large => const Icon(
        AppIconsWidget.star,
        size: AppIconsWidgetSizes.large,
        color: AppIconColors.star,
      );

  Icon get extraLarge => const Icon(
        AppIconsWidget.star,
        size: AppIconsWidgetSizes.extraLarge,
        color: AppIconColors.star,
      );
}

// Discard Icon with multiple sizes
class DiscardIcon {
  const DiscardIcon();

  Icon get extraSmall => const Icon(
        AppIconsWidget.discard,
        size: AppIconsWidgetSizes.extraSmall,
        color: AppIconColors.discard,
      );

  Icon get small => const Icon(
        AppIconsWidget.discard,
        size: AppIconsWidgetSizes.small,
        color: AppIconColors.discard,
      );

  Icon get medium => const Icon(
        AppIconsWidget.discard,
        size: AppIconsWidgetSizes.medium,
        color: AppIconColors.discard,
      );

  Icon get large => const Icon(
        AppIconsWidget.discard,
        size: AppIconsWidgetSizes.large,
        color: AppIconColors.discard,
      );

  Icon get extraLarge => const Icon(
        AppIconsWidget.discard,
        size: AppIconsWidgetSizes.extraLarge,
        color: AppIconColors.discard,
      );
}

// Tick Mark Icon with multiple sizes
class TickMarkIcon {
  const TickMarkIcon();

  Icon get extraSmall => const Icon(
        AppIconsWidget.tickMark,
        size: AppIconsWidgetSizes.extraSmall,
        color: AppIconColors.tickMark,
      );

  Icon get small => const Icon(
        AppIconsWidget.tickMark,
        size: AppIconsWidgetSizes.small,
        color: AppIconColors.tickMark,
      );

  Icon get medium => const Icon(
        AppIconsWidget.tickMark,
        size: AppIconsWidgetSizes.medium,
        color: AppIconColors.tickMark,
      );

  Icon get large => const Icon(
        AppIconsWidget.tickMark,
        size: AppIconsWidgetSizes.large,
        color: AppIconColors.tickMark,
      );

  Icon get extraLarge => const Icon(
        AppIconsWidget.tickMark,
        size: AppIconsWidgetSizes.extraLarge,
        color: AppIconColors.tickMark,
      );
}

// Down Arrow Icon with multiple sizes
class DownArrowIcon {
  const DownArrowIcon();

  Icon get extraSmall => const Icon(
        AppIconsWidget.downArrow,
        size: AppIconsWidgetSizes.extraSmall,
        color: AppIconColors.downArrow,
      );

  Icon get small => const Icon(
        AppIconsWidget.downArrow,
        size: AppIconsWidgetSizes.small,
        color: AppIconColors.downArrow,
      );

  Icon get medium => const Icon(
        AppIconsWidget.downArrow,
        size: AppIconsWidgetSizes.medium,
        color: AppIconColors.downArrow,
      );

  Icon get large => const Icon(
        AppIconsWidget.downArrow,
        size: AppIconsWidgetSizes.large,
        color: AppIconColors.downArrow,
      );

  Icon get extraLarge => const Icon(
        AppIconsWidget.downArrow,
        size: AppIconsWidgetSizes.extraLarge,
        color: AppIconColors.downArrow,
      );
}

// Remove Icon with multiple sizes
class RemoveIcon {
  const RemoveIcon();

  Icon get extraSmall => const Icon(
        AppIconsWidget.remove,
        size: AppIconsWidgetSizes.extraSmall,
        color: AppIconColors.remove,
      );

  Icon get small => const Icon(
        AppIconsWidget.remove,
        size: AppIconsWidgetSizes.small,
        color: AppIconColors.remove,
      );

  Icon get medium => const Icon(
        AppIconsWidget.remove,
        size: AppIconsWidgetSizes.medium,
        color: AppIconColors.remove,
      );

  Icon get large => const Icon(
        AppIconsWidget.remove,
        size: AppIconsWidgetSizes.large,
        color: AppIconColors.remove,
      );

  Icon get extraLarge => const Icon(
        AppIconsWidget.remove,
        size: AppIconsWidgetSizes.extraLarge,
        color: AppIconColors.remove,
      );
}

// Profile Circle Outline Icon with multiple sizes
class ProfileCircleOutlineIcon {
  const ProfileCircleOutlineIcon();

  Icon get extraSmall => const Icon(
        AppIconsWidget.profileCircleOutline,
        size: AppIconsWidgetSizes.extraSmall,
        color: AppIconColors.profileCircleOutline,
      );

  Icon get small => const Icon(
        AppIconsWidget.profileCircleOutline,
        size: AppIconsWidgetSizes.small,
        color: AppIconColors.profileCircleOutline,
      );

  Icon get medium => const Icon(
        AppIconsWidget.profileCircleOutline,
        size: AppIconsWidgetSizes.medium,
        color: AppIconColors.profileCircleOutline,
      );

  Icon get large => const Icon(
        AppIconsWidget.profileCircleOutline,
        size: AppIconsWidgetSizes.large,
        color: AppIconColors.profileCircleOutline,
      );

  Icon get extraLarge => const Icon(
        AppIconsWidget.profileCircleOutline,
        size: AppIconsWidgetSizes.extraLarge,
        color: AppIconColors.profileCircleOutline,
      );
}

// Profile Circle Solid Icon with multiple sizes
class ProfileCircleSolidIcon {
  const ProfileCircleSolidIcon();

  Icon get extraSmall => const Icon(
        AppIconsWidget.profileCircleSolid,
        size: AppIconsWidgetSizes.extraSmall,
        color: AppIconColors.profileCircleSolid,
      );

  Icon get small => const Icon(
        AppIconsWidget.profileCircleSolid,
        size: AppIconsWidgetSizes.small,
        color: AppIconColors.profileCircleSolid,
      );

  Icon get medium => const Icon(
        AppIconsWidget.profileCircleSolid,
        size: AppIconsWidgetSizes.medium,
        color: AppIconColors.profileCircleSolid,
      );

  Icon get large => const Icon(
        AppIconsWidget.profileCircleSolid,
        size: AppIconsWidgetSizes.large,
        color: AppIconColors.profileCircleSolid,
      );

  Icon get extraLarge => const Icon(
        AppIconsWidget.profileCircleSolid,
        size: AppIconsWidgetSizes.extraLarge,
        color: AppIconColors.profileCircleSolid,
      );
}

// Profile Solid Icon with multiple sizes
class ProfileSolidIcon {
  const ProfileSolidIcon();

  Icon get extraSmall => const Icon(
        AppIconsWidget.profileSolid,
        size: AppIconsWidgetSizes.extraSmall,
        color: AppIconColors.profileSolid,
      );

  Icon get small => const Icon(
        AppIconsWidget.profileSolid,
        size: AppIconsWidgetSizes.small,
        color: AppIconColors.profileSolid,
      );

  Icon get medium => const Icon(
        AppIconsWidget.profileSolid,
        size: AppIconsWidgetSizes.medium,
        color: AppIconColors.profileSolid,
      );

  Icon get large => const Icon(
        AppIconsWidget.profileSolid,
        size: AppIconsWidgetSizes.large,
        color: AppIconColors.profileSolid,
      );

  Icon get extraLarge => const Icon(
        AppIconsWidget.profileSolid,
        size: AppIconsWidgetSizes.extraLarge,
        color: AppIconColors.profileSolid,
      );
}

// Mail Icon with multiple sizes
class MailIcon {
  const MailIcon();

  Icon get extraSmall => const Icon(
        AppIconsWidget.mail,
        size: AppIconsWidgetSizes.extraSmall,
        color: AppIconColors.mail,
      );

  Icon get small => const Icon(
        AppIconsWidget.mail,
        size: AppIconsWidgetSizes.small,
        color: AppIconColors.mail,
      );

  Icon get medium => const Icon(
        AppIconsWidget.mail,
        size: AppIconsWidgetSizes.medium,
        color: AppIconColors.mail,
      );

  Icon get large => const Icon(
        AppIconsWidget.mail,
        size: AppIconsWidgetSizes.large,
        color: AppIconColors.mail,
      );

  Icon get extraLarge => const Icon(
        AppIconsWidget.mail,
        size: AppIconsWidgetSizes.extraLarge,
        color: AppIconColors.mail,
      );
}

// Suitcase Icon with multiple sizes
class SuitcaseIcon {
  const SuitcaseIcon();

  Icon get extraSmall => const Icon(
        AppIconsWidget.suitcase,
        size: AppIconsWidgetSizes.extraSmall,
        color: AppIconColors.suitcase,
      );

  Icon get small => const Icon(
        AppIconsWidget.suitcase,
        size: AppIconsWidgetSizes.small,
        color: AppIconColors.suitcase,
      );

  Icon get medium => const Icon(
        AppIconsWidget.suitcase,
        size: AppIconsWidgetSizes.medium,
        color: AppIconColors.suitcase,
      );

  Icon get large => const Icon(
        AppIconsWidget.suitcase,
        size: AppIconsWidgetSizes.large,
        color: AppIconColors.suitcase,
      );

  Icon get extraLarge => const Icon(
        AppIconsWidget.suitcase,
        size: AppIconsWidgetSizes.extraLarge,
        color: AppIconColors.suitcase,
      );
}

// Hotel Icon with multiple sizes
class HotelIcon {
  const HotelIcon();

  Icon get extraSmall => const Icon(
        AppIconsWidget.hotel,
        size: AppIconsWidgetSizes.extraSmall,
        color: AppIconColors.hotel,
      );

  Icon get small => const Icon(
        AppIconsWidget.hotel,
        size: AppIconsWidgetSizes.small,
        color: AppIconColors.hotel,
      );

  Icon get medium => const Icon(
        AppIconsWidget.hotel,
        size: AppIconsWidgetSizes.medium,
        color: AppIconColors.hotel,
      );

  Icon get large => const Icon(
        AppIconsWidget.hotel,
        size: AppIconsWidgetSizes.large,
        color: AppIconColors.hotel,
      );

  Icon get extraLarge => const Icon(
        AppIconsWidget.hotel,
        size: AppIconsWidgetSizes.extraLarge,
        color: AppIconColors.hotel,
      );
}

// Notification Icon with multiple sizes
class NotificationIcon {
  const NotificationIcon();

  Icon get extraSmall => const Icon(
        AppIconsWidget.notification,
        size: AppIconsWidgetSizes.extraSmall,
        color: AppIconColors.notification,
      );

  Icon get small => const Icon(
        AppIconsWidget.notification,
        size: AppIconsWidgetSizes.small,
        color: AppIconColors.notification,
      );

  Icon get medium => const Icon(
        AppIconsWidget.notification,
        size: AppIconsWidgetSizes.medium,
        color: AppIconColors.notification,
      );

  Icon get large => const Icon(
        AppIconsWidget.notification,
        size: AppIconsWidgetSizes.large,
        color: AppIconColors.notification,
      );

  Icon get extraLarge => const Icon(
        AppIconsWidget.notification,
        size: AppIconsWidgetSizes.extraLarge,
        color: AppIconColors.notification,
      );
}

// Pin Icon with multiple sizes
class PinIcon {
  const PinIcon();

  Icon get extraSmall => const Icon(
        AppIconsWidget.pin,
        size: AppIconsWidgetSizes.extraSmall,
        color: AppIconColors.pin,
      );

  Icon get small => const Icon(
        AppIconsWidget.pin,
        size: AppIconsWidgetSizes.small,
        color: AppIconColors.pin,
      );

  Icon get medium => const Icon(
        AppIconsWidget.pin,
        size: AppIconsWidgetSizes.medium,
        color: AppIconColors.pin,
      );

  Icon get large => const Icon(
        AppIconsWidget.pin,
        size: AppIconsWidgetSizes.large,
        color: AppIconColors.pin,
      );

  Icon get extraLarge => const Icon(
        AppIconsWidget.pin,
        size: AppIconsWidgetSizes.extraLarge,
        color: AppIconColors.pin,
      );
}

// Phone Icon with multiple sizes
class PhoneIcon {
  const PhoneIcon();

  Icon get extraSmall => const Icon(
        AppIconsWidget.phone,
        size: AppIconsWidgetSizes.extraSmall,
        color: AppIconColors.phone,
      );

  Icon get small => const Icon(
        AppIconsWidget.phone,
        size: AppIconsWidgetSizes.small,
        color: AppIconColors.phone,
      );

  Icon get medium => const Icon(
        AppIconsWidget.phone,
        size: AppIconsWidgetSizes.medium,
        color: AppIconColors.phone,
      );

  Icon get large => const Icon(
        AppIconsWidget.phone,
        size: AppIconsWidgetSizes.large,
        color: AppIconColors.phone,
      );

  Icon get extraLarge => const Icon(
        AppIconsWidget.phone,
        size: AppIconsWidgetSizes.extraLarge,
        color: AppIconColors.phone,
      );
}

// Bed Icon with multiple sizes
class BedIcon {
  const BedIcon();

  Icon get extraSmall => const Icon(
        AppIconsWidget.bed,
        size: AppIconsWidgetSizes.extraSmall,
        color: AppIconColors.bed,
      );

  Icon get small => const Icon(
        AppIconsWidget.bed,
        size: AppIconsWidgetSizes.small,
        color: AppIconColors.bed,
      );

  Icon get medium => const Icon(
        AppIconsWidget.bed,
        size: AppIconsWidgetSizes.medium,
        color: AppIconColors.bed,
      );

  Icon get large => const Icon(
        AppIconsWidget.bed,
        size: AppIconsWidgetSizes.large,
        color: AppIconColors.bed,
      );

  Icon get extraLarge => const Icon(
        AppIconsWidget.bed,
        size: AppIconsWidgetSizes.extraLarge,
        color: AppIconColors.bed,
      );
}

// Menu Dots Icon with multiple sizes
class MenuDotsIcon {
  const MenuDotsIcon();

  Icon get extraSmall => const Icon(
        AppIconsWidget.menuDots,
        size: AppIconsWidgetSizes.extraSmall,
        color: AppIconColors.menuDots,
      );

  Icon get small => const Icon(
        AppIconsWidget.menuDots,
        size: AppIconsWidgetSizes.small,
        color: AppIconColors.menuDots,
      );

  Icon get medium => const Icon(
        AppIconsWidget.menuDots,
        size: AppIconsWidgetSizes.medium,
        color: AppIconColors.menuDots,
      );

  Icon get large => const Icon(
        AppIconsWidget.menuDots,
        size: AppIconsWidgetSizes.large,
        color: AppIconColors.menuDots,
      );

  Icon get extraLarge => const Icon(
        AppIconsWidget.menuDots,
        size: AppIconsWidgetSizes.extraLarge,
        color: AppIconColors.menuDots,
      );
}

// Menu Line Icon with multiple sizes
class MenuLineIcon {
  const MenuLineIcon();

  Icon get extraSmall => const Icon(
        AppIconsWidget.menuLine,
        size: AppIconsWidgetSizes.extraSmall,
        color: AppIconColors.menuLine,
      );

  Icon get small => const Icon(
        AppIconsWidget.menuLine,
        size: AppIconsWidgetSizes.small,
        color: AppIconColors.menuLine,
      );

  Icon get medium => const Icon(
        AppIconsWidget.menuLine,
        size: AppIconsWidgetSizes.medium,
        color: AppIconColors.menuLine,
      );

  Icon get large => const Icon(
        AppIconsWidget.menuLine,
        size: AppIconsWidgetSizes.large,
        color: AppIconColors.menuLine,
      );

  Icon get extraLarge => const Icon(
        AppIconsWidget.menuLine,
        size: AppIconsWidgetSizes.extraLarge,
        color: AppIconColors.menuLine,
      );
}



// Add Icon with multiple sizes
class AddIcon {
  const AddIcon();

  Icon get extraSmall => const Icon(
        AppIconsWidget.add,
        size: AppIconsWidgetSizes.extraSmall,
        color: AppIconColors.add,
      );

  Icon get small => const Icon(
        AppIconsWidget.add,
        size: AppIconsWidgetSizes.small,
        color: AppIconColors.add,
      );

  Icon get medium => const Icon(
        AppIconsWidget.add,
        size: AppIconsWidgetSizes.medium,
        color: AppIconColors.add,
      );

  Icon get large => const Icon(
        AppIconsWidget.add,
        size: AppIconsWidgetSizes.large,
        color: AppIconColors.add,
      );

  Icon get extraLarge => const Icon(
        AppIconsWidget.add,
        size: AppIconsWidgetSizes.extraLarge,
        color: AppIconColors.add,
      );
}

// Comment Icon with multiple sizes
class CommentIcon {
  const CommentIcon();

  Icon get extraSmall => const Icon(
        AppIconsWidget.comment,
        size: AppIconsWidgetSizes.extraSmall,
        color: AppIconColors.comment,
      );

  Icon get small => const Icon(
        AppIconsWidget.comment,
        size: AppIconsWidgetSizes.small,
        color: AppIconColors.comment,
      );

  Icon get medium => const Icon(
        AppIconsWidget.comment,
        size: AppIconsWidgetSizes.medium,
        color: AppIconColors.comment,
      );

  Icon get large => const Icon(
        AppIconsWidget.comment,
        size: AppIconsWidgetSizes.large,
        color: AppIconColors.comment,
      );

  Icon get extraLarge => const Icon(
        AppIconsWidget.comment,
        size: AppIconsWidgetSizes.extraLarge,
        color: AppIconColors.comment,
      );
}

// Edit Icon with multiple sizes
class EditIcon {
  const EditIcon();

  Icon get extraSmall => const Icon(
        AppIconsWidget.edit,
        size: AppIconsWidgetSizes.extraSmall,
        color: AppIconColors.edit,
      );

  Icon get small => const Icon(
        AppIconsWidget.edit,
        size: AppIconsWidgetSizes.small,
        color: AppIconColors.edit,
      );

  Icon get medium => const Icon(
        AppIconsWidget.edit,
        size: AppIconsWidgetSizes.medium,
        color: AppIconColors.edit,
      );

  Icon get large => const Icon(
        AppIconsWidget.edit,
        size: AppIconsWidgetSizes.large,
        color: AppIconColors.edit,
      );

  Icon get extraLarge => const Icon(
        AppIconsWidget.edit,
        size: AppIconsWidgetSizes.extraLarge,
        color: AppIconColors.edit,
      );
}

// Do Not Disturb Icon with multiple sizes
class DoNotDisturbIcon {
  const DoNotDisturbIcon();

  Icon get extraSmall => const Icon(
        AppIconsWidget.doNotDisturb,
        size: AppIconsWidgetSizes.extraSmall,
        color: AppIconColors.doNotDisturb,
      );

  Icon get small => const Icon(
        AppIconsWidget.doNotDisturb,
        size: AppIconsWidgetSizes.small,
        color: AppIconColors.doNotDisturb,
      );

  Icon get medium => const Icon(
        AppIconsWidget.doNotDisturb,
        size: AppIconsWidgetSizes.medium,
        color: AppIconColors.doNotDisturb,
      );

  Icon get large => const Icon(
        AppIconsWidget.doNotDisturb,
        size: AppIconsWidgetSizes.large,
        color:AppIconColors.doNotDisturb,
      );

  Icon get extraLarge => const Icon(
        AppIconsWidget.doNotDisturb,
        size: AppIconsWidgetSizes.extraLarge,
        color: AppIconColors.doNotDisturb,
      );
}

// Idle Icon with multiple sizes
class IdleIcon {
  const IdleIcon();

  Icon get extraSmall => const Icon(
        AppIconsWidget.idle,
        size: AppIconsWidgetSizes.extraSmall,
        color: AppIconColors.idle,
      );

  Icon get small => const Icon(
        AppIconsWidget.idle,
        size: AppIconsWidgetSizes.small,
        color: AppIconColors.idle,
      );

  Icon get medium => const Icon(
        AppIconsWidget.idle,
        size: AppIconsWidgetSizes.medium,
        color: AppIconColors.idle,
      );

  Icon get large => const Icon(
        AppIconsWidget.idle,
        size: AppIconsWidgetSizes.large,
        color: AppIconColors.idle,
      );

  Icon get extraLarge => const Icon(
        AppIconsWidget.idle,
        size: AppIconsWidgetSizes.extraLarge,
        color: AppIconColors.idle,
      );
}

// Emoji Smile Icon with multiple sizes
class EmojiSmileIcon {
  const EmojiSmileIcon();

  Icon get extraSmall => const Icon(
        AppIconsWidget.emojiSmile,
        size: AppIconsWidgetSizes.extraSmall,
        color: AppIconColors.emojiSmile,
      );

  Icon get small => const Icon(
        AppIconsWidget.emojiSmile,
        size: AppIconsWidgetSizes.small,
        color: AppIconColors.emojiSmile,
      );

  Icon get medium => const Icon(
        AppIconsWidget.emojiSmile,
        size: AppIconsWidgetSizes.medium,
        color: AppIconColors.emojiSmile,
      );

  Icon get large => const Icon(
        AppIconsWidget.emojiSmile,
        size: AppIconsWidgetSizes.large,
        color: AppIconColors.emojiSmile,
      );

  Icon get extraLarge => const Icon(
        AppIconsWidget.emojiSmile,
        size: AppIconsWidgetSizes.extraLarge,
        color: AppIconColors.emojiSmile,
      );
}

// Online Icon with multiple sizes
class OnlineIcon {
  const OnlineIcon();

  Icon get extraSmall => const Icon(
        AppIconsWidget.online,
        size: AppIconsWidgetSizes.extraSmall,
        color: AppIconColors.online,
      );

  Icon get small => const Icon(
        AppIconsWidget.online,
        size: AppIconsWidgetSizes.small,
        color: AppIconColors.online,
      );

  Icon get medium => const Icon(
        AppIconsWidget.online,
        size: AppIconsWidgetSizes.medium,
        color: AppIconColors.online,
      );

  Icon get large => const Icon(
        AppIconsWidget.online,
        size: AppIconsWidgetSizes.large,
        color: AppIconColors.online,
      );

  Icon get extraLarge => const Icon(
        AppIconsWidget.online,
        size: AppIconsWidgetSizes.extraLarge,
        color: AppIconColors.online,
      );
}

// Offline Icon with multiple sizes
class OfflineIcon {
  const OfflineIcon();

  Icon get extraSmall => const Icon(
        AppIconsWidget.offline,
        size: AppIconsWidgetSizes.extraSmall,
        color: AppIconColors.offline,
      );

  Icon get small => const Icon(
        AppIconsWidget.offline,
        size: AppIconsWidgetSizes.small,
        color: AppIconColors.offline,
      );

  Icon get medium => const Icon(
        AppIconsWidget.offline,
        size: AppIconsWidgetSizes.medium,
        color: AppIconColors.offline,
      );

  Icon get large => const Icon(
        AppIconsWidget.offline,
        size: AppIconsWidgetSizes.large,
        color: AppIconColors.offline,
      );

  Icon get extraLarge => const Icon(
        AppIconsWidget.offline,
        size: AppIconsWidgetSizes.extraLarge,
        color: AppIconColors.offline,
      );
}

// Filter Icon with multiple sizes
class FilterIcon {
  const FilterIcon();

  Icon get extraSmall => const Icon(
        AppIconsWidget.filter,
        size: AppIconsWidgetSizes.extraSmall,
        color: AppIconColors.filter,
      );

  Icon get small => const Icon(
        AppIconsWidget.filter,
        size: AppIconsWidgetSizes.small,
        color: AppIconColors.filter,
      );

  Icon get medium => const Icon(
        AppIconsWidget.filter,
        size: AppIconsWidgetSizes.medium,
        color: AppIconColors.filter,
      );

  Icon get large => const Icon(
        AppIconsWidget.filter,
        size: AppIconsWidgetSizes.large,
        color: AppIconColors.filter,
      );

  Icon get extraLarge => const Icon(
        AppIconsWidget.filter,
        size: AppIconsWidgetSizes.extraLarge,
        color: AppIconColors.filter,
      );
}

// Copy Icon with multiple sizes
class CopyIcon {
  const CopyIcon();

  Icon get extraSmall => const Icon(
        AppIconsWidget.copy,
        size: AppIconsWidgetSizes.extraSmall,
        color: AppIconColors.copy,
      );

  Icon get small => const Icon(
        AppIconsWidget.copy,
        size: AppIconsWidgetSizes.small,
        color: AppIconColors.copy,
      );

  Icon get medium => const Icon(
        AppIconsWidget.copy,
        size: AppIconsWidgetSizes.medium,
        color: AppIconColors.copy,
      );

  Icon get large => const Icon(
        AppIconsWidget.copy,
        size: AppIconsWidgetSizes.large,
        color: AppIconColors.copy,
      );

  Icon get extraLarge => const Icon(
        AppIconsWidget.copy,
        size: AppIconsWidgetSizes.extraLarge,
        color: AppIconColors.copy,
      );
}

// Calendar Icon with multiple sizes
class CalendarIcon {
  const CalendarIcon();

  Icon get extraSmall => const Icon(
        AppIconsWidget.calender,
        size: AppIconsWidgetSizes.extraSmall,
        color: AppIconColors.calendar,
      );

  Icon get small => const Icon(
        AppIconsWidget.calender,
        size: AppIconsWidgetSizes.small,
        color: AppIconColors.calendar,
      );

  Icon get medium => const Icon(
        AppIconsWidget.calender,
        size: AppIconsWidgetSizes.medium,
        color: AppIconColors.calendar,
      );

  Icon get large => const Icon(
        AppIconsWidget.calender,
        size: AppIconsWidgetSizes.large,
        color: AppIconColors.calendar,
      );

  Icon get extraLarge => const Icon(
        AppIconsWidget.calender,
        size: AppIconsWidgetSizes.extraLarge,
        color: AppIconColors.calendar,
      );
}

// Time Icon with multiple sizes
class TimeIcon {
  const TimeIcon();

  Icon get extraSmall => const Icon(
        AppIconsWidget.time,
        size: AppIconsWidgetSizes.extraSmall,
        color: AppIconColors.time,
      );

  Icon get small => const Icon(
        AppIconsWidget.time,
        size: AppIconsWidgetSizes.small,
        color: AppIconColors.time,
      );

  Icon get medium => const Icon(
        AppIconsWidget.time,
        size: AppIconsWidgetSizes.medium,
        color: AppIconColors.time,
      );

  Icon get large => const Icon(
        AppIconsWidget.time,
        size: AppIconsWidgetSizes.large,
        color: AppIconColors.time,
      );

  Icon get extraLarge => const Icon(
        AppIconsWidget.time,
        size: AppIconsWidgetSizes.extraLarge,
        color: AppIconColors.time,
      );
}

// Policy Icon with multiple sizes
class PolicyIcon {
  const PolicyIcon();

  Icon get extraSmall => const Icon(
        AppIconsWidget.policy,
        size: AppIconsWidgetSizes.extraSmall,
        color: AppIconColors.policy,
      );

  Icon get small => const Icon(
        AppIconsWidget.policy,
        size: AppIconsWidgetSizes.small,
        color: AppIconColors.policy,
      );

  Icon get medium => const Icon(
        AppIconsWidget.policy,
        size: AppIconsWidgetSizes.medium,
        color: AppIconColors.policy,
      );

  Icon get large => const Icon(
        AppIconsWidget.policy,
        size: AppIconsWidgetSizes.large,
        color: AppIconColors.policy,
      );

  Icon get extraLarge => const Icon(
        AppIconsWidget.policy,
        size: AppIconsWidgetSizes.extraLarge,
        color: AppIconColors.policy,
      );
}



//--------------------------------------------------------------------------------------------------------------

