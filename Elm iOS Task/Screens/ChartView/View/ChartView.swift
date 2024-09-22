//
//  ChartView.swift
//  Elm iOS Task
//
//  Created by Islam Soliman on 22/09/2024.
//

import SwiftUI
import Charts

struct ChartView: View {

    let incidents: [Incident]

    var statusCount: [IncidentStatus: Int] {
        Dictionary(grouping: incidents, by: { $0.statusText })
            .mapValues { $0.count }
    }

    init(incidents: [Incident]) {
        self.incidents = incidents
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Text("Incidents by Status")
                    .font(.title2)
                Chart {
                    ForEach(IncidentStatus.allCases, id: \.self) { status in
                        BarMark(
                            x: .value("Status", status.rawValue),
                            y: .value("Count", statusCount[status] ?? 0)
                        )
                        .foregroundStyle(by: .value("Status", status.rawValue))
                    }
                }
                .frame(height: 250)
                .padding()
                
                // Incident Status Distribution - Pie Chart
                Text("Incident Status Distribution")
                    .font(.title2)
                
                Chart {
                    ForEach(IncidentStatus.allCases, id: \.self) { status in
                        if let count = statusCount[status], count > 0 {
                            SectorMark(
                                angle: .value("Count", Double(count)),
                                innerRadius: .ratio(0.5),
                                angularInset: 1
                            )
                            .foregroundStyle(by: .value("Status", status.rawValue))
                        }
                    }
                }
                .frame(height: 250)
                .padding()
            }
        }
    }
}

#Preview {
    ChartView(incidents: [])
}
