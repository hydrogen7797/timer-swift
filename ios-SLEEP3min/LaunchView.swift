import SwiftUI

/// 起動画面（仕様書 4: 背景 #111111。NOW NOT DECIDE は開始ボタンなし・自動スタート）
struct LaunchView: View {
    let config: AppVariant
    let onStart: () -> Void

    var body: some View {
        ZStack {
            Color(hex: 0x111111)
                .ignoresSafeArea()

            VStack(spacing: 32) {
                Text(config.launchText)
                    .font(.title2)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)

                if config.hasLaunchButton {
                    Button("開始") {
                        onStart()
                    }
                    .font(.title3)
                    .foregroundColor(.black)
                    .padding(.horizontal, 32)
                    .padding(.vertical, 12)
                    .background(Color.white)
                    .cornerRadius(8)
                }
            }
        }
        .onAppear {
            if !config.hasLaunchButton {
                onStart()
            }
        }
    }
}
