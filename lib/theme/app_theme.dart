import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A class that contains all theme configurations for the agricultural equipment management application.
class AppTheme {
  AppTheme._();

  // Agricultural Equipment Management Color Palette
  // Primary colors optimized for outdoor visibility
  static const Color primaryLight = Color(0xFF2E7D32); // Agricultural green
  static const Color primaryVariantLight = Color(0xFF1B5E20);
  static const Color secondaryLight = Color(0xFF558B2F); // Supporting green
  static const Color secondaryVariantLight = Color(0xFF33691E);

  // Surface and background colors for high contrast
  static const Color backgroundLight = Color(0xFFFAFAFA); // Clean background
  static const Color surfaceLight = Color(0xFFFAFAFA);
  static const Color cardLight = Color(0xFFFFFFFF);

  // Status and feedback colors
  static const Color errorLight = Color(0xFFD32F2F); // Equipment alerts
  static const Color warningLight = Color(0xFFF57C00); // Maintenance alerts
  static const Color successLight = Color(0xFF388E3C); // Completed work

  // Text colors for outdoor readability
  static const Color textPrimaryLight = Color(0xFF212121); // High contrast
  static const Color textSecondaryLight = Color(0xFF757575); // Supporting info
  static const Color accentEarthLight = Color(0xFF8D6E63); // Warm brown accent
  static const Color neutralBorderLight =
      Color(0xFFE0E0E0); // Subtle separation

  // On-color variants
  static const Color onPrimaryLight = Color(0xFFFFFFFF);
  static const Color onSecondaryLight = Color(0xFFFFFFFF);
  static const Color onBackgroundLight = Color(0xFF212121);
  static const Color onSurfaceLight = Color(0xFF212121);
  static const Color onErrorLight = Color(0xFFFFFFFF);

