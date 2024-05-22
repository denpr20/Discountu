import UIKit

// MARK: Логика старта главного потока приложения

class MainFlowCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let mainViewController = MainModuleBuilder().build()
        mainViewController.delegate = self
        navigationController.pushViewController(mainViewController, animated: true)
    }
}

// MARK: Настройка для экрана "О Нас"

extension MainFlowCoordinator: AboutAppControllerDelegate {
    func showScreenByTag(_ tag: Int) {
        switch tag {
        case 1:
            showProfileController()
        case 2:
            showSettingsController()
        case 3:
            showContactUsController()
        default:
            break
        }
    }

    func showProfileController() {
        print("profile")
    }

    func showContactUsController() {
        print("contact us")
    }

    func showSettingsController() {
        print("settings")
    }
}

// MARK: Настройка для главного экрана

extension MainFlowCoordinator: MainViewControllerDelegate {
    func showAddCardController() {
        print("Add card")
    }

    func showAboutAppController() {
        let aboutAppViewController = AboutAppModuleBuilder().build()
        aboutAppViewController.delegate = self
        navigationController.pushViewController(aboutAppViewController, animated: true)
    }
}