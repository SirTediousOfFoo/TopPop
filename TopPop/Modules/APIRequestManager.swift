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
                                      keyPath: String = "",
                                      encoding: ParameterEncoding = JSONEncoding.default,
                                      decoder: JSONDecoder = JSONDecoder(),
                                      headers: HTTPHeaders? = nil) -> Promise<T> {
        
        return Promise { promise in
            Alamofire
                .request(
                path,
                method: HTTPMethod.get,
                parameters: parameters,
                encoding: encoding,
                headers: headers)
                .validate()
                .responseDecodableObject(
                    keyPath: keyPath,
                    decoder: decoder) { (response: DataResponse<T>) in
                        switch response.result {
                        case .success(let model):
                            promise.fulfill(model)
                        case .failure(let error):
                            promise.reject(error)
                        }
            }
        }
    }
}
