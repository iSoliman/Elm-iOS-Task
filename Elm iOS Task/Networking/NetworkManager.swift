//
//  NetworkManager.swift
//  Elm iOS Task
//
//  Created by Islam Soliman on 21/09/2024.
//

import Alamofire
import Combine

protocol NetworkManager {

    func fetchText(with requestBuilder: RequestBuilder) async throws -> String
    func fetchData<T: Codable>(_ type: T.Type, with requestBuilder: RequestBuilder) async throws -> T
}

//TODO: remove redundunt code in NetworkManagerImp
class NetworkManagerImp: NetworkManager {

    static let shared = NetworkManagerImp()
    private let baseURL = "https://ba4caf56-6e45-4662-bbfb-20878b8cd42e.mock.pstmn.io"

    private init() {}

    func fetchText(with requestBuilder: RequestBuilder) async throws -> String {
        let url = "\(self.baseURL)\(requestBuilder.url)"
        let method = MethodTypeMapper.map(methodType: requestBuilder.methodType)
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url, method: method, parameters: requestBuilder.params, encoding: JSONEncoding.default)
                .validate()
                .responseString { response in
                    switch response.result {
                    case .success(let obj):
                        continuation.resume(returning: obj)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }

    
    func fetchData<T: Codable>(_ type: T.Type, with requestBuilder: RequestBuilder) async throws -> T {
        let url = "\(self.baseURL)\(requestBuilder.url)"
        let method = MethodTypeMapper.map(methodType: requestBuilder.methodType)
        let header = headers(for: requestBuilder)
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url, method: method, parameters: requestBuilder.params, encoding: JSONEncoding.default, headers: header)
                .validate()
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let objResponse):
                        continuation.resume(returning: objResponse)
                        print("////////////////////////////////////////////////")
                    case .failure(let error):
                        continuation.resume(throwing: error)
                        print("////////////////////////////////////////////////")
                    }
                }
        }
    }

    private func headers(for requestBuilder: RequestBuilder) -> HTTPHeaders?{
        guard
            requestBuilder.requiresAuthorization,
            let token = AuthenticationHelper.shared.retrieveToken()
        else { return nil }
        return ["Authorization": "Bearer \(token)"]
    }
}

