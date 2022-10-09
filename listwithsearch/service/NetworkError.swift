//
//  NetworkError.swift
//  listwithsearch
//
//  Created by putra rolli on 09/10/22.
//

import Foundation
import Alamofire

struct NetworkError: Error {
  let initialError: AFError
  let backendError: BackendError?
}

struct BackendError: Codable, Error {
    var status: String
    var message: String
}
