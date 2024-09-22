//
//  LoginViewModel.swift
//  Elm iOS Task
//
//  Created by Islam Soliman on 21/09/2024.
//

import Foundation

final class LoginViewModel: ObservableObject {

    //MARK: Private
    private let networking: NetworkManager

    //MARK: Internal
    @Published var isLogging = false
    @Published var isLoggedIn = false
    @Published var isShowingError = false
    var errorMessage = ""

    init(networking: NetworkManager = NetworkManagerImp.shared) {
        self.networking = networking
    }

    func login(with username: String) {
        isLogging = true
        Task {
            do {
                _ = try await networking.fetchText(with: LoginResultBuilder(username: username))
                await userIsLoggedIn()
            } catch {
                await handleError(error)
            }
        }
    }

    @MainActor
    private func userIsLoggedIn() {
        isLoggedIn = true
        isLogging = false
    }
}

extension LoginViewModel: ErrorAlertType {}
