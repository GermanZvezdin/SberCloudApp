//
//  CardMetricView.swift
//  Custom TabView
//
//  Created by Alex on 27.02.2021.
//

import SwiftUI


struct CardMetricView: View {
   var data: MetricDetail
    
    var body: some View {
        if data.State != true {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(data.MetricColor != "dark" ? Color.white: Color("DarkChart"))
                    .frame(width: data.Size.width*1.2, height: data.Size.height*1.2, alignment: .center)
                    .shadow(color: Color.black.opacity(0.2), radius: 4)
                Text("loading")
            }
            .padding(5)
        } else {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(data.MetricColor != "dark" ? Color.white: Color("DarkChart"))
                    .frame(width: data.Size.width*1.2, height: data.Size.height*1.2, alignment: .center)
                    .shadow(color: Color.black.opacity(0.2), radius: 4)
                LineChartView(
                    data: data.Data,
                    title: data.MetricName,
                    legend: "\(data.Data.last ?? 0)%",
                    form: data.Size,
                    color: data.MetricColor)
            }
            .padding(5)
        }
    }
}
