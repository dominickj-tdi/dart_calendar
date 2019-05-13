import './calendar.dart';
import './calendar_duration.dart';
import './calendar_iterators.dart';

/// Represents a specific interval on the calendar,
/// with a start date, end date, and duration
class CalendarInterval<TCal extends Calendar>{

  CalendarInterval({this.start, this.end, CalendarDuration<TCal> duration}){
    if (start == null && end != null && duration != null){
      // end and duration
      start = end.addCalendarDuration(-duration);
    }
    else if (start != null && end == null && duration != null){
      // start and duration
      end = start.addCalendarDuration(duration);
    }
    else if (start != null && end != null && duration == null){
      // start and end. Do nothing
    }
    else{
      // Invalid configuration
      throw ArgumentError('You must supply exactly 2 of the 3 arguments to CalendarInterval');
    }

    if (start > end){
      // swap start and end if start is after end
      final tmp = start;
      start = end;
      end = tmp;
    }
  }

  TCal start;
  TCal end;

  /// Distance between start and end dates.
  /// 
  /// If this is set, it will adjust the end 
  /// date, not the start date, to match the new 
  /// duration.
  CalendarDuration<TCal> get duration => start.calculateDurationToDate(end);
  set duration(CalendarDuration<TCal> dur) => end = start.addCalendarDuration(dur);

  /// Iterable of all years in this interval
  YearRange<TCal> get iterYears => YearRange<TCal>(start, end);

  /// Iterable of all months in this interval
  MonthRange<TCal> get iterMonths => MonthRange<TCal>(start, end);

  /// Iterable of all weeks in this interval
  WeekRange<TCal> get iterWeeks => WeekRange<TCal>(start, end);

  /// Iterable of all years in this interval
  DayRange<TCal> get iterDays => DayRange<TCal>(start, end);

  /// Counts the number of days in this interval
  int get countDays => duration.toDays(start);
}