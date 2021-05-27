//
//  ViewController.swift
//  QuickActions
//
//  Created by Alex on 26/05/21.
//

import UIKit

let quickActionNotificationName = NSNotification.Name(rawValue: "Quick Action")
class ViewController: UIViewController {
    @IBOutlet weak var lblShortcutLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(handleShortcutNotification(notification:)), name: quickActionNotificationName, object: nil)
    }

    @objc private func handleShortcutNotification(notification: Notification) {
        if let shortCutType = notification.userInfo?["shortCutType"] as? ShortcutType {
            switch shortCutType {
            case .staticAction:
                lblShortcutLabel.text = "Shortcut item: Static Action"
            case .dynamicAction:
                lblShortcutLabel.text = "Shortcut item: Dynamic Action"
            }
        }
    }
    
    @IBAction func addDynamicButtonAction(_ sender: Any) {
        let icon = UIApplicationShortcutIcon(systemImageName: "pencil")
        if let newQuickAction = createShortcutItem(shortcutTitle: "Dynamic Action",
                                                   type: ShortcutType.dynamicAction.rawValue,
                                                   icon: icon) {
            var existingShortcutItems = UIApplication.shared.shortcutItems ?? []
            if !existingShortcutItems.contains(newQuickAction) {
                existingShortcutItems.append(newQuickAction)
                UIApplication.shared.shortcutItems = existingShortcutItems
                showAlert(message: "Dynamic Action added")
            } else {
                showAlert(message: "Dynamic Action already present")
            }
        }
    }
    
    @IBAction func removeShortcutAction(_ sender: Any) {
        let icon = UIApplicationShortcutIcon(systemImageName: "pencil")
        if let newQuickAction = createShortcutItem(shortcutTitle: "Dynamic Action",
                                                   type: ShortcutType.dynamicAction.rawValue,
                                                   icon: icon) {
            var existingShortcutItems = UIApplication.shared.shortcutItems ?? []
            if existingShortcutItems.contains(newQuickAction) {
                existingShortcutItems.removeAll { $0 == newQuickAction }
                UIApplication.shared.shortcutItems = existingShortcutItems
                showAlert(message: "Dynamic Action Removed")
            } else {
                showAlert(message: "Dynamic Action not present")
            }
        }
    }
    private func showAlert(title: String = "Quick Actions", message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok",
                                     style: .default,
                                     handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func createShortcutItem(shortcutTitle: String, type: String, subtitle: String? = nil, icon: UIApplicationShortcutIcon? = nil, userInfo: [String: NSSecureCoding]? = nil) -> UIApplicationShortcutItem? {
        if let bundleId = Bundle.main.bundleIdentifier {
            let type = bundleId + "." + type
            return UIApplicationShortcutItem(type: type,
                                             localizedTitle: shortcutTitle,
                                             localizedSubtitle: subtitle,
                                             icon: icon,
                                             userInfo: userInfo)
        } else {
            print("Bundle-Id is missing")
        }
        return nil
    }
}

