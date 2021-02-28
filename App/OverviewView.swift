//
//  SwiftUIView.swift
//  Custom TabView
//
//  Created by Alex on 27.02.2021.
//

import SwiftUI


struct OverviewView: View {
    @Binding var data: [MetricDetail]
 
    var body: some View {
        ZStack{
            VStack {
                ForEach(data) {dataItem in
                    CardMetricView(data:dataItem)
                }
            }
        }
    }
}
