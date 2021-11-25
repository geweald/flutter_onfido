// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onfido_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OnfidoConfig _$OnfidoConfigFromJson(Map<String, dynamic> json) {
  return OnfidoConfig(
    sdkToken: json['sdkToken'] as String?,
    flowSteps: json['flowSteps'] == null
        ? null
        : OnfidoFlowSteps.fromJson(json['flowSteps'] as Map<String, dynamic>),
    locale: json['locale'] as String?,
  );
}

Map<String, dynamic> _$OnfidoConfigToJson(OnfidoConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('sdkToken', instance.sdkToken);
  writeNotNull('flowSteps', instance.flowSteps?.toJson());
  writeNotNull('locale', instance.locale);
  return val;
}

OnfidoFlowSteps _$OnfidoFlowStepsFromJson(Map<String, dynamic> json) {
  return OnfidoFlowSteps(
    welcome: json['welcome'] as bool?,
    captureDocument: json['captureDocument'] == null
        ? null
        : OnfidoCaptureDocumentStep.fromJson(
            json['captureDocument'] as Map<String, dynamic>),
    captureFace: json['captureFace'] == null
        ? null
        : OnfidoCaptureFaceStep.fromJson(
            json['captureFace'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$OnfidoFlowStepsToJson(OnfidoFlowSteps instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('welcome', instance.welcome);
  writeNotNull('captureDocument', instance.captureDocument?.toJson());
  writeNotNull('captureFace', instance.captureFace?.toJson());
  return val;
}

OnfidoCaptureDocumentStep _$OnfidoCaptureDocumentStepFromJson(
    Map<String, dynamic> json) {
  return OnfidoCaptureDocumentStep(
    docType: _$enumDecodeNullable(_$OnfidoDocumentTypeEnumMap, json['docType']),
    countryCode:
        _$enumDecodeNullable(_$OnfidoCountryCodeEnumMap, json['countryCode']),
  );
}

Map<String, dynamic> _$OnfidoCaptureDocumentStepToJson(
    OnfidoCaptureDocumentStep instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('docType', _$OnfidoDocumentTypeEnumMap[instance.docType]);
  writeNotNull('countryCode', _$OnfidoCountryCodeEnumMap[instance.countryCode]);
  return val;
}

T? _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries.singleWhere((e) => e.value == source).key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T? _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$OnfidoDocumentTypeEnumMap = {
  OnfidoDocumentType.PASSPORT: 'PASSPORT',
  OnfidoDocumentType.DRIVING_LICENCE: 'DRIVING_LICENCE',
  OnfidoDocumentType.NATIONAL_IDENTITY_CARD: 'NATIONAL_IDENTITY_CARD',
  OnfidoDocumentType.RESIDENCE_PERMIT: 'RESIDENCE_PERMIT',
  OnfidoDocumentType.VISA: 'VISA',
  OnfidoDocumentType.WORK_PERMIT: 'WORK_PERMIT',
  OnfidoDocumentType.GENERIC: 'GENERIC',
};

const _$OnfidoCountryCodeEnumMap = {
  OnfidoCountryCode.AFG: 'AFG',
  OnfidoCountryCode.ALB: 'ALB',
  OnfidoCountryCode.DZA: 'DZA',
  OnfidoCountryCode.ASM: 'ASM',
  OnfidoCountryCode.AND: 'AND',
  OnfidoCountryCode.AGO: 'AGO',
  OnfidoCountryCode.AIA: 'AIA',
  OnfidoCountryCode.ATA: 'ATA',
  OnfidoCountryCode.ATG: 'ATG',
  OnfidoCountryCode.ARG: 'ARG',
  OnfidoCountryCode.ARM: 'ARM',
  OnfidoCountryCode.ABW: 'ABW',
  OnfidoCountryCode.AUS: 'AUS',
  OnfidoCountryCode.AUT: 'AUT',
  OnfidoCountryCode.AZE: 'AZE',
  OnfidoCountryCode.BHS: 'BHS',
  OnfidoCountryCode.BHR: 'BHR',
  OnfidoCountryCode.BGD: 'BGD',
  OnfidoCountryCode.BRB: 'BRB',
  OnfidoCountryCode.BLR: 'BLR',
  OnfidoCountryCode.BEL: 'BEL',
  OnfidoCountryCode.BLZ: 'BLZ',
  OnfidoCountryCode.BEN: 'BEN',
  OnfidoCountryCode.BMU: 'BMU',
  OnfidoCountryCode.BTN: 'BTN',
  OnfidoCountryCode.BOL: 'BOL',
  OnfidoCountryCode.BES: 'BES',
  OnfidoCountryCode.BIH: 'BIH',
  OnfidoCountryCode.BWA: 'BWA',
  OnfidoCountryCode.BVT: 'BVT',
  OnfidoCountryCode.BRA: 'BRA',
  OnfidoCountryCode.IOT: 'IOT',
  OnfidoCountryCode.BRN: 'BRN',
  OnfidoCountryCode.BGR: 'BGR',
  OnfidoCountryCode.BFA: 'BFA',
  OnfidoCountryCode.BDI: 'BDI',
  OnfidoCountryCode.CPV: 'CPV',
  OnfidoCountryCode.KHM: 'KHM',
  OnfidoCountryCode.CMR: 'CMR',
  OnfidoCountryCode.CAN: 'CAN',
  OnfidoCountryCode.CYM: 'CYM',
  OnfidoCountryCode.CAF: 'CAF',
  OnfidoCountryCode.TCD: 'TCD',
  OnfidoCountryCode.CHL: 'CHL',
  OnfidoCountryCode.CHN: 'CHN',
  OnfidoCountryCode.CXR: 'CXR',
  OnfidoCountryCode.CCK: 'CCK',
  OnfidoCountryCode.COL: 'COL',
  OnfidoCountryCode.COM: 'COM',
  OnfidoCountryCode.COD: 'COD',
  OnfidoCountryCode.COG: 'COG',
  OnfidoCountryCode.COK: 'COK',
  OnfidoCountryCode.CRI: 'CRI',
  OnfidoCountryCode.HRV: 'HRV',
  OnfidoCountryCode.CUB: 'CUB',
  OnfidoCountryCode.CUW: 'CUW',
  OnfidoCountryCode.CYP: 'CYP',
  OnfidoCountryCode.CZE: 'CZE',
  OnfidoCountryCode.CIV: 'CIV',
  OnfidoCountryCode.DNK: 'DNK',
  OnfidoCountryCode.DJI: 'DJI',
  OnfidoCountryCode.DMA: 'DMA',
  OnfidoCountryCode.DOM: 'DOM',
  OnfidoCountryCode.ECU: 'ECU',
  OnfidoCountryCode.EGY: 'EGY',
  OnfidoCountryCode.SLV: 'SLV',
  OnfidoCountryCode.GNQ: 'GNQ',
  OnfidoCountryCode.ERI: 'ERI',
  OnfidoCountryCode.EST: 'EST',
  OnfidoCountryCode.SWZ: 'SWZ',
  OnfidoCountryCode.ETH: 'ETH',
  OnfidoCountryCode.FLK: 'FLK',
  OnfidoCountryCode.FRO: 'FRO',
  OnfidoCountryCode.FJI: 'FJI',
  OnfidoCountryCode.FIN: 'FIN',
  OnfidoCountryCode.FRA: 'FRA',
  OnfidoCountryCode.GUF: 'GUF',
  OnfidoCountryCode.PYF: 'PYF',
  OnfidoCountryCode.ATF: 'ATF',
  OnfidoCountryCode.GAB: 'GAB',
  OnfidoCountryCode.GMB: 'GMB',
  OnfidoCountryCode.GEO: 'GEO',
  OnfidoCountryCode.DEU: 'DEU',
  OnfidoCountryCode.GHA: 'GHA',
  OnfidoCountryCode.GIB: 'GIB',
  OnfidoCountryCode.GRC: 'GRC',
  OnfidoCountryCode.GRL: 'GRL',
  OnfidoCountryCode.GRD: 'GRD',
  OnfidoCountryCode.GLP: 'GLP',
  OnfidoCountryCode.GUM: 'GUM',
  OnfidoCountryCode.GTM: 'GTM',
  OnfidoCountryCode.GGY: 'GGY',
  OnfidoCountryCode.GIN: 'GIN',
  OnfidoCountryCode.GNB: 'GNB',
  OnfidoCountryCode.GUY: 'GUY',
  OnfidoCountryCode.HTI: 'HTI',
  OnfidoCountryCode.HMD: 'HMD',
  OnfidoCountryCode.VAT: 'VAT',
  OnfidoCountryCode.HND: 'HND',
  OnfidoCountryCode.HKG: 'HKG',
  OnfidoCountryCode.HUN: 'HUN',
  OnfidoCountryCode.ISL: 'ISL',
  OnfidoCountryCode.IND: 'IND',
  OnfidoCountryCode.IDN: 'IDN',
  OnfidoCountryCode.IRN: 'IRN',
  OnfidoCountryCode.IRQ: 'IRQ',
  OnfidoCountryCode.IRL: 'IRL',
  OnfidoCountryCode.IMN: 'IMN',
  OnfidoCountryCode.ISR: 'ISR',
  OnfidoCountryCode.ITA: 'ITA',
  OnfidoCountryCode.JAM: 'JAM',
  OnfidoCountryCode.JPN: 'JPN',
  OnfidoCountryCode.JEY: 'JEY',
  OnfidoCountryCode.JOR: 'JOR',
  OnfidoCountryCode.KAZ: 'KAZ',
  OnfidoCountryCode.KEN: 'KEN',
  OnfidoCountryCode.KIR: 'KIR',
  OnfidoCountryCode.PRK: 'PRK',
  OnfidoCountryCode.KOR: 'KOR',
  OnfidoCountryCode.KWT: 'KWT',
  OnfidoCountryCode.KGZ: 'KGZ',
  OnfidoCountryCode.LAO: 'LAO',
  OnfidoCountryCode.LVA: 'LVA',
  OnfidoCountryCode.LBN: 'LBN',
  OnfidoCountryCode.LSO: 'LSO',
  OnfidoCountryCode.LBR: 'LBR',
  OnfidoCountryCode.LBY: 'LBY',
  OnfidoCountryCode.LIE: 'LIE',
  OnfidoCountryCode.LTU: 'LTU',
  OnfidoCountryCode.LUX: 'LUX',
  OnfidoCountryCode.MAC: 'MAC',
  OnfidoCountryCode.MDG: 'MDG',
  OnfidoCountryCode.MWI: 'MWI',
  OnfidoCountryCode.MYS: 'MYS',
  OnfidoCountryCode.MDV: 'MDV',
  OnfidoCountryCode.MLI: 'MLI',
  OnfidoCountryCode.MLT: 'MLT',
  OnfidoCountryCode.MHL: 'MHL',
  OnfidoCountryCode.MTQ: 'MTQ',
  OnfidoCountryCode.MRT: 'MRT',
  OnfidoCountryCode.MUS: 'MUS',
  OnfidoCountryCode.MYT: 'MYT',
  OnfidoCountryCode.MEX: 'MEX',
  OnfidoCountryCode.FSM: 'FSM',
  OnfidoCountryCode.MDA: 'MDA',
  OnfidoCountryCode.MCO: 'MCO',
  OnfidoCountryCode.MNG: 'MNG',
  OnfidoCountryCode.MNE: 'MNE',
  OnfidoCountryCode.MSR: 'MSR',
  OnfidoCountryCode.MAR: 'MAR',
  OnfidoCountryCode.MOZ: 'MOZ',
  OnfidoCountryCode.MMR: 'MMR',
  OnfidoCountryCode.NAM: 'NAM',
  OnfidoCountryCode.NRU: 'NRU',
  OnfidoCountryCode.NPL: 'NPL',
  OnfidoCountryCode.NLD: 'NLD',
  OnfidoCountryCode.NCL: 'NCL',
  OnfidoCountryCode.NZL: 'NZL',
  OnfidoCountryCode.NIC: 'NIC',
  OnfidoCountryCode.NER: 'NER',
  OnfidoCountryCode.NGA: 'NGA',
  OnfidoCountryCode.NIU: 'NIU',
  OnfidoCountryCode.NFK: 'NFK',
  OnfidoCountryCode.MKD: 'MKD',
  OnfidoCountryCode.MNP: 'MNP',
  OnfidoCountryCode.NOR: 'NOR',
  OnfidoCountryCode.OMN: 'OMN',
  OnfidoCountryCode.PAK: 'PAK',
  OnfidoCountryCode.PLW: 'PLW',
  OnfidoCountryCode.PSE: 'PSE',
  OnfidoCountryCode.PAN: 'PAN',
  OnfidoCountryCode.PNG: 'PNG',
  OnfidoCountryCode.PRY: 'PRY',
  OnfidoCountryCode.PER: 'PER',
  OnfidoCountryCode.PHL: 'PHL',
  OnfidoCountryCode.PCN: 'PCN',
  OnfidoCountryCode.POL: 'POL',
  OnfidoCountryCode.PRT: 'PRT',
  OnfidoCountryCode.PRI: 'PRI',
  OnfidoCountryCode.QAT: 'QAT',
  OnfidoCountryCode.ROU: 'ROU',
  OnfidoCountryCode.RUS: 'RUS',
  OnfidoCountryCode.RWA: 'RWA',
  OnfidoCountryCode.REU: 'REU',
  OnfidoCountryCode.BLM: 'BLM',
  OnfidoCountryCode.SHN: 'SHN',
  OnfidoCountryCode.KNA: 'KNA',
  OnfidoCountryCode.LCA: 'LCA',
  OnfidoCountryCode.MAF: 'MAF',
  OnfidoCountryCode.SPM: 'SPM',
  OnfidoCountryCode.VCT: 'VCT',
  OnfidoCountryCode.WSM: 'WSM',
  OnfidoCountryCode.SMR: 'SMR',
  OnfidoCountryCode.STP: 'STP',
  OnfidoCountryCode.SAU: 'SAU',
  OnfidoCountryCode.SEN: 'SEN',
  OnfidoCountryCode.SRB: 'SRB',
  OnfidoCountryCode.SYC: 'SYC',
  OnfidoCountryCode.SLE: 'SLE',
  OnfidoCountryCode.SGP: 'SGP',
  OnfidoCountryCode.SXM: 'SXM',
  OnfidoCountryCode.SVK: 'SVK',
  OnfidoCountryCode.SVN: 'SVN',
  OnfidoCountryCode.SLB: 'SLB',
  OnfidoCountryCode.SOM: 'SOM',
  OnfidoCountryCode.ZAF: 'ZAF',
  OnfidoCountryCode.SGS: 'SGS',
  OnfidoCountryCode.SSD: 'SSD',
  OnfidoCountryCode.ESP: 'ESP',
  OnfidoCountryCode.LKA: 'LKA',
  OnfidoCountryCode.SDN: 'SDN',
  OnfidoCountryCode.SUR: 'SUR',
  OnfidoCountryCode.SJM: 'SJM',
  OnfidoCountryCode.SWE: 'SWE',
  OnfidoCountryCode.CHE: 'CHE',
  OnfidoCountryCode.SYR: 'SYR',
  OnfidoCountryCode.TWN: 'TWN',
  OnfidoCountryCode.TJK: 'TJK',
  OnfidoCountryCode.TZA: 'TZA',
  OnfidoCountryCode.THA: 'THA',
  OnfidoCountryCode.TLS: 'TLS',
  OnfidoCountryCode.TGO: 'TGO',
  OnfidoCountryCode.TKL: 'TKL',
  OnfidoCountryCode.TON: 'TON',
  OnfidoCountryCode.TTO: 'TTO',
  OnfidoCountryCode.TUN: 'TUN',
  OnfidoCountryCode.TUR: 'TUR',
  OnfidoCountryCode.TKM: 'TKM',
  OnfidoCountryCode.TCA: 'TCA',
  OnfidoCountryCode.TUV: 'TUV',
  OnfidoCountryCode.UGA: 'UGA',
  OnfidoCountryCode.UKR: 'UKR',
  OnfidoCountryCode.ARE: 'ARE',
  OnfidoCountryCode.GBR: 'GBR',
  OnfidoCountryCode.UMI: 'UMI',
  OnfidoCountryCode.USA: 'USA',
  OnfidoCountryCode.URY: 'URY',
  OnfidoCountryCode.UZB: 'UZB',
  OnfidoCountryCode.VUT: 'VUT',
  OnfidoCountryCode.VEN: 'VEN',
  OnfidoCountryCode.VNM: 'VNM',
  OnfidoCountryCode.VGB: 'VGB',
  OnfidoCountryCode.VIR: 'VIR',
  OnfidoCountryCode.WLF: 'WLF',
  OnfidoCountryCode.ESH: 'ESH',
  OnfidoCountryCode.YEM: 'YEM',
  OnfidoCountryCode.ZMB: 'ZMB',
  OnfidoCountryCode.ZWE: 'ZWE',
  OnfidoCountryCode.ALA: 'ALA',
};

OnfidoCaptureFaceStep _$OnfidoCaptureFaceStepFromJson(
    Map<String, dynamic> json) {
  return OnfidoCaptureFaceStep(
    _$enumDecodeNullable(_$OnfidoCaptureTypeEnumMap, json['type']),
  );
}

Map<String, dynamic> _$OnfidoCaptureFaceStepToJson(
        OnfidoCaptureFaceStep instance) =>
    <String, dynamic>{
      'type': _$OnfidoCaptureTypeEnumMap[instance.type!],
    };

const _$OnfidoCaptureTypeEnumMap = {
  OnfidoCaptureType.PHOTO: 'PHOTO',
  OnfidoCaptureType.VIDEO: 'VIDEO',
};

OnfidoIOSAppearance _$OnfidoIOSAppearanceFromJson(Map<String, dynamic> json) {
  return OnfidoIOSAppearance(
    onfidoPrimaryButtonTextColor:
        json['onfidoPrimaryButtonTextColor'] as String?,
    onfidoPrimaryButtonColorPressed:
        json['onfidoPrimaryButtonColorPressed'] as String?,
    onfidoIosSupportDarkMode: json['onfidoIosSupportDarkMode'] as bool?,
    onfidoPrimaryColor: json['onfidoPrimaryColor'] as String?,
  );
}

Map<String, dynamic> _$OnfidoIOSAppearanceToJson(OnfidoIOSAppearance instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('onfidoPrimaryColor', instance.onfidoPrimaryColor);
  writeNotNull(
      'onfidoPrimaryButtonTextColor', instance.onfidoPrimaryButtonTextColor);
  writeNotNull('onfidoPrimaryButtonColorPressed',
      instance.onfidoPrimaryButtonColorPressed);
  writeNotNull('onfidoIosSupportDarkMode', instance.onfidoIosSupportDarkMode);
  return val;
}

OnfidoResult _$OnfidoResultFromJson(Map<String, dynamic> json) {
  return OnfidoResult(
    document: json['document'] == null
        ? null
        : OnfidoDocumentResult.fromJson(
            json['document'] as Map<String, dynamic>),
    face: json['face'] == null
        ? null
        : OnfidoFaceResult.fromJson(json['face'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$OnfidoResultToJson(OnfidoResult instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('document', instance.document?.toJson());
  writeNotNull('face', instance.face?.toJson());
  return val;
}

OnfidoFaceResult _$OnfidoFaceResultFromJson(Map<String, dynamic> json) {
  return OnfidoFaceResult(
    id: json['id'] as String?,
    variant: _$enumDecodeNullable(_$OnfidoCaptureTypeEnumMap, json['variant']),
  );
}

Map<String, dynamic> _$OnfidoFaceResultToJson(OnfidoFaceResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'variant': _$OnfidoCaptureTypeEnumMap[instance.variant!],
    };

OnfidoDocumentResult _$OnfidoDocumentResultFromJson(Map<String, dynamic> json) {
  return OnfidoDocumentResult(
    front: json['front'] == null
        ? null
        : OnfidoDocumentResultDetail.fromJson(
            json['front'] as Map<String, dynamic>),
    back: json['back'] == null
        ? null
        : OnfidoDocumentResultDetail.fromJson(
            json['back'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$OnfidoDocumentResultToJson(
    OnfidoDocumentResult instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('front', instance.front?.toJson());
  writeNotNull('back', instance.back?.toJson());
  return val;
}

OnfidoDocumentResultDetail _$OnfidoDocumentResultDetailFromJson(
    Map<String, dynamic> json) {
  return OnfidoDocumentResultDetail(
    json['id'] as String?,
  );
}

Map<String, dynamic> _$OnfidoDocumentResultDetailToJson(
        OnfidoDocumentResultDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
    };
