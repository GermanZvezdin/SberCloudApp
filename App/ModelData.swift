//
//  ModelData.swift
//  Custom TabView
//
//  Created by Alex on 27.02.2021.
//

import SwiftUI
import Foundation

final class AddData: ObservableObject {
    @Published var AddState: Bool = false
    @Published var AddArray: [String] = []
}

final class MetricsData: ObservableObject {
    @Published var VmName = "704f4c9a-d38d-46d2-98b6-94585a66fc51"
    
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
    
    @Published var MetricsMode : [MetricDetail] = [
        MetricDetail(id: 0, MetricName: "cpu_usage", MetricColor: "dark", Data: [], State: false, Size: CGSize(width: 130, height: 130)),
        MetricDetail(id: 1, MetricName: "load_average5", MetricColor: "light", Data: [], State: false, Size: CGSize(width: 130, height: 130)),
        MetricDetail(id: 2, MetricName: "mem_usedPercent", MetricColor: "dark", Data: [], State: false, Size: CGSize(width: 130, height: 130)),
        MetricDetail(id: 3, MetricName: "mountPointPrefix_disk_free", MetricColor: "dark", Data: [], State: false, Size: CGSize(width: 130, height: 130)),
        MetricDetail(id: 4, MetricName: "mountPointPrefix_disk_usedPercent", MetricColor: "light", Data: [], State: false, Size: CGSize(width: 130, height: 130)),
        MetricDetail(id: 5, MetricName: "disk_ioUtils", MetricColor: "dark", Data: [], State: false, Size: CGSize(width: 130, height: 130)),
        MetricDetail(id: 6, MetricName: "disk_inodesUsedPercent", MetricColor: "dark", Data: [], State: false, Size: CGSize(width: 130, height: 130)),
        MetricDetail(id: 7, MetricName: "net_bitSent", MetricColor: "light", Data: [], State: false, Size: CGSize(width: 130, height: 130)),
        MetricDetail(id: 8, MetricName: "net_bitRecv", MetricColor: "dark", Data: [], State: false, Size: CGSize(width: 130, height: 130)),
        MetricDetail(id: 9, MetricName: "net_packetRecv", MetricColor: "dark", Data: [], State: false, Size: CGSize(width: 130, height: 130)),
        MetricDetail(id: 10, MetricName: "net_packetSent", MetricColor: "light", Data: [], State: false, Size: CGSize(width: 130, height: 130)),
        MetricDetail(id: 11, MetricName: "net_tcp_total", MetricColor: "dark", Data: [], State: false, Size: CGSize(width: 130, height: 130)),
        MetricDetail(id: 12, MetricName: "net_tcp_established", MetricColor: "dark", Data: [], State: false, Size: CGSize(width: 130, height: 130))
    ]
    
    public func GetData(token: String, Mode: String, size: String) {
        if size == "small" {
            self.MetricsMode[self.MetricIds[Mode]!].Size = CGSize(width: 140, height: 140)
        } else if (size == "long") {
            self.MetricsMode[self.MetricIds[Mode]!].Size = CGSize(width: 300, height: 130)
        } else if (size == "big") {
            self.MetricsMode[self.MetricIds[Mode]!].Size = CGSize(width: 300, height: 300)
        }
        let t = time(nil) * 1000
        SberCloudApiGetMetrics(token: token, VmName:VmName, Mode:Mode, TimeL:0, TimeH:t, Period:1200, Filter:"max") {
            (data, flag) in
                if flag {
                    DispatchQueue.main.async {
                        self.MetricsMode[self.MetricIds[Mode]!].Data = data
                        self.MetricsMode[self.MetricIds[Mode]!].State = true
                    }
                }
        }
    }
}

struct MetricDetail: Identifiable {
    let id : Int
    let MetricName: String
    var MetricColor: String
    var Data: [Double]
    var State: Bool
    var Size: CGSize
}
