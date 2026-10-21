// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get feed => 'FEED';

  @override
  String get water => 'WATER';

  @override
  String get wash => 'WASH';

  @override
  String get play => 'PLAY';

  @override
  String get outfit => 'OUTFIT';

  @override
  String get shop => 'SHOP';

  @override
  String get hello => 'hello!';

  @override
  String get confirmPal => 'CONFIRM PAL';

  @override
  String get chooseYourPal => 'CHOOSE YOUR PAL';

  @override
  String get saveClose => 'SAVE & CLOSE';

  @override
  String get top => 'Top';

  @override
  String get bottom => 'Bottom';

  @override
  String get none => 'None';

  @override
  String get noTopsOwned => 'No tops owned yet.\nVisit the shop!';

  @override
  String get noBottomsOwned => 'No bottoms owned yet.\nVisit the shop!';

  @override
  String get health => 'Health';

  @override
  String get closeness => 'Closeness';

  @override
  String get continueGame => 'CONTINUE GAME';

  @override
  String get start => 'START';

  @override
  String get loading => 'LOADING PAL...';

  @override
  String get settings => 'SETTINGS & NOTIFICATIONS';

  @override
  String get appSettings => 'APP SETTINGS';

  @override
  String get language => 'Language / Idioma';

  @override
  String get fontSize => 'Font Size';

  @override
  String get brightness => 'Screen Brightness';

  @override
  String get petRoutineTimers => 'PET ROUTINE TIMERS';

  @override
  String get setMealTime => 'Set Meal Time';

  @override
  String get setSleepTime => 'Set Sleeping Time';

  @override
  String get setWakeTime => 'Set Wake Up Time';

  @override
  String get notifications => 'NOTIFICATIONS';

  @override
  String get careReminders => 'Care Reminders';

  @override
  String get careRemindersDesc => 'Send a care reminder notification';

  @override
  String get petMessage => 'Pet Message';

  @override
  String get petMessageDesc => 'Send a pet status notification';

  @override
  String get sleepAlert => 'Sleep Schedule Alert';

  @override
  String get sleepAlertDesc => 'Send a bedtime notification';

  @override
  String get test => 'TEST';

  @override
  String get buyButton => 'Buy';

  @override
  String get food => 'Food';

  @override
  String get toy => 'Toy';

  @override
  String get noFood => 'No food!( ;´ - `;) Please visit the shop.';

  @override
  String get noToy => 'No toy!( ;´ - `;) Please visit the shop.';

  @override
  String letsFeed(String name) {
    return 'Let\'s feed $name!';
  }

  @override
  String letsPlay(String name) {
    return 'Let\'s Play with $name!';
  }

  @override
  String get dialogueWater =>
      'Thank you!(˶>⩊<˶) Have you drunk your water yet?';

  @override
  String get dialogueWash => 'Please scrub the bubbles off my body\n(ㅅ´ ˘ `)';

  @override
  String get dialogueFed => 'Yummy!';

  @override
  String get dialoguePlayed => 'This is so fun!';

  @override
  String get dialogueClean => 'I am so clean now!\n٩(^ᗜ^ )و ';

  @override
  String dialogueBought(String item) {
    return 'Successfully bought $item!';
  }

  @override
  String get dialogueNoCoins => 'No coins! ( ;´ - `;) Go play with your pet!';

  @override
  String get notificationsSimulator => 'NOTIFICATIONS SIMULATOR';

  @override
  String get careRemindersSimDesc => 'Simulate alerts to feed, wash, or play';

  @override
  String get petMessageStatuses => 'Pet Message Statuses';

  @override
  String get petMessageSimDesc =>
      'Simulate hungry/thirsty/bored text box updates';

  @override
  String get sleepAlertTitle => 'Sleep Schedule Alerts';

  @override
  String get sleepAlertSimDesc =>
      'Simulate bedtime notification target triggers';

  @override
  String get snackCareReminder =>
      'Reminder: Remember to feed, wash, and play with your pal!';

  @override
  String get snackPetMessage =>
      'Message Box: \"I\'m lonely and my tummy is rumbling!\"';

  @override
  String snackBedtime(String time) {
    return 'Bedtime Alert: It is $time. Time for your pal to go to sleep!';
  }
}
