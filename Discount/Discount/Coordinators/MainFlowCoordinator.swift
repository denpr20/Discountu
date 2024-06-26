import UIKit

protocol MainFlowCoordinatorProtocol: AnyObject {
    func mainFlowSignOutUser()
}

// MARK: Логика старта главного потока приложения

class MainFlowCoordinator: Coordinator {
    var navigationController: UINavigationController
    private var mainFlowCoordinatorProtocol: MainFlowCoordinatorProtocol?

    init(navigationController: UINavigationController, mainFlowCoordinatorProtocol: MainFlowCoordinatorProtocol) {
        self.navigationController = navigationController
        self.mainFlowCoordinatorProtocol = mainFlowCoordinatorProtocol
    }

    func start() {
        CardService.shared.getCards()
        let mainViewController = MainModuleBuilder().build(output: self)
        navigationController.setViewControllers([mainViewController], animated: true)
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

    private func showProfileController() {
        let profileViewController = ProfileModuleBuilder().build()
        navigationController.pushViewController(profileViewController, animated: true)
    }

    func showContactUsController() {
        let contactUsViewController = ContactUsModuleBuilder().build()
        navigationController.pushViewController(contactUsViewController, animated: true)
    }

    private func showSettingsController() {
        let settingsController = SettingsModuleBuilder().build(output: self)
        navigationController.pushViewController(settingsController, animated: true)
    }
}

// MARK: Настройка для экрана добавления карты

extension MainFlowCoordinator: NewCardChoiseControllerDelegate {
    func showNewCardScreenByTag(_ tag: Int) {
        let newCardViewController = NewCardModuleBuilder().build()
        switch tag {
        case 1:
            newCardViewController.cardType = .qr
        case 2:
            newCardViewController.cardType = .code128
        default:
            break
        }
        navigationController.pushViewController(newCardViewController, animated: true)
    }
}
// MARK: Настройка для главного экрана

extension MainFlowCoordinator: MainViewOutput {
    func showNewCardController() {
        let newCardChoiseViewController = NewCardChoiseModuleBuilder().build()
        newCardChoiseViewController.delegate = self
        navigationController.pushViewController(newCardChoiseViewController, animated: true)
    }

    func showAboutAppController() {
        let aboutAppViewController = AboutAppModuleBuilder().build()
        aboutAppViewController.delegate = self
        navigationController.pushViewController(aboutAppViewController, animated: true)
    }
}

extension MainFlowCoordinator: SignOutOutput {
    func signedOutUser() {
        mainFlowCoordinatorProtocol?.mainFlowSignOutUser()
        CardService.shared.cleanCards()
        UserDefaults.standard.set("", forKey: "curUser")
    }
}
