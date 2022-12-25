//
//  UserNetworkManager.swift
//  OnWheels
//
//  Created by Veronika on 24.12.2022.
//

import Foundation

enum AuthStatus {
    case authorized(accsessToken: String)
    case nonAuthorized(error: String)
}


protocol UserNetworkManager {
    func login(email: String, password: String, completion: @escaping (AuthStatus) -> ())
    func register(surname: String,
                  name: String,
                  email: String,
                  password: String,
                  city: String,
                  birthday: Date,
                  sex: Int, completion: @escaping (AuthStatus) -> ())
}

final class UserNetworkManagerImpl: NetworkManager, UserNetworkManager {
    private let router: Router<UserEndPoint>
    
    init(router: Router<UserEndPoint>) {
        self.router = router
    }

    func register(surname: String,
                  name: String,
                  email: String,
                  password: String,
                  city: String,
                  birthday: Date,
                  sex: Int,
                  completion: @escaping (AuthStatus) -> ()) {
        router.request(.register(surname: surname,
                                 name: name,
                                 email: email,
                                 password: password,
                                 city: city,
                                 birthday: birthday,
                                 sex: sex)) { data, response, error in
            if error != nil {
                completion(.nonAuthorized(error: "Check your connection"))
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
//                    completion(.authorized)
                    break
                case .failure(_):
                    completion(.nonAuthorized(error: "Something is wrong"))
                }
            }
        }
    }
    
    func login(email: String, password: String, completion: @escaping (AuthStatus) -> ()) {
        router.request(.login(email: email, password: password)) { data, response, error in
            if error != nil {
                completion(.nonAuthorized(error: "Check your connection"))
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(.nonAuthorized(error: NetworkResponse.noData.rawValue))
                        return
                    }
                    do {
                        DispatchQueue.main.async {
                            let apiResponse = HTTPCookieStorage.shared.cookies?.first(where: { cookie in
                                return cookie.name == ".AspNetCore.Session"
                            })?.value ?? ""
                            completion(.authorized(accsessToken: apiResponse))
                        }
                    } catch {
                        completion(.nonAuthorized(error: NetworkResponse.unableToDecode.rawValue))
                    }
                case let .failure(reason):
                    completion(.nonAuthorized(error: reason))
                }
            }
        }
    }
}