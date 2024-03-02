import Flutter
import UIKit

public class MakeSecureScreenshootPlugin: NSObject, FlutterPlugin {

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
           //TODO if  UIApplication.shared.windows.first
           secureWindowManager = SecureWindowManager(window: UIApplication.shared.windows.first!)
        }
        let textField = secureWindowManager?.makeSecure()
        result(textField != nil)
    case "removeSecure":
       secureWindowManager?.removeSecure()
       result(false)
    case "getSecureStatus":
       let secureStatus = secureWindowManager?.isSecure
       result(secureStatus)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}



class SecureWindowManager {
    private var window: UIWindow
    public var isSecure = false

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

        self.window.layer.superlayer?.addSublayer(field.layer)
        field.layer.sublayers?.first?.addSublayer(self.window.layer)


        let label = UILabel()
        label.text = "00000000"
        label.tag = 100
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 8)
        label.sizeToFit()
        label.center = self.window.center

        self.window.addSubview(label)
        self.isSecure = true;
        return field
    }

    func removeSecure() {
        self.isSecure = false;
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