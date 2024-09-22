//
//  LoaderView.swift
//  Elm iOS Task
//
//  Created by Islam Soliman on 22/09/2024.
//

import SwiftUI

struct LoaderView: View {

    var body: some View {
        VStack {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .scaleEffect(2)
                .padding()
            Text("Loading...")
                .font(.headline)
                .padding(.top, 10)
        }
    }
}

#Preview {
    LoaderView()
}
