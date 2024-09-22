//
//  HomeView.swift
//  Elm iOS Task
//
//  Created by Islam Soliman on 22/09/2024.
//

import SwiftUI

struct HomeView: View {

    @ObservedObject var viewModel = HomeViewModel()

    var body: some View {
        Group {
            if viewModel.incidents.isEmpty {
                LoaderView()
            } else {
                homeView
            }
        }
        .onAppear { viewModel.fetchIncidents() }
        .errorAlert(isPresented: $viewModel.isShowingError, errorMessage: viewModel.errorMessage)
    }

    var homeView: some View {
        TabView {
            IncidentList(incidents: viewModel.incidents)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Incidents")
                }
            ChartView(incidents: viewModel.incidents)
                .tabItem {
                    Image(systemName: "chart.bar.xaxis")
                    Text("Charts")
                }
        }
    }
}

#Preview {
    HomeView()
}