  // Dark theme colors for low-light conditions
  static const Color primaryDark = Color(0xFF4CAF50);
  static const Color primaryVariantDark = Color(0xFF2E7D32);
  static const Color secondaryDark = Color(0xFF8BC34A);
  static const Color secondaryVariantDark = Color(0xFF558B2F);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceDark = Color(0xFF1E1E1E);
  static const Color cardDark = Color(0xFF2D2D2D);
  static const Color errorDark = Color(0xFFEF5350);
  static const Color warningDark = Color(0xFFFF9800);
  static const Color successDark = Color(0xFF66BB6A);
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xFFBDBDBD);
  static const Color accentEarthDark = Color(0xFFBCAAA4);
  static const Color neutralBorderDark = Color(0xFF424242);
  static const Color onPrimaryDark = Color(0xFF000000);
  static const Color onSecondaryDark = Color(0xFF000000);
  static const Color onBackgroundDark = Color(0xFFFFFFFF);
  static const Color onSurfaceDark = Color(0xFFFFFFFF);
  static const Color onErrorDark = Color(0xFF000000);

  // Shadow and divider colors
  static const Color shadowLight = Color(0x1F000000);
  static const Color shadowDark = Color(0x1FFFFFFF);
  static const Color dividerLight = Color(0x1F000000);
  static const Color dividerDark = Color(0x1FFFFFFF);

  /// Light theme optimized for outdoor agricultural work
  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: primaryLight,
          onPrimary: onPrimaryLight,
          primaryContainer: primaryVariantLight,
          onPrimaryContainer: onPrimaryLight,
          secondary: secondaryLight,
          onSecondary: onSecondaryLight,
          secondaryContainer: secondaryVariantLight,
          onSecondaryContainer: onSecondaryLight,
          tertiary: accentEarthLight,
          onTertiary: onPrimaryLight,
          tertiaryContainer: accentEarthLight,
          onTertiaryContainer: onPrimaryLight,
          error: errorLight,
          onError: onErrorLight,
          surface: surfaceLight,
          onSurface: onSurfaceLight,
          onSurfaceVariant: textSecondaryLight,
          outline: neutralBorderLight,
          outlineVariant: neutralBorderLight,
          shadow: shadowLight,
          scrim: shadowLight,
          inverseSurface: surfaceDark,
          onInverseSurface: onSurfaceDark,
          inversePrimary: primaryDark),
      scaffoldBackgroundColor: backgroundLight,
      cardColor: cardLight,
      dividerColor: dividerLight,

      // AppBar theme for professional appearance
      appBarTheme: AppBarTheme(
          backgroundColor: primaryLight,
          foregroundColor: onPrimaryLight,
          elevation: 2.0,
          centerTitle: true,
          titleTextStyle: GoogleFonts.roboto(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: onPrimaryLight)),

      // Card theme with subtle elevation for spatial hierarchy
      cardTheme: CardTheme(
          color: cardLight,
          elevation: 2.0,
          shadowColor: shadowLight,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),

      // Bottom navigation optimized for field work
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: surfaceLight,
          selectedItemColor: primaryLight,
          unselectedItemColor: textSecondaryLight,
          type: BottomNavigationBarType.fixed,
          elevation: 4.0),

      // Contextual FAB theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: secondaryLight,
          foregroundColor: onSecondaryLight,
          elevation: 4.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0))),

      // Button themes for agricultural environment
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              foregroundColor: onPrimaryLight,
              backgroundColor: primaryLight,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              textStyle: GoogleFonts.roboto(
                  fontSize: 16, fontWeight: FontWeight.w500))),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
              foregroundColor: primaryLight,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              side: const BorderSide(color: primaryLight, width: 1.5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              textStyle: GoogleFonts.roboto(
                  fontSize: 16, fontWeight: FontWeight.w500))),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              foregroundColor: primaryLight,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              textStyle: GoogleFonts.roboto(
                  fontSize: 16, fontWeight: FontWeight.w500))),

      // Typography optimized for agricultural equipment management
      textTheme: _buildTextTheme(isLight: true),

      // Input decoration for outdoor use with gloved hands
      inputDecorationTheme: InputDecorationTheme(
          fillColor: surfaceLight,
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: neutralBorderLight)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: neutralBorderLight)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: primaryLight, width: 2.0)),
          errorBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: const BorderSide(color: errorLight, width: 2.0)),
          focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: const BorderSide(color: errorLight, width: 2.0)),
          labelStyle: GoogleFonts.roboto(color: textSecondaryLight, fontSize: 16),
          hintStyle: GoogleFonts.roboto(color: textSecondaryLight, fontSize: 16),
          prefixIconColor: textSecondaryLight,
          suffixIconColor: textSecondaryLight),

      // Switch theme for equipment controls
      switchTheme: SwitchThemeData(thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryLight;
        }
        return Colors.grey[300];
      }), trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryLight.withValues(alpha: 0.5);
        }
        return Colors.grey[400];
      })),
      checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return primaryLight;
            }
            return Colors.transparent;
          }),
          checkColor: WidgetStateProperty.all(onPrimaryLight),
          side: const BorderSide(color: neutralBorderLight, width: 2.0)),
      radioTheme: RadioThemeData(fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryLight;
        }
        return textSecondaryLight;
      })),

      // Progress indicators for equipment status
      progressIndicatorTheme: const ProgressIndicatorThemeData(color: primaryLight, linearTrackColor: neutralBorderLight),
      sliderTheme: SliderThemeData(activeTrackColor: primaryLight, thumbColor: primaryLight, overlayColor: primaryLight.withValues(alpha: 0.2), inactiveTrackColor: neutralBorderLight, trackHeight: 4.0),
      tabBarTheme: TabBarTheme(labelColor: primaryLight, unselectedLabelColor: textSecondaryLight, indicatorColor: primaryLight, indicatorSize: TabBarIndicatorSize.tab, labelStyle: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500), unselectedLabelStyle: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w400)),
      tooltipTheme: TooltipThemeData(decoration: BoxDecoration(color: textPrimaryLight.withValues(alpha: 0.9), borderRadius: BorderRadius.circular(4)), textStyle: GoogleFonts.roboto(color: surfaceLight, fontSize: 14), padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
      snackBarTheme: SnackBarThemeData(backgroundColor: textPrimaryLight, contentTextStyle: GoogleFonts.roboto(color: surfaceLight, fontSize: 16), actionTextColor: secondaryLight, behavior: SnackBarBehavior.floating, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),

      // List tile theme for equipment lists
      listTileTheme: ListTileThemeData(contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)), tileColor: surfaceLight),

      // Bottom sheet theme for contextual actions
      bottomSheetTheme: const BottomSheetThemeData(backgroundColor: surfaceLight, elevation: 4.0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)))),
      dialogTheme: DialogThemeData(backgroundColor: cardLight));

  /// Dark theme for low-light agricultural conditions
  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: primaryDark,
          onPrimary: onPrimaryDark,
          primaryContainer: primaryVariantDark,
          onPrimaryContainer: onPrimaryDark,
          secondary: secondaryDark,
          onSecondary: onSecondaryDark,
          secondaryContainer: secondaryVariantDark,
          onSecondaryContainer: onSecondaryDark,
          tertiary: accentEarthDark,
          onTertiary: onPrimaryDark,
          tertiaryContainer: accentEarthDark,
          onTertiaryContainer: onPrimaryDark,
          error: errorDark,
          onError: onErrorDark,
          surface: surfaceDark,
          onSurface: onSurfaceDark,
          onSurfaceVariant: textSecondaryDark,
          outline: neutralBorderDark,
          outlineVariant: neutralBorderDark,
          shadow: shadowDark,
          scrim: shadowDark,
          inverseSurface: surfaceLight,
          onInverseSurface: onSurfaceLight,
          inversePrimary: primaryLight),
      scaffoldBackgroundColor: backgroundDark,
      cardColor: cardDark,
      dividerColor: dividerDark,
      appBarTheme: AppBarTheme(
          backgroundColor: surfaceDark,
          foregroundColor: onSurfaceDark,
          elevation: 2.0,
          centerTitle: true,
          titleTextStyle: GoogleFonts.roboto(
              fontSize: 20, fontWeight: FontWeight.w500, color: onSurfaceDark)),
      cardTheme: CardTheme(
          color: cardDark,
          elevation: 2.0,
          shadowColor: shadowDark,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: surfaceDark,
          selectedItemColor: primaryDark,
          unselectedItemColor: textSecondaryDark,
          type: BottomNavigationBarType.fixed,
          elevation: 4.0),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: secondaryDark,
          foregroundColor: onSecondaryDark,
          elevation: 4.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0))),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              foregroundColor: onPrimaryDark,
              backgroundColor: primaryDark,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              textStyle: GoogleFonts.roboto(
                  fontSize: 16, fontWeight: FontWeight.w500))),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
              foregroundColor: primaryDark,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              side: const BorderSide(color: primaryDark, width: 1.5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              textStyle: GoogleFonts.roboto(
                  fontSize: 16, fontWeight: FontWeight.w500))),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              foregroundColor: primaryDark,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              textStyle: GoogleFonts.roboto(
                  fontSize: 16, fontWeight: FontWeight.w500))),
      textTheme: _buildTextTheme(isLight: false),
      inputDecorationTheme: InputDecorationTheme(
          fillColor: surfaceDark,
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: neutralBorderDark)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: neutralBorderDark)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: primaryDark, width: 2.0)),
          errorBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: const BorderSide(color: errorDark, width: 2.0)),
          focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: const BorderSide(color: errorDark, width: 2.0)),
          labelStyle: GoogleFonts.roboto(color: textSecondaryDark, fontSize: 16),
          hintStyle: GoogleFonts.roboto(color: textSecondaryDark, fontSize: 16),
          prefixIconColor: textSecondaryDark,
          suffixIconColor: textSecondaryDark),
      switchTheme: SwitchThemeData(thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryDark;
        }
        return Colors.grey[600];
      }), trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryDark.withValues(alpha: 0.5);
        }
        return Colors.grey[700];
      })),
      checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return primaryDark;
            }
            return Colors.transparent;
          }),
          checkColor: WidgetStateProperty.all(onPrimaryDark),
          side: const BorderSide(color: neutralBorderDark, width: 2.0)),
      radioTheme: RadioThemeData(fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryDark;
        }
        return textSecondaryDark;
      })),
      progressIndicatorTheme: const ProgressIndicatorThemeData(color: primaryDark, linearTrackColor: neutralBorderDark),
      sliderTheme: SliderThemeData(activeTrackColor: primaryDark, thumbColor: primaryDark, overlayColor: primaryDark.withValues(alpha: 0.2), inactiveTrackColor: neutralBorderDark, trackHeight: 4.0),
      tabBarTheme: TabBarTheme(labelColor: primaryDark, unselectedLabelColor: textSecondaryDark, indicatorColor: primaryDark, indicatorSize: TabBarIndicatorSize.tab, labelStyle: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500), unselectedLabelStyle: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w400)),
      tooltipTheme: TooltipThemeData(decoration: BoxDecoration(color: textPrimaryDark.withValues(alpha: 0.9), borderRadius: BorderRadius.circular(4)), textStyle: GoogleFonts.roboto(color: surfaceDark, fontSize: 14), padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
      snackBarTheme: SnackBarThemeData(backgroundColor: textPrimaryDark, contentTextStyle: GoogleFonts.roboto(color: surfaceDark, fontSize: 16), actionTextColor: secondaryDark, behavior: SnackBarBehavior.floating, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
      listTileTheme: ListTileThemeData(contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)), tileColor: surfaceDark),
      bottomSheetTheme: const BottomSheetThemeData(backgroundColor: surfaceDark, elevation: 4.0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)))),
      dialogTheme: DialogThemeData(backgroundColor: cardDark));

  /// Helper method to build text theme optimized for agricultural equipment management
  static TextTheme _buildTextTheme({required bool isLight}) {
    final Color textHighEmphasis = isLight ? textPrimaryLight : textPrimaryDark;
    final Color textMediumEmphasis =
        isLight ? textSecondaryLight : textSecondaryDark;

    return TextTheme(
        // Display styles for equipment headers
        displayLarge: GoogleFonts.roboto(
            fontSize: 57,
            fontWeight: FontWeight.w400,
            color: textHighEmphasis,
            letterSpacing: -0.25),
        displayMedium: GoogleFonts.roboto(
            fontSize: 45, fontWeight: FontWeight.w400, color: textHighEmphasis),
        displaySmall: GoogleFonts.roboto(
            fontSize: 36, fontWeight: FontWeight.w400, color: textHighEmphasis),

        // Headline styles for equipment names and status
        headlineLarge: GoogleFonts.roboto(
            fontSize: 32, fontWeight: FontWeight.w500, color: textHighEmphasis),
        headlineMedium: GoogleFonts.roboto(
            fontSize: 28, fontWeight: FontWeight.w500, color: textHighEmphasis),
        headlineSmall: GoogleFonts.roboto(
            fontSize: 24, fontWeight: FontWeight.w500, color: textHighEmphasis),

        // Title styles for section headers
        titleLarge: GoogleFonts.roboto(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: textHighEmphasis,
            letterSpacing: 0),
        titleMedium: GoogleFonts.roboto(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: textHighEmphasis,
            letterSpacing: 0.15),
        titleSmall: GoogleFonts.roboto(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: textHighEmphasis,
            letterSpacing: 0.1),

        // Body text for work logs and detailed information
        bodyLarge: GoogleFonts.openSans(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: textHighEmphasis,
            letterSpacing: 0.5),
        bodyMedium: GoogleFonts.openSans(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: textHighEmphasis,
            letterSpacing: 0.25),
        bodySmall: GoogleFonts.openSans(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: textMediumEmphasis,
            letterSpacing: 0.4),

        // Label styles for buttons and captions
        labelLarge: GoogleFonts.roboto(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: textHighEmphasis,
            letterSpacing: 0.1),
        labelMedium: GoogleFonts.roboto(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: textMediumEmphasis,
            letterSpacing: 0.5),
        labelSmall: GoogleFonts.roboto(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: textMediumEmphasis,
            letterSpacing: 0.5));
  }

  /// Custom text styles for data display (costs, specifications)
  static TextStyle dataTextStyle(
      {required bool isLight, double fontSize = 14}) {
    return GoogleFonts.robotoMono(
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
        color: isLight ? textPrimaryLight : textPrimaryDark,
        letterSpacing: 0.25);
  }

  /// Custom text style for monetary values
  static TextStyle currencyTextStyle(
      {required bool isLight, double fontSize = 16}) {
    return GoogleFonts.robotoMono(
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
        color: isLight ? textPrimaryLight : textPrimaryDark,
        letterSpacing: 0.15);
  }

  /// Custom text style for equipment specifications
  static TextStyle specTextStyle(
      {required bool isLight, double fontSize = 12}) {
    return GoogleFonts.robotoMono(
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
        color: isLight ? textSecondaryLight : textSecondaryDark,
        letterSpacing: 0.4);
  }
}
