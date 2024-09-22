//
//  AuthenticationHelper.swift
//  Elm iOS Task
//
//  Created by Islam Soliman on 21/09/2024.
//

import Foundation

struct AuthenticationHelper {

    static let shared = AuthenticationHelper()

    private init() {}

    func saveToken(_ token: String) -> Bool {
        let data = token.data(using: .utf8)!
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: String.elmTokenKey,
            kSecValueData as String: data
        ]
        
        // Delete any existing items
        SecItemDelete(query as CFDictionary)
        
        // Add new item
        return SecItemAdd(query as CFDictionary, nil) == errSecSuccess
    }

    func retrieveToken() -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: String.elmTokenKey,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var dataTypeRef: AnyObject? = nil
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        guard status == errSecSuccess else { return nil }

        if let data = dataTypeRef as? Data {
            return String(data: data, encoding: .utf8)
        }

        return nil
    }
}

fileprivate extension String {

    static let elmTokenKey = "elmTokenKey"
}
