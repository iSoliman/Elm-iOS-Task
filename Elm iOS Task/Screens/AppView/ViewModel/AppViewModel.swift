//
//  AppViewModel.swift
//  Elm iOS Task
//
//  Created by Islam Soliman on 21/09/2024.
//

import Foundation

final class AppViewModel {

    let isUserLoggedIn: Bool

    init() {
        isUserLoggedIn = AuthenticationHelper.shared.retrieveToken() != nil
    }
}
