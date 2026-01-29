import SwiftUI

/// 全体フロー（仕様書 2: 起動画面 → 実行画面（3分） → 終了画面 → 凍結。戻る／やり直し／スキップ不可）
struct ContentView: View {
    enum Phase {
        case launch
        case execution
        case ended
    }

    @State private var phase: Phase = .launch
    private let config = AppVariant.current

    var body: some View {
        ZStack {
            switch phase {
            case .launch:
                LaunchView(config: config) {
                    withAnimation { phase = .execution }
                }
            case .execution:
                ExecutionView(config: config) {
                    withAnimation { phase = .ended }
                }
            case .ended:
                EndView(config: config)
            }
        }
        .animation(.easeInOut, value: phase)
    }
}

#Preview {
    ContentView()
}
