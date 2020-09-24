package np.com.psykho.qrcode_generator_and_reader;

import android.content.Intent;
import android.net.Uri;


import androidx.core.content.FileProvider;

import java.io.File;

import io.flutter.app.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;


public class MainActivity extends FlutterActivity {
    private static final String SHARE_CHANNEL = "channel:me.psykho.share/share";
    @Override
    protected void onCreate(android.os.Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(new FlutterEngine(this));
        new MethodChannel(this.getFlutterView(), SHARE_CHANNEL).setMethodCallHandler(new MethodChannel.MethodCallHandler(){
            @Override
            public final void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
                if (methodCall.method.equals("shareFile")) {
                    shareFile((String) methodCall.arguments);
                }
            }
        });
    }


    private void shareFile(String path) {
        File imageFile = new File(this.getApplicationContext().getCacheDir(), path);
        Uri contentUri = FileProvider.getUriForFile(this, "me.psykho.share", imageFile);
        Intent shareIntent = new Intent(Intent.ACTION_SEND);
        shareIntent.setType("image/jpg");
        shareIntent.putExtra(Intent.EXTRA_STREAM, contentUri);
        this.startActivity(Intent.createChooser(shareIntent, "Share image using"));
    }
}
