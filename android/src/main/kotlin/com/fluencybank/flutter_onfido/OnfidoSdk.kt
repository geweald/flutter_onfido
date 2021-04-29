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

            try {
                val onfidoConfig = OnfidoConfig.builder(currentActivity!!)
                        .withSDKToken(sdkToken)
                        .withCustomFlow(flowStepsWithOptions)
                        .build()
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
            if (cc.alpha3 == countryCodeString) {
                countryCode = cc
            }
        }
        return countryCode
    }
}