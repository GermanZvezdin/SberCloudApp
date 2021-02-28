//
//  Utils.swift
//  App
//
//  Created by German Zvezdin on 26.02.2021.
//

import SwiftUI

/*
func SberCloudApiPostData(login: String, pass: String, _ completion:@escaping (_ res: String, _ flag: Bool  )->Void) {
        
        
    let Data: [String: Any] = [
    "auth": [
        "identity": [
            "methods": [
                "password"
            ],
            "password": [
                "user": [
                    "name": "\(login)",
                    "password": "\(pass)",
                    "domain": [
                        "name": "\(login)"
                    ]
                ]
            ]
        ],
        "scope": [
            "project": [
                "name": "ru-moscow-1",
                "domain": [
                    "name": "RU-Moscow"
                ]
            ]
        ]
    ]
]

    let encoded: Data

    do {
        encoded = try JSONSerialization.data(withJSONObject: Data, options: JSONSerialization.WritingOptions()) as Data
        
        let url = URL(string: "https://iam.ru-moscow-1.hc.sbercloud.ru/v3/auth/tokens")!
        var request = URLRequest(url: url)
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        let body = encoded
        request.httpMethod = "POST"
        request.httpBody = body
        let session = URLSession.shared
        
        let task = session.dataTask(with: request){(data, response: URLResponse?, error) in
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 201 {
                    if let res = httpResponse.allHeaderFields["X-Subject-Token"] as? String {
                        completion(res, true)
                    } else {
                        completion("Error", false)
                    }
                        
                } else {
                    completion("Error", false)
                }
            }
        }
        
        task.resume()
    } catch _ {
        print ("JSON Failure")
        completion("Error", false)
    }
        
}

func SberCloudApiGetVMNames(token: String, _ completion:@escaping (_ id: [String])->Void) {
        
        
    let url = URL(string: "https://ces.ru-moscow-1.hc.sbercloud.ru/V1.0/0b96564a738027302fc7c01d7b2ff92b/metrics?namespace=SYS.ECS")!
    var request = URLRequest(url: url)
    request.setValue(
        "application/json",
        forHTTPHeaderField: "Content-Type"
    )
    request.httpMethod = "GET"
    request.addValue("\(token)", forHTTPHeaderField: "X-Auth-Token")
    
    let session = URLSession.shared
    
    let task = session.dataTask(with: request){(data, response: URLResponse?, error) in
        if let data = data {
            var res1: Set<String> = []
            var res2: [String] = []
            if let decodedOrder = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]  {
                let tmp = decodedOrder as NSDictionary
                 let tmp2 = tmp["metrics"] as! Array<NSDictionary>
                for i in tmp2 {
                    let tmp3 = i["dimensions"] as! Array<NSDictionary>
                    for j in tmp3 {
                        let value = j["value"] as! String
                        res1.insert(value)
                    }
                }
                for i in res1 {
                    res2.append(i)
                }
                completion(res2)
                
            } else {}
        } else {
            print("ERROR2")
        }
    }
    
    task.resume()
    
        
}


func SberCloudApiGetMetrics(token: String, VmName:String, Mode:String, TimeL: Int, TimeH: Int, Period: Int, Filter: String, _ completion:@escaping (_ data: [Double], _ status: Bool)->Void) {
        
    
    
    let url = URL(string: "https://ces.ru-moscow-1.hc.sbercloud.ru/V1.0/0b96564a738027302fc7c01d7b2ff92b/metric-data?namespace=AGT.ECS&metric_name=\(Mode)&dim.0=instance_id,\(VmName)&from=\(TimeL)&to=\(TimeH)&period=\(Period)&filter=\(Filter)")!
    var request = URLRequest(url: url)
    request.setValue(
        "application/json",
        forHTTPHeaderField: "Content-Type"
    )
    request.httpMethod = "GET"
    request.addValue("\(token)", forHTTPHeaderField: "X-Auth-Token")
    
    let session = URLSession.shared
    
    let task = session.dataTask(with: request){(data, response: URLResponse?, error) in
        if let data = data {
            
            var MassOfDate: [Double] = []
            if let decodedOrder = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]  {
                let tmp = decodedOrder as NSDictionary
                //print(tmp)
                if let array = try? tmp["datapoints"] as? Array<NSDictionary> {
                    for i in array {
                        if let val = try? i as? NSDictionary {
                            let v = val["max"] as? Double ?? 0.0
                            MassOfDate.append(v)
                            
                        } else {
                            completion([], false)
                        }
                    }
                    completion(MassOfDate, true)
                } else {
                    completion([], false)
                }
            } else {
                completion([], false)
            }
        } else {
            completion([], false)
        }
    }
    
    task.resume()
    
        
}

func CloudEyeGetMetrics(token: String, VmName:String, Mode:String, TimeL: Int, TimeH: Int, Period: Int, Filter: String) -> [Double]{
    var ans: [Double] = []
    let semaphore = DispatchSemaphore(value: 1)
    
    SberCloudApiGetMetrics(token: token, VmName: VmName, Mode: Mode, TimeL: TimeL, TimeH: TimeH, Period: Period, Filter: Filter) {
        (res, flag) in
            ans = res
        DispatchQueue.main.async {
            semaphore.signal()
        }
    }
    DispatchQueue.main.async {
        semaphore.wait()
    }
   // semaphore.wait()
    return ans
}




class MetricsData2: ObservableObject {
    struct VM {
        var Name:String
        var Metrics:[String:[Double]]
    }
    @Published var MetricsMode = ["cpu_usage", "load_average5", "mem_usedPercent", "mountPointPrefix_disk_free", "mountPointPrefix_disk_usedPercent", "disk_ioUtils", "disk_inodesUsedPercent", "net_bitSent", "net_bitRecv", "net_packetRecv", "net_packetSent", "net_tcp_total", "net_tcp_established"]
    @Published var VmList: [String] = []
    @Published var MetricsStorage: [String: VM] = [:]
    
    public func LoadVms(token: String) {
        SberCloudApiGetVMNames(token: token) {
            (res) in
            DispatchQueue.main.async {
                self.VmList = res
            }
        }
        for i in self.VmList {
            self.MetricsStorage[i] = VM(Name: i, Metrics: [:])
        }
    }
    public func LoadMetrics(token: String, Name: Int, Model: Int) {
        print(VmList)
        SberCloudApiGetMetrics(token: token, VmName: VmList[Name], Mode: MetricsMode[Model], TimeL: 0, TimeH: time(nil) * 1000, Period: 1, Filter: "max") {
            (res, flag) in
            self.MetricsStorage[self.VmList[Name]]?.Metrics[self.MetricsMode[Model]] = res
        }
    }
}

*/
