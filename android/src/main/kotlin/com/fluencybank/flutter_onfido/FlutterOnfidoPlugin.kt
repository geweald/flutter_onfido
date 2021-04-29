package com.fluencybank.flutter_onfido

import android.content.Context
import androidx.annotation.NonNull
import com.onfido.android.sdk.capture.OnfidoFactory
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar


/** FlutterOnfidoPlugin */
class FlutterOnfidoPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
  private lateinit var onfidoSdk: OnfidoSdk
  private lateinit var activityListener: OnfidoSdkActivityEventListener
  private lateinit var methodChannel: MethodChannel
  private lateinit var applicationContext: Context
  private lateinit var pluginBinding: ActivityPluginBinding

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    onAttachedToEngine(flutterPluginBinding.applicationContext, flutterPluginBinding.binaryMessenger)
  }

  // This static function is optional and equivalent to onAttachedToEngine. It supports the old
  // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
  // plugin registration via this function while apps migrate to use the new Android APIs
  // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
  //
  // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
  // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
  // depending on the user's project. onAttachedToEngine or registerWith must both be defined
  // in the same class.
  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val instance = FlutterOnfidoPlugin()
      instance.onAttachedToEngine(registrar.context(), registrar.messenger())
      instance.onfidoSdk.setActivity(registrar.activity())
      registrar.addActivityResultListener(instance.activityListener)

    }
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "start") {
      val config = call.arguments as HashMap<String, Any?>
      onfidoSdk.start(config.get("config") as HashMap<String, Any?>, result)
    } else {
      result.notImplemented()
    }
  }

  private fun onAttachedToEngine(context: Context, messenger: BinaryMessenger) {
    applicationContext = context
    methodChannel = MethodChannel(messenger, "flutter_onfido")
    methodChannel.setMethodCallHandler(this)
    val onfidoClient = OnfidoFactory.create(context).client
    activityListener = OnfidoSdkActivityEventListener(onfidoClient)
    onfidoSdk = OnfidoSdk(null, activityListener, onfidoClient, null)
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    methodChannel.setMethodCallHandler(null)
  }

  override fun onDetachedFromActivity() {
    onfidoSdk.setActivity(null)
    pluginBinding.removeActivityResultListener(activityListener)
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    onReattachedToActivityForConfigChanges(binding)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    onfidoSdk.setActivity(binding.activity)
    pluginBinding = binding
    pluginBinding.addActivityResultListener(activityListener)
  }

  override fun onDetachedFromActivityForConfigChanges() {
    onDetachedFromActivityForConfigChanges()
  }
}
