//
//  ProfileContainer.swift
//  OnWheels
//
//  Created by Veronika on 29.10.2022.
//  
//

import UIKit

final class ProfileContainer {
    let input: ProfileModuleInput
    let viewController: UIViewController
    private(set) weak var router: ProfileRouterInput!
    
    static func assemble(with context: ProfileContext) -> ProfileContainer {
        let router = ProfileRouter()
        let networkRouter = Router<UserEndPoint>()
        let userManager = UserNetworkManagerImpl(router: networkRouter)
        let interactor = ProfileInteractor(userManager: userManager)
        let presenter = ProfilePresenter(router: router, interactor: interactor)
        let viewController = ProfileViewController(output: presenter)
        
        presenter.view = viewController
        router.window = context.window
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        
        return ProfileContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: ProfileModuleInput, router: ProfileRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct ProfileContext {
    weak var moduleOutput: ProfileModuleOutput?
    let window: UIWindow
}
