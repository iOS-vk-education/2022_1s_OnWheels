//
//  ProfilePresenter.swift
//  OnWheels
//
//  Created by Veronika on 29.10.2022.
//  
//

import Foundation

final class ProfilePresenter {
	weak var view: ProfileViewInput?
    weak var moduleOutput: ProfileModuleOutput?
    
	private let router: ProfileRouterInput
	private let interactor: ProfileInteractorInput
    
    init(router: ProfileRouterInput, interactor: ProfileInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension ProfilePresenter: ProfileModuleInput {
}

extension ProfilePresenter: ProfileViewOutput {
    func openChangeProfileScreen(){
        router.changeProfileInfoButtonTapped()
    }
}

extension ProfilePresenter: ProfileInteractorOutput {

}
