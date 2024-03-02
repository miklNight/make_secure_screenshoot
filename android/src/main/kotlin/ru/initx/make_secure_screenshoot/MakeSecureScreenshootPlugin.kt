package ru.initx.make_secure_screenshoot

import androidx.annotation.NonNull

import android.view.WindowManager
import android.app.Activity

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.embedding.engine.plugins.activity.ActivityAware

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** MakeSecureScreenshootPlugin */
class MakeSecureScreenshootPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    private var activity: Activity? = null
    private lateinit var channel: MethodChannel

    /*  fun registerWith(registrar: Registrar) {
        val plugin = MakeSecureScreenshootPlugin()
        plugin.activity = registrar.activity()
        val channel = MethodChannel(registrar.messenger(), "make_secure_screenshoot")
        channel.setMethodCallHandler(plugin)
      }*/

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "make_secure_screenshoot")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        if (call.method == "getPlatformVersion") {
            result.success("Android ${android.os.Build.VERSION.RELEASE}")
        } else if (call.method == "makeSecure") {
            activity?.window?.addFlags(WindowManager.LayoutParams.FLAG_SECURE);
            result.success(true)
        } else if (call.method == "removeSecure") {
            activity?.window?.clearFlags(WindowManager.LayoutParams.FLAG_SECURE);
            result.success(false)
        } else if (call.method == "getSecureStatus") {

            val flags = activity?.window?.attributes?.flags
           // val flags: Int = activity.getWindow().getAttributes().flags

           // var res = flags?.and(WindowManager.LayoutParams.FLAG_SECURE != 0)
            var res = (flags?.and(WindowManager.LayoutParams.FLAG_SECURE)) != 0
            result.success(res)
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {}

    override fun onDetachedFromActivity() {}

}
