package com.vocsy.epub_viewer;
import android.Manifest;
import android.app.Activity;
import android.content.Context;
import android.os.Build;
import android.util.Log;
import android.content.pm.PackageManager;
import java.io.File;

import java.util.Map;

import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import io.flutter.embedding.engine.plugins.FlutterPlugin;

import androidx.annotation.NonNull;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import com.folioreader.model.locators.ReadLocator;

/**
 * EpubReaderPlugin
 */
public class EpubViewerPlugin implements MethodCallHandler, FlutterPlugin, ActivityAware {

    private static final int STORAGE_PERMISSION_CODE = 1001;
    private Reader reader;
    private ReaderConfig config;
    private MethodChannel channel;
    static private Activity activity;
    static private Context context;
    static BinaryMessenger messenger;
    static private EventChannel eventChannel;
    static private EventChannel.EventSink sink;
    private static final String channelName = "vocsy_epub_viewer";

    /**
     * Plugin registration.
     */
    public static void registerWith(Registrar registrar) {

        context = registrar.context();
        activity = registrar.activity();
        messenger = registrar.messenger();
        new EventChannel(messenger, "page").setStreamHandler(new EventChannel.StreamHandler() {

            @Override
            public void onListen(Object o, EventChannel.EventSink eventSink) {

                sink = eventSink;
                if (sink == null) {
                    Log.i("empty", "Sink is empty");
                }
            }

            @Override
            public void onCancel(Object o) {

            }
        });


        final MethodChannel channel = new MethodChannel(registrar.messenger(), "vocsy_epub_viewer");
        channel.setMethodCallHandler(new EpubViewerPlugin());

    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
        messenger = binding.getBinaryMessenger();
        context = binding.getApplicationContext();
        new EventChannel(messenger, "page").setStreamHandler(new EventChannel.StreamHandler() {

            @Override
            public void onListen(Object o, EventChannel.EventSink eventSink) {

                sink = eventSink;
                if (sink == null) {
                    Log.i("empty", "Sink is empty");
                }
            }

            @Override
            public void onCancel(Object o) {

            }
        });
        channel = new MethodChannel(binding.getFlutterEngine().getDartExecutor(), channelName);
        channel.setMethodCallHandler(this);
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        // TODO: your plugin is no longer attached to a Flutter experience.
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding activityPluginBinding) {
        activity = activityPluginBinding.getActivity();
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {

    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding activityPluginBinding) {

    }


    @Override
    public void onDetachedFromActivity() {
        activity = null;
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {

        if (call.method.equals("setConfig")) {
            Map<String, Object> arguments = (Map<String, Object>) call.arguments;
            String identifier = arguments.get("identifier").toString();
            String themeColor = arguments.get("themeColor").toString();
            String scrollDirection = arguments.get("scrollDirection").toString();
            Boolean nightMode = Boolean.parseBoolean(arguments.get("nightMode").toString());
            Boolean allowSharing = Boolean.parseBoolean(arguments.get("allowSharing").toString());
            Boolean enableTts = Boolean.parseBoolean(arguments.get("enableTts").toString());
            config = new ReaderConfig(context, identifier, themeColor,
                    scrollDirection, allowSharing, enableTts, nightMode);

        } else if (call.method.equals("open")) {

            Map<String, Object> arguments = (Map<String, Object>) call.arguments;
            String bookPath = arguments.get("bookPath").toString();
            String lastLocation = arguments.get("lastLocation").toString();

            Log.i("opening", "In open function");

            // Check for permissions before proceeding
            if (Build.VERSION.SDK_INT <= Build.VERSION_CODES.S) { // Android 12 and below
                if (ContextCompat.checkSelfPermission(context, Manifest.permission.READ_EXTERNAL_STORAGE)
                        != PackageManager.PERMISSION_GRANTED) {

                    // Request storage permission
                    ActivityCompat.requestPermissions(activity,
                            new String[]{Manifest.permission.READ_EXTERNAL_STORAGE},
                            STORAGE_PERMISSION_CODE);
                } else {
                    // Permission already granted, open file
                    openBook(bookPath, lastLocation);
                }
            } else {
                // No need for runtime storage permissions on Android 13 and above
                openBook(bookPath, lastLocation);
            }

//            if (sink == null) {
//                Log.i("sink status", "sink is empty");
//            }
//            reader = new Reader(context, messenger, config, sink);
//            reader.open(bookPath, lastLocation);

        } else if (call.method.equals("close")) {
            reader.close();
        } else if (call.method.equals("setChannel")) {
            eventChannel = new EventChannel(messenger, "page");
            eventChannel.setStreamHandler(new EventChannel.StreamHandler() {

                @Override
                public void onListen(Object o, EventChannel.EventSink eventSink) {

                    sink = eventSink;
                }

                @Override
                public void onCancel(Object o) {

                }
            });
        }  else if (call.method.equals("getAndroidVersion")) {
            String androidVersion = Build.VERSION.RELEASE;
            result.success(androidVersion);
        }
        else {
            result.notImplemented();
        }
    }

    private void openBook(String bookPath, String lastLocation) {
        if (sink == null) {
            Log.i("sink status", "sink is empty");
        }
        // Check if the file exists
        File file = new File(bookPath);
        if (file.exists() && file.isFile()) {
            Log.i("File Check", "File exists at path: " + bookPath);
            reader = new Reader(context, messenger, config, sink);
            reader.open(bookPath, lastLocation);
        } else {
            Log.e("File Check", "File does not exist at path: " + bookPath);
        }
    }
}
