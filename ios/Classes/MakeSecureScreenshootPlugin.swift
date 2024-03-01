import Flutter
import UIKit

public class MakeSecureScreenshootPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "make_secure_screenshoot", binaryMessenger: registrar.messenger())
    let instance = MakeSecureScreenshootPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  extension UIWindow {
    func makeSecure() -> UITextField? {
      let field = UITextField()
      field.isSecureTextEntry = true
      field.tag = 100
      self.addSubview(field)
      field.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
      field.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

      self.layer.superlayer?.addSublayer(field.layer)
      field.layer.sublayers?.first?.addSublayer(self.layer)


      let label = UILabel()
          label.text = ""
          label.tag = 100
          label.textColor = .white
          label.font = UIFont.boldSystemFont(ofSize: 8)
          label.sizeToFit()
          label.center = self.center

      self.addSubview(label)
      return field;
    }

    func removeSecure() {
      for subview in self.subviews {
       if let textField = subview as? UITextField, textField.tag == 100 {
           textField.removeFromSuperview()
       }
       if let label = subview as? UILabel, label.tag == 100 {
          label.removeFromSuperview()
       }
      }
    }
  }
}
