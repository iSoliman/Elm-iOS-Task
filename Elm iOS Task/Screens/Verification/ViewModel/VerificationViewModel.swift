//
//  VerificationViewModel.swift
//  Elm iOS Task
//
//  Created by Islam Soliman on 21/09/2024.
//

import Foundation

class VerificationViewModel: ObservableObject {

    //MARK: Private
    private var email: String
    private var networking: NetworkManager

    //MARK: Internal
    @Published var isAuthorized = false
    @Published var isVerifing = false
    @Published var isShowingError = false
    var errorMessage = ""

    init(email: String, networking: NetworkManager = NetworkManagerImp.shared) {
        self.email = email
        self.networking = networking
    }

    func verify(otp: String) {
        isVerifing = true
        Task {
            do {
                let requestBuilder = VerifyOTPRequestBuilder(otp: otp, email: email)
                let verifyToken = try await networking.fetchData(VerifyOTP.self, with: requestBuilder)
                await userVerified(with: verifyToken)
            } catch {
                await handleVerifyError(error)
            }
        }
    }

    @MainActor
    func handleVerifyError(_ error: Error) {
        isVerifing = false
        handleError(error)
    }

    @MainActor
    func userVerified(with verifyToken: VerifyOTP) {
        isVerifing = false
        if AuthenticationHelper.shared.saveToken(verifyToken.token) {
            isAuthorized = true
        } else {
            let error = NSError(
                domain: "",
                code: 0,
                userInfo: [NSLocalizedDescriptionKey: String.saveTokenError])
            handleError(error)
        }
    }
}

extension VerificationViewModel: ErrorAlertType { }

fileprivate extension String {

    static let saveTokenError = "We couldn't save your information securely. Please try again later. If the problem persists, contact support for assistance."
}
