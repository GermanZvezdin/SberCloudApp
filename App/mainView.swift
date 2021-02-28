//
//  ContentView.swift
//  Custom TabView
//
//  Created by Alex on 26.02.2021.
//

import SwiftUI


struct mainView: View {
    @State var index = 0
    @AppStorage("X-Subject-Token") var Token = ""
    @AppStorage("pin_status") var pinned = false
    @AppStorage("username") var username = ""
    @AppStorage("password") var password = ""
    @ObservedObject var MetricData: MetricsData = MetricsData()
    @StateObject var AData: AddData = AddData()
    @State var PlusButton: Bool = false
    
    init() {
        MetricData.GetData(token: Token, Mode: "cpu_usage", size: "long")
        MetricData.GetData(token: Token, Mode: "load_average5", size: "long")
        MetricData.GetData(token: Token, Mode: "mem_usedPercent", size: "long")
        MetricData.GetData(token: Token, Mode: "mountPointPrefix_disk_free", size: "long")
        MetricData.GetData(token: Token, Mode: "mountPointPrefix_disk_usedPercent", size: "long")
        MetricData.GetData(token: Token, Mode: "disk_ioUtils", size: "long")
        MetricData.GetData(token: Token, Mode: "disk_inodesUsedPercent", size: "long")
        MetricData.GetData(token: Token, Mode: "net_bitSent", size: "long")
        MetricData.GetData(token: Token, Mode: "net_bitRecv", size: "long")
        MetricData.GetData(token: Token, Mode: "net_packetRecv", size: "long")
        MetricData.GetData(token: Token, Mode: "net_packetSent", size: "long")
        MetricData.GetData(token: Token, Mode: "net_tcp_total", size: "long")
        MetricData.GetData(token: Token, Mode: "net_tcp_established", size: "long")
    }

    
    var body: some View {
        VStack {
            ScrollView{
                
                if self.index == 1 {
                    OverviewView(data: $MetricData.MetricsMode)
                }
                if (self.index == 2 &&  AData.AddArray.count == 0){
                    MypanelView(AData: AData, MetricData: MetricData)
                        .environmentObject(AddData())
                        .environmentObject(MetricsData())
                }
                if (AData.AddState && self.index==2){
                    MypanelView(AData: AData,MetricData: MetricData)
                        .environmentObject(AddData())
                        .environmentObject(MetricsData())
                }
                
                if self.index == 0 {
                    HomeView()
                }
                

            }
            
            Spacer()
            CustomTable(index: $index, PlusButton: $PlusButton, AData: AData)
                .environmentObject(AddData())
                .environmentObject(MetricsData())
                
        }
        .background(
            Color("Font")
                .edgesIgnoringSafeArea(.top)
        )
        .preferredColorScheme(.light)
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

struct mainView_Previews: PreviewProvider {
    static var previews: some View {
        mainView()
    }
}
