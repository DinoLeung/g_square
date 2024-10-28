class TimeEncoder {
  static List<int> prepareCurrentTime(DateTime date) {
    List<int> arr = List.filled(10, 0);

    int year = date.year;
    arr[0] = (year & 0xff)
        .toSigned(8); // Lower byte of the year, converted to signed byte
    arr[1] = (year >> 8 & 0xff)
        .toSigned(8); // Higher byte of the year, converted to signed byte
    arr[2] = date.month; // Month (1-12)
    arr[3] = date.day; // Day of the month (1-31)
    arr[4] = date.hour; // Hour of the day (0-23)
    arr[5] = date.minute; // Minute of the hour (0-59)
    arr[6] = date.second; // Second of the minute (0-59)
    arr[7] = date.weekday; // Day of the week (1-7, Monday is 1)
    arr[8] = (date.millisecond ~/ 1)
        .toSigned(8); // Milliseconds (0-999), converted to fit in a single byte
    arr[9] =
        1; // Extra byte, hardcoded to 1 (could be a flag or similar)
    // I think arr[9] is an extra bit to represent 0-999, since a single 8bit signed only have 256 numbers
    // It could be arr[8] = milliseconds%256 and arr[8] = milliseconds/256

    return arr;
  }
}
