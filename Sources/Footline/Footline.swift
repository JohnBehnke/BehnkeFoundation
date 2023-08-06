import SwiftUI

public struct Footline: View {
    @State private var isPressed: Bool = false
    @State private var numberOfPresses: Int = 0
    @State private var symbolShadowColor: Color = .red
    @State private var symbolForegroundGradient: LinearGradient =
    LinearGradient(
        colors: [.red, .pink],
        startPoint: .top, endPoint: .bottom
    )
    
    let symbolFillGradients: [LinearGradient] = [
        LinearGradient(colors: [.blue, .teal], startPoint: .top, endPoint: .bottom),
        LinearGradient(colors: [.orange, .yellow], startPoint: .top, endPoint: .bottom),
        LinearGradient(colors: [.green, .blue], startPoint: .top, endPoint: .bottom),
        LinearGradient(colors: [.pink, .orange], startPoint: .top, endPoint: .bottom),
        LinearGradient(colors: [.indigo, .blue], startPoint: .top, endPoint: .bottom),
        LinearGradient(colors: [.mint, .teal], startPoint: .top, endPoint: .bottom),
        LinearGradient(colors: [.purple, .red], startPoint: .top, endPoint: .bottom),
        LinearGradient(colors: [.purple, .pink], startPoint: .top, endPoint: .bottom),
        LinearGradient(colors: [.blue, .mint], startPoint: .top, endPoint: .bottom),
        LinearGradient(colors: [.red, .pink], startPoint: .top, endPoint: .bottom)
    ]
    let symbolShadowColors: [Color] = [
        .blue,
        .orange,
        .green,
        .pink,
        .indigo,
        .mint,
        .purple,
        .purple,
        .blue,
        .red
    ]
    
    let hapticsGenerator = UINotificationFeedbackGenerator()
    
    var appName: String
    var releaseVersion: String
    var buildVersion: String
    var locationName: String
    var symbolName: String
    
    init(
        appName: String = Bundle.main.appName,
        releaseVersion: String = Bundle.main.releaseVersionNumber,
        buildVersion: String = Bundle.main.buildVersionNumber,
        locationName: String = "Connecticut",
        symbolName: String = "heart.fill"
    ) {
        self.appName = appName
        self.releaseVersion = releaseVersion
        self.buildVersion = buildVersion
        self.locationName = locationName
        self.symbolName = symbolName
    }
    
    public var body: some View {
        footerText
            .padding()
            .foregroundColor(.gray)
            .font(.caption)
    }
    
    var footerText: some View {
        VStack {
            Text("\(self.appName) \(self.releaseVersion) (\(self.buildVersion))")
            HStack(alignment: .center, spacing: 2) {
                Text("Made in ") + Text(self.locationName).bold() + Text(" with")
                Image(systemName: symbolName)
                    .font(.caption2)
                    .shadow(color: self.symbolShadowColor, radius: self.isPressed ? 3 : 1)
                    .foregroundStyle(self.symbolForegroundGradient)
                    .scaleEffect(self.isPressed ? 0.75 : 1.0)
                    .rotationEffect(self.isPressed ? .degrees(numberOfPresses.isMultiple(of: 2) ? 10 : -10) : .degrees(0))
                    .animation(.spring(response: 0.2, dampingFraction: 0.1), value: self.isPressed)
                
            }
            .onTapGesture {
                self.hapticsGenerator.notificationOccurred(.success)
                self.symbolForegroundGradient = symbolFillGradients[numberOfPresses % symbolFillGradients.count]
                self.symbolShadowColor = symbolShadowColors[numberOfPresses % symbolShadowColors.count]
                self.numberOfPresses += 1
                self.isPressed.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.isPressed.toggle()
                }
            }
        }
    }
}


struct AppFooter_Previews: PreviewProvider {
    static var previews: some View {
        Footline(
            appName: "Footline",
            releaseVersion: "1.0.0",
            buildVersion: "1",
            locationName: "The Matrix"
        )
        .frame(height: 500)
    }
}
