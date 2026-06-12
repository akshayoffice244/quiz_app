import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi'),
  ];

  /// No description provided for @quiz.
  ///
  /// In en, this message translates to:
  /// **'ewogICJyZXNwb25zZV9jb2RlIjogMCwKICAicmVzdWx0cyI6IFsKICAgIHsKICAgICAgInR5cGUiOiAibXVsdGlwbGUiLAogICAgICAiZGlmZmljdWx0eSI6ICJtZWRpdW0iLAogICAgICAiY2F0ZWdvcnkiOiAiRW50ZXJ0YWlubWVudDogVmlkZW8gR2FtZXMiLAogICAgICAicXVlc3Rpb24iOiAiV2hhdCBlbGVtZW50IGRvZXMgdGhlIFppbm9ncmUgdXNlIGluIE1vbnN0ZXIgSHVudGVyPyIsCiAgICAgICJjb3JyZWN0X2Fuc3dlciI6ICJUaHVuZGVyIiwKICAgICAgImluY29ycmVjdF9hbnN3ZXJzIjogWwogICAgICAgICJJY2UiLAogICAgICAgICJGaXJlIiwKICAgICAgICAiV2F0ZXIiCiAgICAgIF0KICAgIH0sCiAgICB7CiAgICAgICJ0eXBlIjogIm11bHRpcGxlIiwKICAgICAgImRpZmZpY3VsdHkiOiAiaGFyZCIsCiAgICAgICJjYXRlZ29yeSI6ICJFbnRlcnRhaW5tZW50OiBWaWRlbyBHYW1lcyIsCiAgICAgICJxdWVzdGlvbiI6ICJXaGljaCBvZiB0aGVzZSB3ZWFwb24gY2xhc3NlcyBETyBOT1QgYXBwZWFyIGluIHRoZSBmaXJzdCBNb25zdGVyIEh1bnRlciBnYW1lPyIsCiAgICAgICJjb3JyZWN0X2Fuc3dlciI6ICJCb3cgIiwKICAgICAgImluY29ycmVjdF9hbnN3ZXJzIjogWwogICAgICAgICJIYW1tZXIiLAogICAgICAgICJIZWF2eSBCb3dndW4iLAogICAgICAgICJMaWdodCBCb3dndW4iCiAgICAgIF0KICAgIH0sCiAgICB7CiAgICAgICJ0eXBlIjogIm11bHRpcGxlIiwKICAgICAgImRpZmZpY3VsdHkiOiAibWVkaXVtIiwKICAgICAgImNhdGVnb3J5IjogIkVudGVydGFpbm1lbnQ6IEZpbG0iLAogICAgICAicXVlc3Rpb24iOiAiV2hhdCB3ZXJlIHRoZSBDaGlsbGVkIE1vbmtleSBCcmFpbnMgbWFkZSBmcm9tIGR1cmluZyBJbmRpYW5hIEpvbmVzIGFuZCB0aGUgVGVtcGxlIG9mIERvb20/IiwKICAgICAgImNvcnJlY3RfYW5zd2VyIjogIkN1c3RhcmQgYW5kIFJhc3BiZXJyeSBTYXVjZSIsCiAgICAgICJpbmNvcnJlY3RfYW5zd2VycyI6IFsKICAgICAgICAiU3RyYXdiZXJyeSBJY2UgQ3JlYW0iLAogICAgICAgICJDaGVycnkgWW9ndXJ0IiwKICAgICAgICAiUmFzcGJlcnJ5IFNvcmJldCIKICAgICAgXQogICAgfSwKICAgIHsKICAgICAgInR5cGUiOiAibXVsdGlwbGUiLAogICAgICAiZGlmZmljdWx0eSI6ICJtZWRpdW0iLAogICAgICAiY2F0ZWdvcnkiOiAiRW50ZXJ0YWlubWVudDogTXVzaWMiLAogICAgICAicXVlc3Rpb24iOiAiSG93IG1hbnkgc3R1ZGlvIGFsYnVtcyBoYXZlIHRoZSBoZWF2eSBtZXRhbCBiYW5kLCAmIzAzOTtNZXRhbGxpY2EmIzAzOTsgcmVsZWFzZWQgaW4gdGhlIHBlcmlvZCBiZXR3ZWVuIDE5ODMgYW5kIDIwMTY/IiwKICAgICAgImNvcnJlY3RfYW5zd2VyIjogIjEwIiwKICAgICAgImluY29ycmVjdF9hbnN3ZXJzIjogWwogICAgICAgICI3IiwKICAgICAgICAiOSIsCiAgICAgICAgIjEyIgogICAgICBdCiAgICB9LAogICAgewogICAgICAidHlwZSI6ICJib29sZWFuIiwKICAgICAgImRpZmZpY3VsdHkiOiAiZWFzeSIsCiAgICAgICJjYXRlZ29yeSI6ICJTY2llbmNlICZhbXA7IE5hdHVyZSIsCiAgICAgICJxdWVzdGlvbiI6ICJBbiBhdG9tIGNvbnRhaW5zIGEgbnVjbGV1cy4iLAogICAgICAiY29ycmVjdF9hbnN3ZXIiOiAiVHJ1ZSIsCiAgICAgICJpbmNvcnJlY3RfYW5zd2VycyI6IFsKICAgICAgICAiRmFsc2UiCiAgICAgIF0KICAgIH0sCiAgICB7CiAgICAgICJ0eXBlIjogIm11bHRpcGxlIiwKICAgICAgImRpZmZpY3VsdHkiOiAiaGFyZCIsCiAgICAgICJjYXRlZ29yeSI6ICJTY2llbmNlICZhbXA7IE5hdHVyZSIsCiAgICAgICJxdWVzdGlvbiI6ICJXaGljaCBvZiB0aGVzZSBpcyBhIHN0b3AgY29kb24gaW4gRE5BPyIsCiAgICAgICJjb3JyZWN0X2Fuc3dlciI6ICJUQUEiLAogICAgICAiaW5jb3JyZWN0X2Fuc3dlcnMiOiBbCiAgICAgICAgIkFDVCIsCiAgICAgICAgIkFDQSIsCiAgICAgICAgIkdUQSIKICAgICAgXQogICAgfSwKICAgIHsKICAgICAgInR5cGUiOiAibXVsdGlwbGUiLAogICAgICAiZGlmZmljdWx0eSI6ICJtZWRpdW0iLAogICAgICAiY2F0ZWdvcnkiOiAiU3BvcnRzIiwKICAgICAgInF1ZXN0aW9uIjogIldoaWNoIGNvdW50cnkgZGlkIEthYmFkZGksIGEgY29udGFjdCBzcG9ydCBpbnZvbHZpbmcgdGFja2xpbmcsIG9yaWdpbmF0ZSBmcm9tPyIsCiAgICAgICJjb3JyZWN0X2Fuc3dlciI6ICJJbmRpYSIsCiAgICAgICJpbmNvcnJlY3RfYW5zd2VycyI6IFsKICAgICAgICAiQXVzdHJhbGlhIiwKICAgICAgICAiVHVya2V5IiwKICAgICAgICAiQ2FtYm9kaWEiCiAgICAgIF0KICAgIH0sCiAgICB7CiAgICAgICJ0eXBlIjogIm11bHRpcGxlIiwKICAgICAgImRpZmZpY3VsdHkiOiAibWVkaXVtIiwKICAgICAgImNhdGVnb3J5IjogIlBvbGl0aWNzIiwKICAgICAgInF1ZXN0aW9uIjogIlRoZSAyMDE0IG1vdmllICZxdW90O1RoZSBSYWlkIDI6IEJlcmFuZGFsJnF1b3Q7IHdhcyBtYWlubHkgZmlsbWVkIGluIHdoaWNoIEFzaWFuIGNvdW50cnk/IiwKICAgICAgImNvcnJlY3RfYW5zd2VyIjogIkluZG9uZXNpYSIsCiAgICAgICJpbmNvcnJlY3RfYW5zd2VycyI6IFsKICAgICAgICAiVGhhaWxhbmQiLAogICAgICAgICJCcnVuZWkiLAogICAgICAgICJNYWxheXNpYSIKICAgICAgXQogICAgfSwKICAgIHsKICAgICAgInR5cGUiOiAibXVsdGlwbGUiLAogICAgICAiZGlmZmljdWx0eSI6ICJtZWRpdW0iLAogICAgICAiY2F0ZWdvcnkiOiAiRW50ZXJ0YWlubWVudDogQ29taWNzIiwKICAgICAgInF1ZXN0aW9uIjogIkluIHRoZSBIZWxsYm95IHVuaXZlcnNlLCB3aG8gZm91bmRlZCB0aGUgQlBSRD8iLAogICAgICAiY29ycmVjdF9hbnN3ZXIiOiAiVHJldm9yIEJydXR0ZW5ob2xtIiwKICAgICAgImluY29ycmVjdF9hbnN3ZXJzIjogWwogICAgICAgICJLYXRlIENvcnJpZ2FuIiwKICAgICAgICAiSm9oYW5uIEtyYXVzIiwKICAgICAgICAiQmVuamFtaW4gRGFpbWlvIgogICAgICBdCiAgICB9LAogICAgewogICAgICAidHlwZSI6ICJtdWx0aXBsZSIsCiAgICAgICJkaWZmaWN1bHR5IjogIm1lZGl1bSIsCiAgICAgICJjYXRlZ29yeSI6ICJFbnRlcnRhaW5tZW50OiBWaWRlbyBHYW1lcyIsCiAgICAgICJxdWVzdGlvbiI6ICJGaW5hbCBGYW50YXN5IFZJIHdhcyBvcmlnaW5hbGx5IHJlbGVhc2VkIG91dHNpZGUgSmFwYW4gdW5kZXIgd2hhdCBuYW1lPyIsCiAgICAgICJjb3JyZWN0X2Fuc3dlciI6ICJGaW5hbCBGYW50YXN5IElJSSIsCiAgICAgICJpbmNvcnJlY3RfYW5zd2VycyI6IFsKICAgICAgICAiRmluYWwgRmFudGFzeSBWSSIsCiAgICAgICAgIkZpbmFsIEZhbnRhc3kgViIsCiAgICAgICAgIkZpbmFsIEZhbnRhc3kgSUkiCiAgICAgIF0KICAgIH0KICBdCn0='**
  String get quiz;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'hi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
