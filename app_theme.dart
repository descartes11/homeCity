// MaCité — design tokens (référence issue des maquettes HTML).
// À adapter à l'architecture du projet Flutter. Material 3.
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Rôles
  static const primary = Color(0xFF4F46E5);       // indigo
  static const primaryHover = Color(0xFF4338CA);
  static const primaryPressed = Color(0xFF3730A3);
  static const primaryContainer = Color(0xFFE0E7FF);
  static const primarySurface = Color(0xFFEEF2FF);
  static const secondary = Color(0xFFF59E0B);     // ambre
  static const background = Color(0xFFF8FAFC);
  static const surface = Color(0xFFFFFFFF);
  static const textPrimary = Color(0xFF0F172A);
  static const textSecondary = Color(0xFF64748B);
  static const textBody = Color(0xFF475569);
  static const border = Color(0xFFE2E8F0);
  static const divider = Color(0xFFF1F5F9);
  // Retours
  static const success = Color(0xFF10B981), successBg = Color(0xFFD1FAE5), successText = Color(0xFF047857);
  static const error = Color(0xFFEF4444), errorBg = Color(0xFFFEE2E2), errorText = Color(0xFFB91C1C);
  static const warning = Color(0xFFF59E0B), warningBg = Color(0xFFFEF3C7), warningText = Color(0xFFB45309);
  static const info = Color(0xFF3B82F6), infoBg = Color(0xFFDBEAFE), infoText = Color(0xFF1D4ED8);
  // Statuts des chambres : (fond, bordure, texte)
  static const roomFree = [Color(0xFFD1FAE5), Color(0xFF10B981), Color(0xFF065F46)];
  static const roomOccupied = [Color(0xFFE0E7FF), Color(0xFF4F46E5), Color(0xFF3730A3)];
  static const roomWorks = [Color(0xFFF1F5F9), Color(0xFF94A3B8), Color(0xFF334155)];
  static const roomLate = [Color(0xFFFEE2E2), Color(0xFFEF4444), Color(0xFF991B1B)];
  // Mode sombre
  static const darkBackground = Color(0xFF0F172A);
  static const darkSurface = Color(0xFF1E293B);
  static const darkBorder = Color(0xFF334155);
  static const darkText = Color(0xFFF1F5F9);
  static const darkTextSecondary = Color(0xFF94A3B8);
  static const darkPrimary = Color(0xFF818CF8);
  static const darkPrimaryContainer = Color(0xFF312E81);
}

class AppSpacing { static const xs = 8.0, sm = 16.0, md = 24.0, lg = 32.0; }
class AppRadius { static const button = 12.0, field = 12.0, card = 16.0, modal = 24.0, pill = 999.0; }

class AppShadows {
  static const card = [BoxShadow(color: Color(0x0F0F172A), blurRadius: 2, offset: Offset(0, 1))];
  static const hover = [BoxShadow(color: Color(0x140F172A), blurRadius: 12, offset: Offset(0, 4))];
  static const modal = [BoxShadow(color: Color(0x240F172A), blurRadius: 32, offset: Offset(0, 12))];
}

TextTheme appTextTheme(Color c) => GoogleFonts.plusJakartaSansTextTheme().copyWith(
  displaySmall: GoogleFonts.plusJakartaSans(fontSize: 32, fontWeight: FontWeight.w700, color: c), // chiffres clés
  headlineMedium: GoogleFonts.plusJakartaSans(fontSize: 28, fontWeight: FontWeight.w700, color: c), // titre d'écran
  titleLarge: GoogleFonts.plusJakartaSans(fontSize: 20, fontWeight: FontWeight.w600, color: c),    // titre de section
  bodyLarge: GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.w400, height: 1.5, color: c),
  labelLarge: GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.w600, color: c),    // boutons
  labelMedium: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w500, color: c),   // petit texte
);

ThemeData appTheme({bool dark = false}) {
  final scheme = ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    brightness: dark ? Brightness.dark : Brightness.light,
  ).copyWith(
    primary: dark ? AppColors.darkPrimary : AppColors.primary,
    onPrimary: dark ? AppColors.textPrimary : Colors.white,
    secondary: AppColors.secondary,
    surface: dark ? AppColors.darkSurface : AppColors.surface,
    onSurface: dark ? AppColors.darkText : AppColors.textPrimary,
    onSurfaceVariant: dark ? AppColors.darkTextSecondary : AppColors.textSecondary,
    outlineVariant: dark ? AppColors.darkBorder : AppColors.border,
    error: AppColors.error,
  );
  final btnShape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.button));
  const minSize = Size(64, 48);
  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: dark ? AppColors.darkBackground : AppColors.background,
    textTheme: appTextTheme(scheme.onSurface),
    filledButtonTheme: FilledButtonThemeData(style: FilledButton.styleFrom(minimumSize: minSize, shape: btnShape, textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600))),
    outlinedButtonTheme: OutlinedButtonThemeData(style: OutlinedButton.styleFrom(minimumSize: minSize, shape: btnShape, side: const BorderSide(color: Color(0xFFC7D2FE)), textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600))),
    textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(minimumSize: minSize, shape: btnShape)),
    cardTheme: CardThemeData(elevation: 0, color: scheme.surface, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.card)), margin: EdgeInsets.zero),
    dialogTheme: DialogThemeData(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.modal))),
    bottomSheetTheme: const BottomSheetThemeData(shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.modal)))),
    inputDecorationTheme: InputDecorationTheme(
      filled: true, fillColor: scheme.surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppRadius.field), borderSide: BorderSide(color: scheme.outlineVariant)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppRadius.field), borderSide: BorderSide(color: scheme.outlineVariant)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppRadius.field), borderSide: BorderSide(color: scheme.primary, width: 2)),
      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppRadius.field), borderSide: const BorderSide(color: AppColors.error, width: 2)),
    ),
    navigationBarTheme: NavigationBarThemeData(height: 80, indicatorColor: dark ? AppColors.darkPrimaryContainer : AppColors.primaryContainer, backgroundColor: scheme.surface),
    chipTheme: ChipThemeData(shape: const StadiumBorder(), selectedColor: AppColors.primaryContainer),
  );
}

/// Montants : toujours « 45 000 FCFA » (espace insécable comme séparateur de milliers).
String formatFcfa(int amount) {
  final s = amount.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (_) => '\u00A0');
  return '$s\u00A0FCFA';
}
