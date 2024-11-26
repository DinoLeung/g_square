import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// didDiscoverServices:
//   svc: 1804
//   svc: 26eb000d-b012-49a8-b1f8-394fb2032b0f
// didDiscoverCharacteristicsForService:
//   svc: 1804
//     chr: 2a07
// didDiscoverCharacteristicsForService:
//   svc: 26eb000d-b012-49a8-b1f8-394fb2032b0f
//     chr: 26eb002c-b012-49a8-b1f8-394fb2032b0f
//     chr: 26eb002d-b012-49a8-b1f8-394fb2032b0f
//     chr: 26eb0023-b012-49a8-b1f8-394fb2032b0f
//     chr: 26eb0024-b012-49a8-b1f8-394fb2032b0f
// didDiscoverDescriptorsForCharacteristic:
//   chr: 2a07
// didDiscoverDescriptorsForCharacteristic:
//   chr: 26eb002c-b012-49a8-b1f8-394fb2032b0f
// didDiscoverDescriptorsForCharacteristic:
//   chr: 26eb002d-b012-49a8-b1f8-394fb2032b0f
//     desc: 2902
// didDiscoverDescriptorsForCharacteristic:
//   chr: 26eb0023-b012-49a8-b1f8-394fb2032b0f
//     desc: 2902
// didDiscoverDescriptorsForCharacteristic:
//   chr: 26eb0024-b012-49a8-b1f8-394fb2032b0f
//     desc: 2902
final casioServiceUUID = Guid("00001804-0000-1000-8000-00805f9b34fb");
final allFeaturesCharacteristicUUID = Guid("26eb000d-b012-49a8-b1f8-394fb2032b0f");
final requestCharacteristicUUID = Guid("26eb002c-b012-49a8-b1f8-394fb2032b0f");
final ioCharacteristicUUID = Guid("26eb002d-b012-49a8-b1f8-394fb2032b0f");
