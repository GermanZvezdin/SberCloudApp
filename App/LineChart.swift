//
//  LineChart.swift
//  Custom TabView
//
//  Created by Alex on 26.02.2021.
//

import SwiftUI

public struct LineChartView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @ObservedObject var data:ChartData
    public var title: String
    public var legend: String?
    public var style: ChartStyle
    public var darkModeStyle: ChartStyle
    
    public var formSize:CGSize
    public var dropShadow: Bool
    public var valueSpecifier:String
    public var color: String
    
    @State private var touchLocation:CGPoint = .zero
    @State private var showIndicatorDot: Bool = false
    @State private var currentValue: Double = 2 {
        didSet{
            if (oldValue != self.currentValue && showIndicatorDot) {
                HapticFeedback.playSelection()
            }
            
        }
    }
    var frame = CGSize(width: 180, height: 100)
    private var rateValue: Int?
    
    public init(data: [Double],
                title: String,
                legend: String? = nil,
                style: ChartStyle = Styles.lineChartStyleOne,
                form: CGSize? = CGSize(width:250, height:280),
                dropShadow: Bool? = true,
                valueSpecifier: String? = "%.1f",
                color: String) {
        
        self.data = ChartData(points: data)
        self.title = title
        self.legend = legend
        self.style = style
        self.darkModeStyle = style.darkModeStyle != nil ? style.darkModeStyle! : Styles.lineViewDarkMode
        self.formSize = form!
        frame = CGSize(width: self.formSize.width, height: self.formSize.height/2)
        self.dropShadow = dropShadow!
        self.valueSpecifier = valueSpecifier!
        self.color = color
    }
    
    public var body: some View {

        
        ZStack(alignment: .center){
            VStack(alignment: .leading){
                VStack(alignment: .leading, spacing: 8){
                    Text(self.title)
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(self.color != "dark" ? Color.black : Color("WhiteLine"))
                    if (self.legend != nil){
                        Text(self.legend!)
                            .font(.callout)
                            .foregroundColor(self.color != "dark" ? Color.black :Color("WhiteLine"))
                    }
                }
                .transition(.opacity)
                .animation(.easeIn(duration: 0.3))
                .padding([.leading, .top])
                Spacer()
                GeometryReader{ geometry in
                    Line(data: self.data,
                         frame: .constant(geometry.frame(in: .local)),
                         touchLocation: self.$touchLocation,
                         showIndicator: self.$showIndicatorDot,
                         minDataValue: .constant(nil),
                         maxDataValue: .constant(nil),
                         gradient: color != "dark" ? GradientColor(start: Color.black, end: Color.black) : GradientColor(start: Color("GreenLine"), end: Color("GreenLine")),
                         linearGrad: color != "dark" ? LinearGradient(gradient: Gradient(colors: [Color("ShadowLight"), Color.white]), startPoint: .bottom, endPoint: .top):LinearGradient(gradient: Gradient(colors: [Color("ShadowGreen"), Color("DarkChart")]), startPoint: .bottom, endPoint: .top)
                    )
                }
                .frame(width: frame.width, height: frame.height + 30)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .offset(x: 0, y: -20)
            }.frame(width: self.formSize.width, height: self.formSize.height)
        }

    }
    
    @discardableResult func getClosestDataPoint(toPoint: CGPoint, width:CGFloat, height: CGFloat) -> CGPoint {
        let points = self.data.onlyPoints()
        let stepWidth: CGFloat = width / CGFloat(points.count-1)
        let stepHeight: CGFloat = height / CGFloat(points.max()! + points.min()!)
        
        let index:Int = Int(round((toPoint.x)/stepWidth))
        if (index >= 0 && index < points.count){
            self.currentValue = points[index]
            return CGPoint(x: CGFloat(index)*stepWidth, y: CGFloat(points[index])*stepHeight)
        }
        return .zero
    }
}

struct WidgetView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LineChartView(data: [8,23,54,32,12,37,7,23,43], title: "Line chart", legend: "Basic", form: CGSize(width: 200, height: 200), color: "light")
                .environment(\.colorScheme, .light)
            
            LineChartView(data: [282.502, 284.495, 283.51, 285.019, 285.197, 286.118, 288.737, 288.455, 289.391, 287.691, 285.878, 286.46, 286.252, 284.652, 284.129, 284.188], title: "Line chart", legend: "Basic", color: "light")
            .environment(\.colorScheme, .light)
        }
    }
}
