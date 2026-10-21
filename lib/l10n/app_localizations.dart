import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_zh.dart';

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
    Locale('es'),
    Locale('zh'),
    Locale('zh', 'TW'),
  ];

  /// No description provided for @feed.
  ///
  /// In en, this message translates to:
  /// **'FEED'**
  String get feed;

  /// No description provided for @water.
  ///
  /// In en, this message translates to:
  /// **'WATER'**
  String get water;

  /// No description provided for @wash.
  ///
  /// In en, this message translates to:
  /// **'WASH'**
  String get wash;

  /// No description provided for @play.
  ///
  /// In en, this message translates to:
  /// **'PLAY'**
  String get play;

  /// No description provided for @outfit.
  ///
  /// In en, this message translates to:
  /// **'OUTFIT'**
  String get outfit;

  /// No description provided for @shop.
  ///
  /// In en, this message translates to:
  /// **'SHOP'**
  String get shop;

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'hello!'**
  String get hello;

  /// No description provided for @confirmPal.
  ///
  /// In en, this message translates to:
  /// **'CONFIRM PAL'**
  String get confirmPal;

  /// No description provided for @chooseYourPal.
  ///
  /// In en, this message translates to:
  /// **'CHOOSE YOUR PAL'**
  String get chooseYourPal;

  /// No description provided for @saveClose.
  ///
  /// In en, this message translates to:
  /// **'SAVE & CLOSE'**
  String get saveClose;

  /// No description provided for @top.
  ///
  /// In en, this message translates to:
  /// **'Top'**
  String get top;

  /// No description provided for @bottom.
  ///
  /// In en, this message translates to:
  /// **'Bottom'**
  String get bottom;

  /// No description provided for @none.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get none;

  /// No description provided for @noTopsOwned.
  ///
  /// In en, this message translates to:
  /// **'No tops owned yet.\nVisit the shop!'**
  String get noTopsOwned;

  /// No description provided for @noBottomsOwned.
  ///
  /// In en, this message translates to:
  /// **'No bottoms owned yet.\nVisit the shop!'**
  String get noBottomsOwned;

  /// No description provided for @health.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get health;

  /// No description provided for @closeness.
  ///
  /// In en, this message translates to:
  /// **'Closeness'**
  String get closeness;

  /// No description provided for @continueGame.
  ///
  /// In en, this message translates to:
  /// **'CONTINUE GAME'**
  String get continueGame;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'START'**
  String get start;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'LOADING PAL...'**
  String get loading;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'SETTINGS & NOTIFICATIONS'**
  String get settings;

  /// No description provided for @appSettings.
  ///
  /// In en, this message translates to:
  /// **'APP SETTINGS'**
  String get appSettings;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language / Idioma'**
  String get language;

  /// No description provided for @fontSize.
  ///
  /// In en, this message translates to:
  /// **'Font Size'**
  String get fontSize;

  /// No description provided for @brightness.
  ///
  /// In en, this message translates to:
  /// **'Screen Brightness'**
  String get brightness;

  /// No description provided for @petRoutineTimers.
  ///
  /// In en, this message translates to:
  /// **'PET ROUTINE TIMERS'**
  String get petRoutineTimers;

  /// No description provided for @setMealTime.
  ///
  /// In en, this message translates to:
  /// **'Set Meal Time'**
  String get setMealTime;

  /// No description provided for @setSleepTime.
  ///
  /// In en, this message translates to:
  /// **'Set Sleeping Time'**
  String get setSleepTime;

  /// No description provided for @setWakeTime.
  ///
  /// In en, this message translates to:
  /// **'Set Wake Up Time'**
  String get setWakeTime;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'NOTIFICATIONS'**
  String get notifications;

  /// No description provided for @careReminders.
  ///
  /// In en, this message translates to:
  /// **'Care Reminders'**
  String get careReminders;

  /// No description provided for @careRemindersDesc.
  ///
  /// In en, this message translates to:
  /// **'Send a care reminder notification'**
  String get careRemindersDesc;

  /// No description provided for @petMessage.
  ///
  /// In en, this message translates to:
  /// **'Pet Message'**
  String get petMessage;

  /// No description provided for @petMessageDesc.
  ///
  /// In en, this message translates to:
  /// **'Send a pet status notification'**
  String get petMessageDesc;

  /// No description provided for @sleepAlert.
  ///
  /// In en, this message translates to:
  /// **'Sleep Schedule Alert'**
  String get sleepAlert;

  /// No description provided for @sleepAlertDesc.
  ///
  /// In en, this message translates to:
  /// **'Send a bedtime notification'**
  String get sleepAlertDesc;

  /// No description provided for @test.
  ///
  /// In en, this message translates to:
  /// **'TEST'**
  String get test;

  /// No description provided for @buyButton.
  ///
  /// In en, this message translates to:
  /// **'Buy'**
  String get buyButton;

  /// No description provided for @food.
  ///
  /// In en, this message translates to:
  /// **'Food'**
  String get food;

  /// No description provided for @toy.
  ///
  /// In en, this message translates to:
  /// **'Toy'**
  String get toy;

  /// No description provided for @noFood.
  ///
  /// In en, this message translates to:
  /// **'No food!( ;´ - `;) Please visit the shop.'**
  String get noFood;

  /// No description provided for @noToy.
  ///
  /// In en, this message translates to:
  /// **'No toy!( ;´ - `;) Please visit the shop.'**
  String get noToy;

  /// No description provided for @letsFeed.
  ///
  /// In en, this message translates to:
  /// **'Let\'s feed {name}!'**
  String letsFeed(String name);

  /// No description provided for @letsPlay.
  ///
  /// In en, this message translates to:
  /// **'Let\'s Play with {name}!'**
  String letsPlay(String name);

  /// No description provided for @dialogueWater.
  ///
  /// In en, this message translates to:
  /// **'Thank you!(˶>⩊<˶) Have you drunk your water yet?'**
  String get dialogueWater;

  /// No description provided for @dialogueWash.
  ///
  /// In en, this message translates to:
  /// **'Please scrub the bubbles off my body\n(ㅅ´ ˘ `)'**
  String get dialogueWash;

  /// No description provided for @dialogueFed.
  ///
  /// In en, this message translates to:
  /// **'Yummy!'**
  String get dialogueFed;

  /// No description provided for @dialoguePlayed.
  ///
  /// In en, this message translates to:
  /// **'This is so fun!'**
  String get dialoguePlayed;

  /// No description provided for @dialogueClean.
  ///
  /// In en, this message translates to:
  /// **'I am so clean now!\n٩(^ᗜ^ )و '**
  String get dialogueClean;

  /// No description provided for @dialogueBought.
  ///
  /// In en, this message translates to:
  /// **'Successfully bought {item}!'**
  String dialogueBought(String item);

  /// No description provided for @dialogueNoCoins.
  ///
  /// In en, this message translates to:
  /// **'No coins! ( ;´ - `;) Go play with your pet!'**
  String get dialogueNoCoins;

  /// No description provided for @notificationsSimulator.
  ///
  /// In en, this message translates to:
  /// **'NOTIFICATIONS SIMULATOR'**
  String get notificationsSimulator;

  /// No description provided for @careRemindersSimDesc.
  ///
  /// In en, this message translates to:
  /// **'Simulate alerts to feed, wash, or play'**
  String get careRemindersSimDesc;

  /// No description provided for @petMessageStatuses.
  ///
  /// In en, this message translates to:
  /// **'Pet Message Statuses'**
  String get petMessageStatuses;

  /// No description provided for @petMessageSimDesc.
  ///
  /// In en, this message translates to:
  /// **'Simulate hungry/thirsty/bored text box updates'**
  String get petMessageSimDesc;

  /// No description provided for @sleepAlertTitle.
  ///
  /// In en, this message translates to:
  /// **'Sleep Schedule Alerts'**
  String get sleepAlertTitle;

  /// No description provided for @sleepAlertSimDesc.
  ///
  /// In en, this message translates to:
  /// **'Simulate bedtime notification target triggers'**
  String get sleepAlertSimDesc;

  /// No description provided for @snackCareReminder.
  ///
  /// In en, this message translates to:
  /// **'Reminder: Remember to feed, wash, and play with your pal!'**
  String get snackCareReminder;

  /// No description provided for @snackPetMessage.
  ///
  /// In en, this message translates to:
  /// **'Message Box: \"I\'m lonely and my tummy is rumbling!\"'**
  String get snackPetMessage;

  /// No description provided for @snackBedtime.
  ///
  /// In en, this message translates to:
  /// **'Bedtime Alert: It is {time}. Time for your pal to go to sleep!'**
  String snackBedtime(String time);
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
      <String>['en', 'es', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'zh':
      {
        switch (locale.countryCode) {
          case 'TW':
            return AppLocalizationsZhTw();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
