package com.fluencybank.flutter_onfido

import android.app.Activity
import com.onfido.android.sdk.capture.DocumentType
import com.onfido.android.sdk.capture.Onfido
import com.onfido.android.sdk.capture.OnfidoConfig
import com.onfido.android.sdk.capture.ui.camera.face.stepbuilder.FaceCaptureStepBuilder
import com.onfido.android.sdk.capture.ui.options.CaptureScreenStep
import com.onfido.android.sdk.capture.ui.options.FlowStep
import com.onfido.android.sdk.capture.utils.CountryCode
import io.flutter.plugin.common.MethodChannel
import java.util.Locale

class OnfidoSdk(var currentFlutterResult: MethodChannel.Result?, var activityListener: OnfidoSdkActivityEventListener, val client: Onfido, var currentActivity: Activity?) {

    private fun setFlutterResult(result: MethodChannel.Result?) {
        currentFlutterResult = result
        activityListener.setCurrentFlutterResult(result)
    }

    fun setActivity(activity: Activity?) {
        if (activity != null) {
            currentActivity = activity
        }
    }

    fun start(config: HashMap<String, Any?>, result: MethodChannel.Result?) {
        setFlutterResult(result)
        try {
            val sdkToken: String
            val flowStepsWithOptions: Array<FlowStep>
            var locale: String? = null;

            try {
                sdkToken = config.get("sdkToken").toString()
                flowStepsWithOptions = getFlowStepsFromConfig(config)
            } catch (e: Exception) {
                currentFlutterResult?.error("config_error", e.message, null)
                setFlutterResult(null)
                return
            }

            if (currentActivity == null) {
                currentFlutterResult?.error("error", "Android activity does not exist", null)
                setFlutterResult(null);
                return;
            }

            if (config.get("locale") != null)
                locale = config.get("locale").toString();

            try {
                var onfidoConfigBuilder = OnfidoConfig.builder(currentActivity!!)
                    .withSDKToken(sdkToken)
                    .withCustomFlow(flowStepsWithOptions)
                if(locale != null)
                    onfidoConfigBuilder = onfidoConfigBuilder.withLocale(Locale(locale))
                val onfidoConfig = onfidoConfigBuilder.build()
                client.startActivityForResult(currentActivity!!, 1, onfidoConfig)
            } catch (e: Exception) {
                currentFlutterResult?.error("error", "Failed to show Onfido page", null)
                setFlutterResult(null)
                return
            }
        } catch (e: Exception) {
            e.printStackTrace()
            currentFlutterResult?.error("error", "Unexpected error starting Onfido page", null)
            setFlutterResult(null)
            return
        }
    }

    @Throws(Exception::class)
    fun getFlowStepsFromConfig(config: HashMap<String, Any?>): Array<FlowStep> {
        try {
            val flowSteps = config.get("flowSteps") as HashMap<String, Any?>

            val welcomePageIsIncluded: Boolean
            welcomePageIsIncluded = if (flowSteps.containsKey("welcome")) {
                flowSteps.get("welcome") as Boolean
            } else {
                false
            }

            var captureDocument: HashMap<String, Any?>? = null
            var captureDocumentBoolean: Boolean? = null

            try {
                captureDocumentBoolean = flowSteps.get("captureDocument") as Boolean
            } catch (e: Exception) {
                captureDocument = try {
                    flowSteps.get("captureDocument") as HashMap<String, Any?>
                } catch (e: Exception) {
                    null
                }
            } catch (e: Exception) {
                captureDocument = try {
                    flowSteps.get("captureDocument") as HashMap<String, Any?>
                } catch (e: Exception) {
                    null
                }
            }

            val flowStepList: MutableList<FlowStep> = ArrayList()

            if (welcomePageIsIncluded) {
                flowStepList.add(FlowStep.WELCOME)
            }

            if (captureDocumentBoolean != null && captureDocumentBoolean) {
                flowStepList.add(FlowStep.CAPTURE_DOCUMENT)
            } else if (captureDocument != null) {
                val docTypeExists: Boolean = captureDocument.containsKey("docType")
                val countryCodeExists: Boolean = captureDocument.containsKey("countryCode")
                if (docTypeExists && countryCodeExists) {
                    val docTypeString: String = captureDocument.get("docType") as String
                    val docTypeEnum: DocumentType
                    try {
                        docTypeEnum = DocumentType.valueOf(docTypeString)
                    } catch (iae: IllegalArgumentException) {
                        System.err.println("Unexpected docType value: [$docTypeString]")
                        throw Exception("Unexpected docType value.")
                    }
                    val countryCodeString: String = captureDocument.get("countryCode") as String
                    val countryCodeEnum = findCountryCodeByAlpha3(countryCodeString)
                    if (countryCodeEnum == null) {
                        System.err.println("Unexpected countryCode value: [$countryCodeString]")
                        throw Exception("Unexpected countryCode value.")
                    }
                    flowStepList.add(CaptureScreenStep(docTypeEnum, countryCodeEnum))
                } else if (!docTypeExists && !countryCodeExists) {
                    flowStepList.add(FlowStep.CAPTURE_DOCUMENT)
                } else {
                    throw Exception("For countryCode and docType: both must be specified, or both must be omitted.")
                }
            }

            val captureFaceEnabled = flowSteps.containsKey("captureFace")
            val captureFace = if (captureFaceEnabled) flowSteps.get("captureFace") as Map<String, Any?> else null;

            if (captureFace != null) {
                val captureFaceTypeExists = captureFace.containsKey("type");
                if (captureFaceTypeExists) {
                    val captureFaceType = captureFace.get("type") as String;
                    if (captureFaceType.equals("PHOTO")) {
                        flowStepList.add(FaceCaptureStepBuilder.forPhoto().build());
                    } else if (captureFaceType.equals("VIDEO")) {
                        flowStepList.add(FaceCaptureStepBuilder.forVideo().build());
                    } else {
                        throw Exception("Invalid face capture type.  \"type\" must be VIDEO or PHOTO.");
                    }
                } else {
                    // Default face capture type is photo.
                    flowStepList.add(FaceCaptureStepBuilder.forPhoto().build());
                }
            }
            flowStepList.add(FlowStep.FINAL)
            return flowStepList.toTypedArray()
        } catch (e: Exception) {
            e.printStackTrace();
            // Wrap all unexpected exceptions.
            throw  Exception("Error generating request", e);
        }
    }


