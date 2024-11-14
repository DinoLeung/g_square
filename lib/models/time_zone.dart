class TimeZoneData {
  final String cityName;
  final int identifierA;
  final int identifierB;
  final int offset;
  final int dstOffset;
  final int dstRules;

  const TimeZoneData({
    required this.cityName,
    required this.identifierA,
    required this.identifierB,
    required this.offset,
    required this.dstOffset,
    required this.dstRules,
  });
}

enum TimeZone {
  bakerIsland(TimeZoneData(
      cityName: 'BAKER ISLAND',
      identifierA: 0x39,
      identifierB: 0x01,
      offset: 0xD0,
      dstOffset: 0x04,
      dstRules: 0x00)),
  pagoPago(TimeZoneData(
      cityName: 'PAGO PAGO',
      identifierA: 0xD7,
      identifierB: 0x00,
      offset: 0xD4,
      dstOffset: 0x04,
      dstRules: 0x00)),
  honolulu(TimeZoneData(
      cityName: 'HONOLULU',
      identifierA: 0x7B,
      identifierB: 0x00,
      offset: 0xD8,
      dstOffset: 0x04,
      dstRules: 0x00)),
  marquesasIslands(TimeZoneData(
      cityName: 'MARQUESAS ISLANDS',
      identifierA: 0x3A,
      identifierB: 0x01,
      offset: 0xDA,
      dstOffset: 0x04,
      dstRules: 0x00)),
  anchorage(TimeZoneData(
      cityName: 'ANCHORAGE',
      identifierA: 0x0C,
      identifierB: 0x00,
      offset: 0xDC,
      dstOffset: 0x04,
      dstRules: 0x01)),
  losAngeles(TimeZoneData(
      cityName: 'LOS ANGELES',
      identifierA: 0xA1,
      identifierB: 0x00,
      offset: 0xE0,
      dstOffset: 0x04,
      dstRules: 0x01)),
  denver(TimeZoneData(
      cityName: 'DENVER',
      identifierA: 0x54,
      identifierB: 0x00,
      offset: 0xE4,
      dstOffset: 0x04,
      dstRules: 0x01)),
  chicago(TimeZoneData(
      cityName: 'CHICAGO',
      identifierA: 0x42,
      identifierB: 0x00,
      offset: 0xE8,
      dstOffset: 0x04,
      dstRules: 0x01)),
  newYork(TimeZoneData(
      cityName: 'NEW YORK',
      identifierA: 0xCA,
      identifierB: 0x00,
      offset: 0xEC,
      dstOffset: 0x04,
      dstRules: 0x01)),
  halifax(TimeZoneData(
      cityName: 'HALIFAX',
      identifierA: 0x71,
      identifierB: 0x00,
      offset: 0xF0,
      dstOffset: 0x04,
      dstRules: 0x01)),
  stJohns(TimeZoneData(
      cityName: "ST.JOHN'S",
      identifierA: 0x0C,
      identifierB: 0x01,
      offset: 0xF2,
      dstOffset: 0x04,
      dstRules: 0x01)),
  rioDeJaneiro(TimeZoneData(
      cityName: 'RIO DE JANEIRO',
      identifierA: 0xF1,
      identifierB: 0x00,
      offset: 0xF4,
      dstOffset: 0x04,
      dstRules: 0x00)),
  fDeNoronha(TimeZoneData(
      cityName: 'F.DE NORONHA',
      identifierA: 0x62,
      identifierB: 0x00,
      offset: 0xF8,
      dstOffset: 0x04,
      dstRules: 0x00)),
  praia(TimeZoneData(
      cityName: 'PRAIA',
      identifierA: 0xE9,
      identifierB: 0x00,
      offset: 0xFC,
      dstOffset: 0x04,
      dstRules: 0x00)),
  utc(TimeZoneData(
      cityName: 'UTC',
      identifierA: 0x00,
      identifierB: 0x00,
      offset: 0x00,
      dstOffset: 0x00,
      dstRules: 0x00)),
  london(TimeZoneData(
      cityName: 'LONDON',
      identifierA: 0xA0,
      identifierB: 0x00,
      offset: 0x00,
      dstOffset: 0x04,
      dstRules: 0x02)),
  paris(TimeZoneData(
      cityName: 'PARIS',
      identifierA: 0xDC,
      identifierB: 0x00,
      offset: 0x04,
      dstOffset: 0x04,
      dstRules: 0x02)),
  athens(TimeZoneData(
      cityName: 'ATHENS',
      identifierA: 0x13,
      identifierB: 0x00,
      offset: 0x08,
      dstOffset: 0x04,
      dstRules: 0x02)),
  jeddah(TimeZoneData(
      cityName: 'JEDDAH',
      identifierA: 0x85,
      identifierB: 0x00,
      offset: 0x0C,
      dstOffset: 0x04,
      dstRules: 0x00)),
  tehran(TimeZoneData(
      cityName: 'TEHRAN',
      identifierA: 0x16,
      identifierB: 0x01,
      offset: 0x0E,
      dstOffset: 0x04,
      dstRules: 0x2B)),
  dubai(TimeZoneData(
      cityName: 'DUBAI',
      identifierA: 0x5B,
      identifierB: 0x00,
      offset: 0x10,
      dstOffset: 0x04,
      dstRules: 0x00)),
  kabul(TimeZoneData(
      cityName: 'KABUL',
      identifierA: 0x88,
      identifierB: 0x00,
      offset: 0x12,
      dstOffset: 0x04,
      dstRules: 0x00)),
  karachi(TimeZoneData(
      cityName: 'KARACHI',
      identifierA: 0x8B,
      identifierB: 0x00,
      offset: 0x14,
      dstOffset: 0x04,
      dstRules: 0x00)),
  delhi(TimeZoneData(
      cityName: 'DELHI',
      identifierA: 0x52,
      identifierB: 0x00,
      offset: 0x16,
      dstOffset: 0x04,
      dstRules: 0x00)),
  kathmandu(TimeZoneData(
      cityName: 'KATHMANDU',
      identifierA: 0x8C,
      identifierB: 0x00,
      offset: 0x17,
      dstOffset: 0x04,
      dstRules: 0x00)),
  dhaka(TimeZoneData(
      cityName: 'DHAKA',
      identifierA: 0x56,
      identifierB: 0x00,
      offset: 0x18,
      dstOffset: 0x04,
      dstRules: 0x00)),
  yangon(TimeZoneData(
      cityName: 'YANGON',
      identifierA: 0x2F,
      identifierB: 0x01,
      offset: 0x1A,
      dstOffset: 0x04,
      dstRules: 0x00)),
  bangkok(TimeZoneData(
      cityName: 'BANGKOK',
      identifierA: 0x1C,
      identifierB: 0x00,
      offset: 0x1C,
      dstOffset: 0x04,
      dstRules: 0x00)),
  hongKong(TimeZoneData(
      cityName: 'HONG KONG',
      identifierA: 0x7A,
      identifierB: 0x00,
      offset: 0x20,
      dstOffset: 0x04,
      dstRules: 0x00)),
  pyongyang(TimeZoneData(
      cityName: 'PYONGYANG',
      identifierA: 0xEA,
      identifierB: 0x00,
      offset: 0x24,
      dstOffset: 0x04,
      dstRules: 0x00)),
  eucla(TimeZoneData(
      cityName: 'EUCLA',
      identifierA: 0x36,
      identifierB: 0x01,
      offset: 0x23,
      dstOffset: 0x04,
      dstRules: 0x00)),
  tokyo(TimeZoneData(
      cityName: 'TOKYO',
      identifierA: 0x19,
      identifierB: 0x01,
      offset: 0x24,
      dstOffset: 0x04,
      dstRules: 0x00)),
  adelaide(TimeZoneData(
      cityName: 'ADELAIDE',
      identifierA: 0x05,
      identifierB: 0x00,
      offset: 0x26,
      dstOffset: 0x04,
      dstRules: 0x04)),
  sydney(TimeZoneData(
      cityName: 'SYDNEY',
      identifierA: 0x0F,
      identifierB: 0x01,
      offset: 0x28,
      dstOffset: 0x04,
      dstRules: 0x04)),
  lordHoweIsland(TimeZoneData(
      cityName: 'LORD HOWE ISLAND',
      identifierA: 0x37,
      identifierB: 0x01,
      offset: 0x2A,
      dstOffset: 0x02,
      dstRules: 0x12)),
  noumea(TimeZoneData(
      cityName: 'NOUMEA',
      identifierA: 0xCD,
      identifierB: 0x00,
      offset: 0x2C,
      dstOffset: 0x04,
      dstRules: 0x00)),
  wellington(TimeZoneData(
      cityName: 'WELLINGTON',
      identifierA: 0x2B,
      identifierB: 0x01,
      offset: 0x30,
      dstOffset: 0x04,
      dstRules: 0x05)),
  chathamIslands(TimeZoneData(
      cityName: 'CHATHAM ISLANDS',
      identifierA: 0x3F,
      identifierB: 0x00,
      offset: 0x33,
      dstOffset: 0x04,
      dstRules: 0x17)),
  nukualofa(TimeZoneData(
      cityName: 'NUKUALOFA',
      identifierA: 0xD0,
      identifierB: 0x00,
      offset: 0x34,
      dstOffset: 0x04,
      dstRules: 0x00)),
  kiritimati(TimeZoneData(
      cityName: 'KIRITIMATI',
      identifierA: 0x93,
      identifierB: 0x00,
      offset: 0x38,
      dstOffset: 0x04,
      dstRules: 0x00));

  final TimeZoneData data;

  const TimeZone(this.data);

  static TimeZone fromCityName(String cityName) =>
      TimeZone.values.firstWhere((tz) => tz.data.cityName == cityName);

  static TimeZone fromIdentifiers(int identifierA, int identifierB) =>
      TimeZone.values.firstWhere((tz) =>
          tz.data.identifierA == identifierA &&
          tz.data.identifierB == identifierB);
}
