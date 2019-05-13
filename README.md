# Dart Calendar

A Calendar interface with a Gregorian Calendar implementation in Dart. Interfaces are open for other calendar implementations as well, however this functionality is not currently implemented or planned.

This is a fork of Dan Field's [dart_calendar](https://github.com/dnfield/dart_calendar) library which contains added functionality in the form of Durations.

Treats whole days as the smallest unit of time; takes into account leap years.

Currently does not allow BC dates (negative dates).

Gregorian implementation does not help you currently with historical dates of when the Gregorian calendar was adapted (e.g. if you want the local date in Denmark before the 1700s, you'll need to switch to Julian, and that's not handled here currently).