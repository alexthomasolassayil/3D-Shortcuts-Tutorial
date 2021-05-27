//
//  SceneDelegate.swift
//  QuickActions
//
//  Created by Alex on 26/05/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        if let shortCutItem = connectionOptions.shortcutItem {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                _ = self.handleShortcutItem(item: shortCutItem)
            }
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

    func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        completionHandler(handleShortcutItem(item: shortcutItem))
    }
    
    private func handleShortcutItem(item: UIApplicationShortcutItem) -> Bool {
        guard let shortcutType = item.type.components(separatedBy: ".").last else {
            return false
        }
        if let type = ShortcutType(rawValue: shortcutType) {
            switch type {
            case .staticAction:
                print("Static Action")
                NotificationCenter.default.post(name: quickActionNotificationName, object: nil, userInfo: ["shortCutType": ShortcutType.staticAction])
                return true
            case .dynamicAction:
                print("Dynamic Action")
                NotificationCenter.default.post(name: quickActionNotificationName, object: nil, userInfo: ["shortCutType": ShortcutType.dynamicAction])
                return true
            }
        }
        return false
    }
}

