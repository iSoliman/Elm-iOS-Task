//
//  AppView.swift
//  Elm iOS Task
//
//  Created by Islam Soliman on 21/09/2024.
//

import SwiftUI

struct AppView: View {
    
    @State var isLoggedIn = false
    
    var body: some View {
        Group {
            if isLoggedIn {
                HomeView()
            } else {
                LoginView()
                    .onPreferenceChange(IsAuthorizedPreference.self) { value in
                        withAnimation {
                            isLoggedIn = value
                        }
                    }
            }
        }
        
    }
}

#Preview {
    AppView()
}
