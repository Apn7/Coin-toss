import SwiftUI

struct ContentView: View {
    @State private var coinSide: String = "Heads" // Holds the current side of the coin
    @State private var isFlipping: Bool = false  // Tracks if the coin is currently flipping

    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                // Title
                Text("Coin Toss")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)

                // Coin Display
                ZStack {
                    if isFlipping {
                        Circle()
                            .fill(Color.gray.opacity(0.5))
                            .frame(width: 200, height: 200)
                            .overlay(
                                ProgressView()
                                    .scaleEffect(2)
                                    .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                            )
                            .rotationEffect(.degrees(isFlipping ? 360 : 0))
                            .animation(.linear(duration: 1).repeatForever(autoreverses: false), value: isFlipping)
                    } else {
                        Image(coinSide == "Heads" ? "6388460" : "6400476")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .shadow(radius: 10)
                    }
                }

                // Result Text
                if !isFlipping {
                    Text("Result: \(coinSide)")
                        .font(.title2)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                }

                // Toss Button
                Button(action: tossCoin) {
                    Text("Toss Coin")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding(.horizontal)

                Spacer()
            }
            .padding()
            .navigationTitle("Coin Toss Game")
        }
    }

    // Toss Coin Logic
    private func tossCoin() {
        isFlipping = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            coinSide = Bool.random() ? "Heads" : "Tails"
            isFlipping = false
        }
    }
}

// Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