    fun findCountryCodeByAlpha3(countryCodeString: String): CountryCode? {
        var countryCode: CountryCode? = null
        for (cc in CountryCode.values()) {
            if (cc.name == OnfidoAlpha2CountryCodes[countryCodeString]) {
                countryCode = cc
            }
        }
        return countryCode
    }

    private val OnfidoAlpha2CountryCodes: HashMap<String, String> = hashMapOf(
        "AND" to "AD",
        "ARE" to "AE",
        "AFG" to "AF",
        "ATG" to "AG",
        "AIA" to "AI",
        "ALB" to "AL",
        "ARM" to "AM",
        "ANT" to "AN",
        "AGO" to "AO",
        "ATA" to "AQ",
        "ARG" to "AR",
        "ASM" to "AS",
        "AUT" to "AT",
        "AUS" to "AU",
        "ABW" to "AW",
        "ALA" to "AX",
        "AZE" to "AZ",
        "BIH" to "BA",
        "BRB" to "BB",
        "BGD" to "BD",
        "BEL" to "BE",
        "BFA" to "BF",
        "BGR" to "BG",
        "BHR" to "BH",
        "BDI" to "BI",
        "BEN" to "BJ",
        "BLM" to "BL",
        "BMU" to "BM",
        "BRN" to "BN",
        "BOL" to "BO",
        "BES" to "BQ",
        "BRA" to "BR",
        "BHS" to "BS",
        "BTN" to "BT",
        "BVT" to "BV",
        "BWA" to "BW",
        "BLR" to "BY",
        "BLZ" to "BZ",
        "CAN" to "CA",
        "CCK" to "CC",
        "COD" to "CD",
        "CAF" to "CF",
        "COG" to "CG",
        "CHE" to "CH",
        "CIV" to "CI",
        "COK" to "CK",
        "CHL" to "CL",
        "CMR" to "CM",
        "CHN" to "CN",
        "COL" to "CO",
        "CRI" to "CR",
        "CUB" to "CU",
        "CPV" to "CV",
        "CUW" to "CW",
        "CXR" to "CX",
        "CYP" to "CY",
        "CZE" to "CZ",
        "DEU" to "DE",
        "DJI" to "DJ",
        "DNK" to "DK",
        "DMA" to "DM",
        "DOM" to "DO",
        "DZA" to "DZ",
        "ECU" to "EC",
        "EST" to "EE",
        "EGY" to "EG",
        "ESH" to "EH",
        "ERI" to "ER",
        "ESP" to "ES",
        "ETH" to "ET",
        "FIN" to "FI",
        "FJI" to "FJ",
        "FLK" to "FK",
        "FSM" to "FM",
        "FRO" to "FO",
        "FRA" to "FR",
        "GAB" to "GA",
        "GBR" to "GB",
        "GRD" to "GD",
        "GEO" to "GE",
        "GUF" to "GF",
        "GGY" to "GG",
        "GHA" to "GH",
        "GIB" to "GI",
        "GRL" to "GL",
        "GMB" to "GM",
        "GIN" to "GN",
        "GLP" to "GP",
        "GNQ" to "GQ",
        "GRC" to "GR",
        "SGS" to "GS",
        "GTM" to "GT",
        "GUM" to "GU",
        "GNB" to "GW",
        "GUY" to "GY",
        "HKG" to "HK",
        "HMD" to "HM",
        "HND" to "HN",
        "HRV" to "HR",
        "HTI" to "HT",
        "HUN" to "HU",
        "IDN" to "ID",
        "IRL" to "IE",
        "ISR" to "IL",
        "IMN" to "IM",
        "IND" to "IN",
        "IOT" to "IO",
        "IRQ" to "IQ",
        "IRN" to "IR",
        "ISL" to "IS",
        "ITA" to "IT",
        "JEY" to "JE",
        "JAM" to "JM",
        "JOR" to "JO",
        "JPN" to "JP",
        "KEN" to "KE",
        "KGZ" to "KG",
        "KHM" to "KH",
        "KIR" to "KI",
        "COM" to "KM",
        "KNA" to "KN",
        "PRK" to "KP",
        "KOR" to "KR",
        "KWT" to "KW",
        "CYM" to "KY",
        "KAZ" to "KZ",
        "LAO" to "LA",
        "LBN" to "LB",
        "LCA" to "LC",
        "LIE" to "LI",
        "LKA" to "LK",
        "LBR" to "LR",
        "LSO" to "LS",
        "LTU" to "LT",
        "LUX" to "LU",
        "LVA" to "LV",
        "LBY" to "LY",
        "MAR" to "MA",
        "MCO" to "MC",
        "MDA" to "MD",
        "MNE" to "ME",
        "MAF" to "MF",
        "MDG" to "MG",
        "MHL" to "MH",
        "MKD" to "MK",
        "MLI" to "ML",
        "MMR" to "MM",
        "MNG" to "MN",
        "MAC" to "MO",
        "MNP" to "MP",
        "MTQ" to "MQ",
        "MRT" to "MR",
        "MSR" to "MS",
        "MLT" to "MT",
        "MUS" to "MU",
        "MDV" to "MV",
        "MWI" to "MW",
        "MEX" to "MX",
        "MYS" to "MY",
        "MOZ" to "MZ",
        "NAM" to "NA",
        "NCL" to "NC",
        "NER" to "NE",
        "NFK" to "NF",
        "NGA" to "NG",
        "NIC" to "NI",
        "NLD" to "NL",
        "NOR" to "NO",
        "NPL" to "NP",
        "NRU" to "NR",
        "NIU" to "NU",
        "NZL" to "NZ",
        "OMN" to "OM",
        "PAN" to "PA",
        "PER" to "PE",
        "PYF" to "PF",
        "PNG" to "PG",
        "PHL" to "PH",
        "PAK" to "PK",
        "POL" to "PL",
        "SPM" to "PM",
        "PCN" to "PN",
        "PRI" to "PR",
        "PSE" to "PS",
        "PRT" to "PT",
        "PLW" to "PW",
        "PRY" to "PY",
        "QAT" to "QA",
        "REU" to "RE",
        "ROU" to "RO",
        "SRB" to "RS",
        "RUS" to "RU",
        "RWA" to "RW",
        "SAU" to "SA",
        "SLB" to "SB",
        "SYC" to "SC",
        "SDN" to "SD",
        "SWE" to "SE",
        "SGP" to "SG",
        "SHN" to "SH",
        "SVN" to "SI",
        "SJM" to "SJ",
        "SVK" to "SK",
        "SLE" to "SL",
        "SMR" to "SM",
        "SEN" to "SN",
        "SOM" to "SO",
        "SUR" to "SR",
        "SSD" to "SS",
        "STP" to "ST",
        "SLV" to "SV",
        "SXM" to "SX",
        "SYR" to "SY",
        "SWZ" to "SZ",
        "TCA" to "TC",
        "TCD" to "TD",
        "ATF" to "TF",
        "TGO" to "TG",
        "THA" to "TH",
        "TJK" to "TJ",
        "TKL" to "TK",
        "TLS" to "TL",
        "TKM" to "TM",
        "TUN" to "TN",
        "TON" to "TO",
        "TUR" to "TR",
        "TTO" to "TT",
        "TUV" to "TV",
        "TWN" to "TW",
        "TZA" to "TZ",
        "UKR" to "UA",
        "UGA" to "UG",
        "UMI" to "UM",
        "USA" to "US",
        "URY" to "UY",
        "UZB" to "UZ",
        "VAT" to "VA",
        "VCT" to "VC",
        "VEN" to "VE",
        "VGB" to "VG",
        "VIR" to "VI",
        "VNM" to "VN",
        "VUT" to "VU",
        "WLF" to "WF",
        "WSM" to "WS",
        "YEM" to "YE",
        "MYT" to "YT",
        "ZAF" to "ZA",
        "ZMB" to "ZM",
        "ZWE" to "ZW")
}