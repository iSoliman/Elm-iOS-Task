//
//  LoginView.swift
//  Elm iOS Task
//
//  Created by Islam Soliman on 21/09/2024.
//

import SwiftUI

struct IsAuthorizedPreference: PreferenceKey {

    typealias Value = Bool
    static var defaultValue = false

    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
    }
}

struct LoginView: View {

    //MARK: private
    @FocusState private var usernameIsFocused: Bool
    @ObservedObject private var viewModel = LoginViewModel()
    @State private var username = ""
    @State var isAuthorizedUser = false

    var body: some View {
        VStack {
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 16)
                .focused($usernameIsFocused)
            Button(action: {
                usernameIsFocused = false
                viewModel.login(with: username)
            }) {
                Text("Login")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.isLogging ? Color.gray : Color.blue)
                    .cornerRadius(10)
            }
            .disabled(viewModel.isLogging)
        }
        .sheet(isPresented: $viewModel.isLoggedIn, content: {
            VerificationView(viewModel: .init(email: username), isAuthorized: $isAuthorizedUser)
        })
        .errorAlert(isPresented: $viewModel.isShowingError, errorMessage: viewModel.errorMessage)
        .preference(key: IsAuthorizedPreference.self, value: isAuthorizedUser)
        .padding(32)
    }
}

#Preview {
    LoginView()
}
