import SwiftUI

/// 終了画面（仕様書 4: 背景 #0F0F0F。「閉じる」は凍結状態＝以降一切の入力・遷移を受け付けない）
struct EndView: View {
    let config: AppVariant
    @State private var frozen = false

    var body: some View {
        ZStack {
            Color(hex: 0x0F0F0F)
                .ignoresSafeArea()

            VStack(spacing: 32) {
                Text(config.endText)
                    .font(.title2)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)

                Button("閉じる") {
                    frozen = true
                }
                .font(.title3)
                .foregroundColor(.black)
                .padding(.horizontal, 32)
                .padding(.vertical, 12)
                .background(Color.white)
                .cornerRadius(8)
                .disabled(frozen)
                .opacity(frozen ? 0.6 : 1)
            }
        }
        .allowsHitTesting(!frozen)
    }
}
