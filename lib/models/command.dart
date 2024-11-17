enum Command {
  watchName(0x23),
  appInformation(0x22),
  bleFeatures(0x10),
  settingForBle(0x11),
  watchCondition(0x28),
  clock(0x1d),
  timeZoneConfig(0x1e),
  timeZoneName(0x1f),
  // somethingRelatedToTimezone(0x24),
  currentTime(0x09),
  settingForAlm(0x15),
  settingForAlm2(0x16),
  settingForBasic(0x13),
  currentTimeManager(0x39),
  reminderTitle(0x30),
  reminderTime(0x31),
  timer(0x18),
  error(0xFF),

  // ECB-30
  cmdSetTimeMode(0x47),
  findPhone(0x0A);

  final int code;

  const Command(this.code);

  static Command? fromCode(int code) =>
      Command.values.cast<Command?>().firstWhere((c) => c?.code == code, orElse: () => null);
}
