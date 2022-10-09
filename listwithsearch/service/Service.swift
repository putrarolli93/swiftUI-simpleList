//
//  Service.swift
//  listwithsearch
//
//  Created by putra rolli on 09/10/22.
//

import Foundation
import Combine
import Alamofire

protocol ServiceProtocol {
    func fetchChats() -> AnyPublisher<DataResponse<[ListData], NetworkError>, Never>
}


class Service {
    static let shared: ServiceProtocol = Service()
    private init() { }
}

extension Service: ServiceProtocol {
    func fetchChats() -> AnyPublisher<DataResponse<[ListData], NetworkError>, Never> {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        
        return AF.request(url,method: .get)
        .validate()
        .publishDecodable(type: [ListData].self)
        .map { response in
            response.mapError { error in
                let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0)}
                return NetworkError(initialError: error, backendError: backendError)
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
