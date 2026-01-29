import SwiftUI

/// iOS 用 NOW NOT DECIDE 画面。
/// - 「NOW NOT DECIDE」のタイトル
/// - 指定どおりのテキストと改行
/// - 「閉じる」ボタンでこの画面を閉じて前の画面へ戻る
struct NowNotDecideView: View {
    @Environment(\.dismiss) private var dismiss

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
                // この画面を閉じて前の画面に戻る（iOS ではアプリ終了はしない）
                dismiss()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding(32)
    }
}

#Preview {
    NowNotDecideView()
}

