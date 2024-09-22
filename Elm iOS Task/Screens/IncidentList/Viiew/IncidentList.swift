//
//  HomeView.swift
//  Elm iOS Task
//
//  Created by Islam Soliman on 21/09/2024.
//

import SwiftUI

struct IncidentList: View {

    @ObservedObject var viewModel: IncidentListViewModel
    @State private var selectedStatus: IncidentStatus? = nil
    @State private var isShowingAddIncident = false
    @State private var selectedIncident: Incident? = nil

    init(incidents: [Incident]) {
        viewModel = IncidentListViewModel(allIncidents: incidents)
    }

    var body: some View {
        ZStack {
            VStack {
                statusFilters
                    .padding(.bottom, 8)
                incidentListView
            }
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    addIncidentButton
                }
            }
        }
        .sheet(isPresented: $isShowingAddIncident, content: {
            IncidentFormView(mode: .add)
        })
    }

    var statusFilters: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(IncidentStatus.allCases, id: \.self) { status in
                    Button(action: {
                        selectedStatus = (selectedStatus == status) ? nil : status
                        viewModel.filter(by: selectedStatus)
                    }) {
                        Text(status.rawValue)
                            .padding(8)
                            .background(selectedStatus == status ? Color.blue : Color.gray.opacity(0.2))
                            .foregroundColor(selectedStatus == status ? .white : .black)
                            .cornerRadius(8)
                    }
                }
            }
            .padding()
        }
    }

    var incidentListView: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(viewModel.presentedIncidents, id: \.description) { incident in
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text(incident.description)
                                .lineLimit(2)
                            Spacer()
                        }
                        Text("Status: \(incident.statusText.rawValue)")
                        Text(incident.createdAt)
                    }
                    .sheet(item: $selectedIncident) { incident in
                        IncidentFormView(mode: .edit(incident: incident))
                    }
                    .padding(8)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.bottom, 8)
                    .padding(.horizontal, 16)
                    .onTapGesture { selectedIncident = incident }
                }
            }
        }
    }

    var addIncidentButton: some View {
        Button(action: {
            isShowingAddIncident = true
        }) {
            Image(systemName: "plus")
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Circle())
                .shadow(radius: 5)
        }
        .padding()
        .padding(.trailing, 20)
    }
}

#Preview {
    IncidentList(incidents: [])
}
