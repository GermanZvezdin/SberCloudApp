//
//  AddMetric.swift
//  Custom TabView
//
//  Created by Alex on 27.02.2021.
//

import SwiftUI

struct AddMetric: View {
    @ObservedObject var AData: AddData
    @EnvironmentObject var MetricData: MetricsData
    
    @Binding var isShow: Bool
    var sizes = ["small", "large", "long"]
    
    @AppStorage("X-Subject-Token") var Token = ""
    
    var MetricIds:[String:Int] = [
        "cpu_usage":0,
        "load_average5":1,
        "mem_usedPercent":2,
        "mountPointPrefix_disk_free":3,
        "mountPointPrefix_disk_usedPercent":4,
        "disk_ioUtils":5,
        "disk_inodesUsedPercent":6,
        "net_bitSent":7,
        "net_bitRecv":8,
        "net_packetRecv":9,
        "net_packetSent":10,
        "net_tcp_total":11,
        "net_tcp_established":12,
    ]
    
    @State private var selectedMetric = "cpu_usage"
    @State private var selectedSize = "small"
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading){
                    Text("Cloud Eye")
                        .fontWeight(.light)
                    Text("Add graph to my Panel")
                        .font(.title)
                        .fontWeight(.bold)
                }
                .padding(30)
                Spacer()
            }
            
            HStack{
                Text("Choose the Metric")
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(.leading, 30)
            
            HStack{
                Text("ResourceType")
                    .fontWeight(.light)
                Spacer()
            }
            .padding(.leading, 30)
            
            HStack{
                Menu {
                    
                    ForEach(MetricData.MetricsMode) { data in
                        Button(action: {
                            selectedMetric = data.MetricName
                        }) {
                            Text(data.MetricName)
                        }
                        .frame(width: 350, height: 50)
                    }
                    
                } label: {
                    Text("\(selectedMetric)")
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                    .frame(width: 350, height: 100)
                }
                Spacer()
                
            }
            .frame(width: 350, height: 50)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.black, lineWidth: 3)
            )
                
            HStack {
                Text("Dimesion")
                    .fontWeight(.light)
                Spacer()
            }
            .padding(.leading, 30)
            
            HStack{
                Menu {
                    
                    ForEach(MetricData.MetricsMode) { data in
                        Button(action: {
                            selectedMetric = data.MetricName
                        }) {
                            Text(data.MetricName)
                        }
                        .frame(width: 350, height: 50)
                    }
                    
                } label: {
                    Text("\(selectedMetric)")
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                    .frame(width: 350, height: 100)
                }
                Spacer()
                
            }
            .frame(width: 350, height: 50)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.black, lineWidth: 3)
            )
            HStack {
                Text("Choose Metric")
                    .fontWeight(.light)
                Spacer()
            }
            .padding(.leading, 30)
            
            
            HStack{
                Menu {
                    
                    ForEach(MetricData.MetricsMode) { data in
                        Button(action: {
                            selectedMetric = data.MetricName
                        }) {
                            Text(data.MetricName)
                        }
                        .frame(width: 350, height: 50)
                    }
                    
                } label: {
                    Text("\(selectedMetric)")
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                    .frame(width: 350, height: 100)
                }
                Spacer()
                
            }
            .frame(width: 350, height: 50)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.black, lineWidth: 3)
            )
            
            
            
            Spacer()
            
            Button(action: {
                AData.AddArray.append(selectedMetric)
                AData.AddState.toggle()
                isShow.toggle()
                for mode in AData.AddArray{
                    MetricData.GetData(token: Token, Mode: mode, size: "long")
                }
            }) {
                Text("ADD TO MY PANEL")
                    .foregroundColor(Color.black)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .frame(width: 350, height: 50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.black.opacity(0.3))
                    )
            }
            
            
        }
    }
}
