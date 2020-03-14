//
//  APIRequestManager.swift
//  TopPop
//
//  Created by five on 14/03/2020.
//  Copyright © 2020 Pero. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit
import CodableAlamofire

class APIManager {
    static func request<T: Decodable>(_ type: T.Type,
                                      path: String,
                                      parameters: Parameters? = nil,
                                      encoding: ParameterEncoding = JSONEncoding.default,
                                      decoder: JSONDecoder = JSONDecoder(),
                                      headers: HTTPHeaders? = nil) -> Promise<T> {
        
        return Promise { promise in
            Alamofire
                .request(
                path,
                method: HTTPMethod.get)
                .validate()
                .responseDecodableObject(completionHandler: <#(DataResponse<T>) -> Void#>)
        }
    }
}
