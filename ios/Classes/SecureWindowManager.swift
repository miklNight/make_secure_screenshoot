import UIKit
/*

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
}*/
