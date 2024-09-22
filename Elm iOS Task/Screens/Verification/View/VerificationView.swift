//
//  VerificationView.swift
//  Elm iOS Task
//
//  Created by Islam Soliman on 21/09/2024.
//

import SwiftUI

struct VerificationView: View {

    //MARK: Private
    @ObservedObject private var viewModel: VerificationViewModel
    @State private var otp: [String] = Array(repeating: "", count: 4)
    @FocusState private var focusedField: Int?
    @Binding private var isAuthorized: Bool

    //MARK: Initializer
    init(viewModel: VerificationViewModel, isAuthorized: Binding<Bool>) {
        self.viewModel = viewModel
        _isAuthorized = isAuthorized
    }

    //MARK: Body
    var body: some View {
        Group {
            if viewModel.isVerifing {
                LoaderView()
            } else {
                verificationView
            }
        }
        .onChange(of: viewModel.isAuthorized) { _, newValue in
            isAuthorized = newValue
        }
    }

    var verificationView: some View {
        VStack {
            Text("Enter the 4-digit code")
                .font(.headline)
                .padding(.bottom, 20)
            verificationTextFields
        }
        .padding()
        .onAppear {
            focusedField = 0
        }
        .errorAlert(isPresented: $viewModel.isShowingError, errorMessage: viewModel.errorMessage)
    }

    var verificationTextFields: some View {
        HStack(spacing: 15) {
            ForEach(0..<4, id: \.self) { index in
                TextField("", text: $otp[index])
                    .keyboardType(.numberPad)
                    .multilineTextAlignment(.center)
                    .frame(width: 50, height: 50)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5)
                    .focused($focusedField, equals: index)
                    .onChange(of: otp[index]) { _, newValue in
                        if newValue.count > 1 {
                            otp[index] = String(newValue.prefix(1))
                        }
                        if newValue.count == 1 && index < 3 {
                            focusedField = index + 1
                        } else if newValue.count == 1 && index == 3 {
                            focusedField = nil
                            viewModel.verify(otp: otp.reduce("", +))
                        } else if newValue.isEmpty && index > 0 {
                            focusedField = index - 1
                        }
                    }
                    .onTapGesture {
                        focusedField = index
                    }
            }
        }
    }
}

#Preview {
    VerificationView(
        viewModel: .init(email: "user@elm.com"),
        isAuthorized: .constant(false))
}
