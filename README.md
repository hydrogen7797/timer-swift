# 3分プロトコル系アプリ（Swift iOS）

同一コードベースで **END 3min / SLEEP 3min / NOW NOT DECIDE** の 3 本を、Config（定数）の切り替えのみでビルドする iOS アプリです。

## 仕様概要

- **画面遷移**: 起動画面 → 実行画面（3分: 30-90-30-30秒） → 終了画面 → 凍結（戻る／やり直し／スキップ不可）
- **起動画面**: 背景 #111111。END/SLEEP は「開始」ボタン、NOW NOT DECIDE は開始ボタンなし・自動スタート
- **実行画面**: 背景 #141414、タップ無効、タイマー・進捗表示なし、中央テキストのみ
- **終了画面**: 背景 #0F0F0F。「閉じる」タップで凍結（以降一切の入力・遷移を受け付けない）
- **Haptic**: 開始(短1)、区間切替(短1)、終了(短2・0.3s間隔)
- **ログ・DB・広告・通知**: なし

## iOS フォルダ構成（`ios/`）

| ファイル                   | 役割                                     |
| -------------------------- | ---------------------------------------- |
| `NowNotDecideIOSApp.swift` | `@main` エントリ                         |
| `AppConfig.swift`          | 3 アプリ別のテキスト・色・開始ボタン有無 |
| `ContentView.swift`        | 起動→実行→終了の状態管理（一方向のみ）   |
| `LaunchView.swift`         | 起動画面                                 |
| `ExecutionView.swift`      | 実行画面（4 区間、Haptic）               |
| `EndView.swift`            | 終了画面（閉じるで凍結）                 |

## 3 本のアプリとしてビルドする方法（Xcode）

1. **iOS App プロジェクトを 1 つ作成**（SwiftUI, Swift）。
2. 上記 `ios/` 内の全 Swift ファイルをプロジェクトに追加（`NowNotDecideView.swift` は不要・削除済み）。
3. **3 つのターゲット**を作成（例: END3min, SLEEP3min, NowNotDecide）。
4. 各ターゲットで **Bundle ID** を別にする（例: `com.example.END3min` / `com.example.SLEEP3min` / `com.example.NowNotDecide`）。
5. 各ターゲットの **Info.plist** に、現在のアプリ種別を渡すキーを追加する:
   - キー: `AppVariant`（任意のキー名でよいが、`AppConfig.swift` の `Bundle.main.infoDictionary?["AppVariant"]` と一致させる）
   - 値（文字列）:
     - END 3min → `END3min`
     - SLEEP 3min → `SLEEP3min`
     - NOW NOT DECIDE → `NowNotDecide`

   Xcode では **Target → Info → Custom iOS Target Properties** で行を追加し、Key に `AppVariant`、Value に上記のいずれかを設定する。

6. スキームを切り替えて **⌘R** で実行。シミュレータまたは実機で動作確認。

## アイコン（仕様書 6）

- 背景: 濃いグレー〜黒
- 中央に極小の点 1 つ: END=白、SLEEP=青、DECIDE=赤
- 文字・ロゴ・記号は使わない

`AppConfig.dotColor` で各アプリのドット色を参照できます。アイコン用アセットは Xcode の Asset Catalog で別途用意してください。

## 動作確認のポイント

1. **3 分で必ず終わる**（30+90+30+30 秒）
2. 分岐・評価・記録は行わない
3. 終了後は「閉じる」で凍結し、それ以降は入力・遷移を受け付けない

---

### macOS 版（従来の単体 NOW NOT DECIDE）

ルート直下の `TimerSwiftApp.swift` / `ContentView.swift` / `NowNotDecideView.swift` は、macOS 用の単体アプリ用です。3 本統一仕様の iOS 版とは別です。
