import './gregorian_calendar.dart';
import './calendar_interval.dart';

/// Alias for CalendarInterval<GregorianCalendar>
/// 
/// Adds no additional functionality to [CalendarInterval],
/// but saves a few keystrokes to type out, and fits
/// with the common naming pattern used in this library.
class GregorianCalendarInterval extends CalendarInterval<GregorianCalendar>{

}