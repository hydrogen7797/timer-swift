import SwiftUI
import AppKit

/// NOW NOT DECIDE 画面。
/// - 「NOW NOT DECIDE」のタイトル
/// - 指定どおりのテキストと改行
/// - 「閉じる」ボタンでアプリ終了
struct NowNotDecideView: View {
    var body: some View {
        VStack(spacing: 24) {
            Text("NOW NOT DECIDE")
                .font(.largeTitle)

            VStack(spacing: 8) {
                Text("言葉が出たら")
                Text("「今は使わないと」一回だけ")
            }
            .multilineTextAlignment(.center)
            .font(.title3)

            Button("閉じる") {
                NSApplication.shared.terminate(nil)
            }
            .keyboardShortcut(.cancelAction) // Esc などで閉じる系の動作
        }
        .padding(32)
        .frame(minWidth: 480, minHeight: 320)
    }
}

#Preview {
    NowNotDecideView()
}

