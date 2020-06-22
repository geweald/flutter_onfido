package com.fluencybank.flutter_onfido

import android.content.Intent
import com.onfido.android.sdk.capture.ExitCode
import com.onfido.android.sdk.capture.Onfido
import com.onfido.android.sdk.capture.Onfido.OnfidoResultListener
import com.onfido.android.sdk.capture.errors.OnfidoException
import com.onfido.android.sdk.capture.upload.Captures
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry


class OnfidoSdkActivityEventListener(
        val client: Onfido) : PluginRegistry.ActivityResultListener {
    private var flutterResult: MethodChannel.Result? = null

    fun setCurrentFlutterResult(result: MethodChannel.Result?) {
        this.flutterResult = result
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        client.handleActivityResult(resultCode, data, object : OnfidoResultListener {
            override fun userCompleted(captures: Captures) {
                if (flutterResult != null) {
                    var docFrontId: String? = null
                    var docBackId: String? = null
                    var faceId: String? = null
                    var faceVarient: String? = null
                    if (captures.document != null) {
                        if (captures.document!!.front != null) {
                            docFrontId = captures.document!!.front!!.id
                        }
                        if (captures.document!!.back != null) {
                            docBackId = captures.document!!.back!!.id
                        }
                    }
                    if (captures.face != null) {
                        faceId = captures.face!!.id
                        faceVarient = captures.face!!.variant.toString()
                    }
                    try {
                        val response = Response(docFrontId, docBackId, faceId, faceVarient)
                        flutterResult!!.success(response.toMap())
                    } catch (e: Exception) {
                        flutterResult!!.error("error", "Error serializing response", null)
                    }
                }
            }

            override fun userExited(exitCode: ExitCode) {
                if (flutterResult != null) {
                    flutterResult!!.error("cancel", "User exited by clicking the back button.", null)
                    flutterResult = null
                }
            }

            override fun onError(exception: OnfidoException) {
                if (flutterResult != null) {
                    flutterResult!!.error("error", exception.toString(), null)
                    flutterResult = null
                }
            }
        })
        return true
    }

}