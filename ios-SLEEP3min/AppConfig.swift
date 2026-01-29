import SwiftUI

// MARK: - Hex color（仕様書 4: #111111 / #141414 / #0F0F0F）
extension Color {
    init(hex: UInt) {
        let r = Double((hex >> 16) & 0xFF) / 255
        let g = Double((hex >> 8) & 0xFF) / 255
        let b = Double(hex & 0xFF) / 255
        self.init(red: r, green: g, blue: b)
    }
}

// MARK: - アプリ別定義（仕様書 3. アプリ別定義データ）

enum AppVariant: String, CaseIterable {
    case end3min = "END3min"
    case sleep3min = "SLEEP3min"
    case nowNotDecide = "NowNotDecide"

    /// 起動画面テキスト（仕様書 3.A）
    var launchText: String {
        switch self {
        case .end3min: return "終業前の3分を開始"
        case .sleep3min: return "寝る前の3分を開始"
        case .nowNotDecide: return "今決めたい感覚を、一つだけかんじる"
        }
    }

    /// NOW NOT DECIDE は開始ボタンなし・自動スタート
    var hasLaunchButton: Bool {
        switch self {
        case .nowNotDecide: return false
        case .end3min, .sleep3min: return true
        }
    }

    /// 実行画面 4 区間のテキスト（仕様書 3.B）①30秒 ②90秒 ③30秒 ④30秒
    var segmentTexts: [String] {
        switch self {
        case .end3min, .sleep3min:
            return [
                "いま、残っている感覚を一つだけ感じる",
                "吐く終わりで、抜ける方向だけ許可",
                "言葉が出たら「今は使わない」と一回だけ",
                "さっきより弱い、が一つあれば十分"
            ]
        case .nowNotDecide:
            return [
                "いま決めたい感覚を、一つだけ感じる",
                "吐く終わりで、抜ける方向だけ許可",
                "言葉が出たら\n「今は決めない」と一回だけ",
                "「さっきより弱い」が一つあれば終了"
            ]
        }
    }

    /// 終了画面テキスト（仕様書 3.C）
    var endText: String {
        switch self {
        case .end3min: return "今日は切り替わった気がする"
        case .sleep3min: return "このまま何もしないでください"
        case .nowNotDecide: return "終わりました。何もしないでください"
        }
    }

    /// アイコン用ドット色（仕様書 6: END白 / SLEEP青 / DECIDE赤）
    var dotColor: Color {
        switch self {
        case .end3min: return Color.white
        case .sleep3min: return Color(red: 0.2, green: 0.4, blue: 1.0)
        case .nowNotDecide: return Color.red
        }
    }
}

/// 実行画面の区間秒数（仕様書: 30-90-30-30 秒、計 3 分）
enum TimerConfig {
    static let segmentDurations: [TimeInterval] = [30, 90, 30, 30]
}

// MARK: - このプロジェクトは SLEEP 3min 専用

extension AppVariant {
    static var current: AppVariant { .sleep3min }
}
