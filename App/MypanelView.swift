//
//  MypanelView.swift
//  Custom TabView
//
//  Created by Alex on 27.02.2021.
//

import SwiftUI


struct MypanelView: View {
    @StateObject var AData: AddData
    @State var PlusButton = false
    @ObservedObject var MetricData: MetricsData = MetricsData()
    @AppStorage("X-Subject-Token") var Token = ""
    var body: some View {
        ZStack{
            VStack {
                if AData.AddArray.count > 0 {
                    ForEach(AData.AddArray.indices) {ind in
                        CardMetricView(data: MetricData.MetricsMode[MetricData.MetricIds[AData.AddArray[ind]]!])
                    }
                }
            }
        
        .onDisappear{
            AData.AddState.toggle()
        }
        .onAppear {
            SberCloudApiGetVMNames(token: Token) {
                (res) in
                DispatchQueue.main.async {
                    MetricData.VmName = res[0]
                }
            }
        }
        }
}
}
