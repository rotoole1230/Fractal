import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image("sample_image", bundle: .main)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            Text("Hello, World!")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.white)
    }
}