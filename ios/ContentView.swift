import SwiftUI

/// iOS 用の最初の画面。
/// - 画面には「今決めたい感覚を、一つだけかんじる」とだけ表示。
/// - 画面表示と同時に自動スタートし、一定時間後に NOW NOT DECIDE 画面へ遷移します。
struct ContentView: View {
    /// フローが開始されたかどうか（必要なら UI の出し分けに使用）
    @State private var isStarted = false
    /// NOW NOT DECIDE 画面へ遷移するかどうか
    @State private var showNowNotDecide = false

    /// 自動スタートから NOW NOT DECIDE へ切り替わるまでの秒数
    /// 実運用では 180（=3 分）などに変更してください。
    private let autoTransitionDuration: TimeInterval = 180

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Text("今決めたい感覚を、一つだけかんじる")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding()

                if isStarted {
                    // 必要であれば、スタート中の状態やカウントダウンなどをここに表示できます。
                    // Text("スタート中…")
                }

                // 画面遷移トリガ（見えない NavigationLink）
                NavigationLink(
                    destination: NowNotDecideView(),
                    isActive: $showNowNotDecide
                ) {
                    EmptyView()
                }
                .hidden()
            }
            .onAppear {
                startFlowIfNeeded()
            }
        }
    }

    /// 画面表示時に一度だけフローをスタートする
    private func startFlowIfNeeded() {
        guard !isStarted else { return }
        isStarted = true

        // 一定時間後に NOW NOT DECIDE 画面へ遷移
        DispatchQueue.main.asyncAfter(deadline: .now() + autoTransitionDuration) {
            showNowNotDecide = true
        }
    }
}

#Preview {
    ContentView()
}

