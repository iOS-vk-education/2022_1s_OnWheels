//
//  RacesNetworkManager.swift
//  OnWheels
//
//  Created by Veronika on 25.12.2022.
//

import Foundation
protocol RacesNetworkManager {
    func getAllRaces(completion: @escaping(_ races: [Races]?, _ error: String?)->())
    func getRace(with id: Int, completion: @escaping(_ race: OneRace?, _ error: String?)->())
}

final class RacesNetworkManagerImpl: NetworkManager, RacesNetworkManager {
    private let router: Router<RaceEndPoint>
    
    init(router: Router<RaceEndPoint>) {
        self.router = router
    }

    func getAllRaces(completion: @escaping ([Races]?, String?) -> ()) {
        router.request(.getAllRaces) { data, response, error in
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        let apiResponse = try JSONDecoder().decode(Races.self, from: responseData)
                        completion([apiResponse.self], nil)
                    } catch {
                        
                    }
                case .failure(let failure):
                    completion(nil, NetworkResponse.failed.rawValue)
                }
            }
            
        }
    }
    
    func getRace(with id: Int, completion: @escaping (OneRace?, String?) -> ()) {
        print("")
    }
}