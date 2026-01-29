import SwiftUI

/// 実行画面（仕様書 4: 背景 #141414、タップ無効、タイマー・進捗表示禁止、中央テキストのみ）
/// 区間: 30-90-30-30 秒。Haptic: 開始(短1)、区間切替(短1)、終了(短2・0.3s間隔)
struct ExecutionView: View {
    let config: AppVariant
    let onFinish: () -> Void

    @State private var segmentIndex: Int = 0
    @State private var started = false

    private var currentText: String {
        guard segmentIndex < config.segmentTexts.count else { return "" }
        return config.segmentTexts[segmentIndex]
    }

    var body: some View {
        ZStack {
            Color(hex: 0x141414)
                .ignoresSafeArea()

            Text(currentText)
                .font(.title2)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
        }
        .contentShape(Rectangle())
        .allowsHitTesting(false)
        .onAppear {
            runSegments()
        }
    }

    private func runSegments() {
        guard !started else { return }
        started = true

        let durations = TimerConfig.segmentDurations
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.prepare()

        generator.impactOccurred(intensity: 0.7)

        var elapsed: TimeInterval = 0
        for (index, duration) in durations.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + elapsed) {
                segmentIndex = index
                if index > 0 {
                    generator.impactOccurred(intensity: 0.7)
                }
            }
            elapsed += duration
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + elapsed) {
            generator.impactOccurred(intensity: 0.7)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                generator.impactOccurred(intensity: 0.7)
                onFinish()
            }
        }
    }
}
