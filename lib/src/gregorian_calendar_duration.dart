import 'calendar_duration.dart';
import 'gregorian_calendar.dart';
import 'gregorian_consts.dart';

/// Represents a given duration which can be added/subtracted
/// from a [GregorianCalendar] object
class GregorianCalendarDuration implements CalendarDuration<GregorianCalendar>{

  GregorianCalendarDuration({this.days = 0, this.weeks = 0, this.months = 0, this.years = 0});

  /// Constructs a GregorianCalendarDuration where the values have been normalized
  factory GregorianCalendarDuration.normalized({int years = 0, int months = 0, int weeks = 0, int days=0}){
    // normalize values and then call the real constructor
    if (days >= daysPerWeek){
      weeks += days ~/ daysPerWeek;
      days %= daysPerWeek;
    }
    else if (days <= -daysPerWeek){
      weeks += days ~/ daysPerWeek;
      days = -(days.abs() % daysPerWeek);
    }
    if (months >= monthsPerYear){
      years += months ~/ monthsPerYear;
      months %= monthsPerYear;
    }
    else if (months <= -monthsPerYear){
      years += months ~/ monthsPerYear;
      months = -(months.abs() % monthsPerYear);
    }
    return GregorianCalendarDuration(years: years, months: months, weeks: weeks, days: days);
  }

  factory GregorianCalendarDuration.fromDays(int days, GregorianCalendar referenceDate){
    final newReferenceDate = referenceDate.addDays(days);
    return new GregorianCalendarDuration.normalized(
      years: newReferenceDate.year - referenceDate.year,
      months: newReferenceDate.month - referenceDate.month,
      days:  newReferenceDate.day - referenceDate.day
    );
  }

  @override
  final int days;

  @override
  final int weeks;

  @override
  final int months;

  @override
  final int years;

  @override
  GregorianCalendarDuration operator +(CalendarDuration<GregorianCalendar> other){
    return new GregorianCalendarDuration.normalized(
      years: years + other.years,
      months: months + other.months,
      weeks: weeks + other.weeks,
      days: days + other.days,
    );
  }

  @override
  GregorianCalendarDuration operator -(CalendarDuration<GregorianCalendar> other){
    return new GregorianCalendarDuration.normalized(
      years: years - other.years,
      months: months - other.months,
      weeks: weeks - other.weeks,
      days: days - other.days,
    );
  }

  @override
  GregorianCalendarDuration operator -(){
    return new GregorianCalendarDuration(
      years: -years,
      months: -months,
      weeks: -weeks,
      days: -days,
    );
  }

  @override
  int toApproxDays(){
    return ((years * monthsPerYear + months) * avgDaysPerMonth).round() + (weeks * daysPerWeek) + days;
  }

  @override
  bool operator ==(Object other){
    return other is CalendarDuration<GregorianCalendar> 
      && (years * monthsPerYear + months) == (other.years * monthsPerYear + other.months)
      && (weeks * daysPerWeek + days) == (other.weeks * daysPerWeek + other.days);
  }

  @override
  int get hashCode => ((years * monthsPerYear + months) * 1000 + (weeks * daysPerWeek + days)).hashCode;

  @override
  GregorianCalendarDuration normalize(){
    return GregorianCalendarDuration.normalized(
      years: years, 
      months: months, 
      weeks: weeks, 
      days: days
    );
  }

  @override
  GregorianCalendarDuration denormalize(){
    return GregorianCalendarDuration(
      days: days + (weeks * daysPerWeek),
      months: months + (years * monthsPerYear)
    );
  }

  @override
  int toDays(GregorianCalendar referenceDate){
    return referenceDate.daysInCalendarDuration(this);
  }

  @override
  String toString() {
    final StringBuffer buf = new StringBuffer();
    if (years != 0) buf.write(years.abs() == 1 ? '1 year, ' : '$years years, ');
    if (months != 0) buf.write(months.abs() == 1 ? '1 month, ' : '$years months, ');
    if (weeks != 0) buf.write(weeks.abs() == 1 ? '1 week, ' : '$weeks weeks, ');
    if (days != 0) buf.write(days.abs() == 1 ? '1 day, ' : '$days days, ');
    return buf.toString();
  }

  /// Converts to an ISO 8601 formated duration string
  /// 
  /// The string days the following format:
  /// 'PxYxMxWxD' where 'x' represents an integer value for
  /// the number of years/months/weeks/days
  String toIso8601() => 'P${years}Y${months}M${weeks}W${days}D';

}