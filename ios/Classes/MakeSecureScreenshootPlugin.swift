import Flutter
import UIKit

public class MakeSecureScreenshootPlugin: NSObject, FlutterPlugin {
  var isSecure = false

  private var secureWindowManager: SecureWindowManager?

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "make_secure_screenshoot", binaryMessenger: registrar.messenger())
    let instance = MakeSecureScreenshootPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    case "makeSecure":
        if secureWindowManager == nil {
           secureWindowManager = SecureWindowManager(window: UIApplication.shared.keyWindow!)
        }
        let textField = secureWindowManager?.makeSecure()
        result(textField != nil)
    case "removeSecure":
       secureWindowManager?.removeSecure()
       result(nil)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}



class SecureWindowManager {
    private var window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func makeSecure() -> UITextField? {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.tag = 100
        self.window.addSubview(field)
        field.centerYAnchor.constraint(equalTo: self.window.centerYAnchor).isActive = true
        field.centerXAnchor.constraint(equalTo: self.window.centerXAnchor).isActive = true

        let label = UILabel()
        label.text = ""
        label.tag = 100
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 8)
        label.sizeToFit()
        label.center = self.window.center

        self.window.addSubview(label)
        return field
    }

    func removeSecure() {
        for subview in self.window.subviews {
            if let textField = subview as? UITextField, textField.tag == 100 {
                textField.removeFromSuperview()
            }
            if let label = subview as? UILabel, label.tag == 100 {
                label.removeFromSuperview()
            }
        }
    }
}