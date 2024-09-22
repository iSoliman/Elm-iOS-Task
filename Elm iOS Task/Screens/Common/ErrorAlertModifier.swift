//
//  ErrorAlertModifier.swift
//  Elm iOS Task
//
//  Created by Islam Soliman on 22/09/2024.
//

import SwiftUI

protocol ErrorAlertType: AnyObject {

    var isShowingError: Bool { get set }
    var errorMessage: String { get set }

    func handleError(_ error: Error)
}

extension ErrorAlertType {

    @MainActor
    func handleError(_ error: Error) {
        isShowingError = true
        errorMessage = error.localizedDescription
    }
}

struct ErrorAlertModifier: ViewModifier {
    @Binding var isPresented: Bool
    var errorMessage: String
    
    func body(content: Content) -> some View {
        content
            .alert(isPresented: $isPresented) {
                Alert(
                    title: Text("Error"),
                    message: Text(errorMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
    }
}

// Extension to make it easier to use
extension View {
    func errorAlert(isPresented: Binding<Bool>, errorMessage: String) -> some View {
        self.modifier(ErrorAlertModifier(isPresented: isPresented, errorMessage: errorMessage))
    }
}
