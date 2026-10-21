// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get feed => 'ALIMENTAR';

  @override
  String get water => 'AGUA';

  @override
  String get wash => 'LAVAR';

  @override
  String get play => 'JUGAR';

  @override
  String get outfit => 'ROPA';

  @override
  String get shop => 'TIENDA';

  @override
  String get hello => '¡hola!';

  @override
  String get confirmPal => 'CONFIRMAR AMIGO';

  @override
  String get chooseYourPal => 'ELIGE TU AMIGO';

  @override
  String get saveClose => 'GUARDAR Y CERRAR';

  @override
  String get top => 'Camiseta';

  @override
  String get bottom => 'Pantalón';

  @override
  String get none => 'Ninguno';

  @override
  String get noTopsOwned => 'Sin camisetas.\n¡Visita la tienda!';

  @override
  String get noBottomsOwned => 'Sin pantalones.\n¡Visita la tienda!';

  @override
  String get health => 'Salud';

  @override
  String get closeness => 'Cercanía';

  @override
  String get continueGame => 'CONTINUAR';

  @override
  String get start => 'EMPEZAR';

  @override
  String get loading => 'CARGANDO...';

  @override
  String get settings => 'AJUSTES Y NOTIFICACIONES';

  @override
  String get appSettings => 'AJUSTES';

  @override
  String get language => 'Idioma / Language';

  @override
  String get fontSize => 'Tamaño de fuente';

  @override
  String get brightness => 'Brillo de pantalla';

  @override
  String get petRoutineTimers => 'RUTINA DE LA MASCOTA';

  @override
  String get setMealTime => 'Hora de comida';

  @override
  String get setSleepTime => 'Hora de dormir';

  @override
  String get setWakeTime => 'Hora de despertar';

  @override
  String get notifications => 'NOTIFICACIONES';

  @override
  String get careReminders => 'Recordatorios de cuidado';

  @override
  String get careRemindersDesc => 'Enviar notificación de cuidado';

  @override
  String get petMessage => 'Mensaje de mascota';

  @override
  String get petMessageDesc => 'Enviar notificación de estado';

  @override
  String get sleepAlert => 'Alerta de horario de sueño';

  @override
  String get sleepAlertDesc => 'Enviar notificación de hora de dormir';

  @override
  String get test => 'PRUEBA';

  @override
  String get buyButton => 'Comprar';

  @override
  String get food => 'Comida';

  @override
  String get toy => 'Juguete';

  @override
  String get noFood => '¡Sin comida! Visita la tienda.';

  @override
  String get noToy => '¡Sin juguetes! Visita la tienda.';

  @override
  String letsFeed(String name) {
    return '¡Vamos a alimentar a $name!';
  }

  @override
  String letsPlay(String name) {
    return '¡Vamos a jugar con $name!';
  }

  @override
  String get dialogueWater => '¡Gracias!(˶>⩊<˶) ¿Ya tomaste tu agua hoy?';

  @override
  String get dialogueWash =>
      'Por favor frótame las burbujas del cuerpo\n(ㅅ´ ˘ `)';

  @override
  String get dialogueFed => '¡Qué rico!';

  @override
  String get dialoguePlayed => '¡Esto es muy divertido!';

  @override
  String get dialogueClean => '¡Ahora estoy muy limpio!\n٩(^ᗜ^ )و ';

  @override
  String dialogueBought(String item) {
    return '¡Compraste $item con éxito!';
  }

  @override
  String get dialogueNoCoins =>
      '¡Sin monedas! ( ;´ - `;) ¡Ve a jugar con tu mascota!';

  @override
  String get notificationsSimulator => 'SIMULADOR DE NOTIFICACIONES';

  @override
  String get careRemindersSimDesc =>
      'Simular alertas para alimentar, lavar o jugar';

  @override
  String get petMessageStatuses => 'Estados de mensajes de mascota';

  @override
  String get petMessageSimDesc =>
      'Simular actualizaciones de estado hambriento/sediento/aburrido';

  @override
  String get sleepAlertTitle => 'Alertas de horario de sueño';

  @override
  String get sleepAlertSimDesc =>
      'Simular activadores de notificación de hora de dormir';

  @override
  String get snackCareReminder =>
      'Recordatorio: ¡Recuerda alimentar, lavar y jugar con tu amigo!';

  @override
  String get snackPetMessage =>
      'Mensaje: \"¡Me siento solo y mi barriga está rugiendo!\"';

  @override
  String snackBedtime(String time) {
    return 'Alerta de sueño: Son las $time. ¡Es hora de que tu amigo duerma!';
  }
}
