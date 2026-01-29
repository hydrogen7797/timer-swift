# 3分プロトコル系アプリ（Swift iOS）

**END 3min / SLEEP 3min / NOW NOT DECIDE** の 3 本を、**プロジェクトごとに分けた 3 フォルダ**で提供しています。各フォルダは 1 アプリ専用で、Info.plist の切り替えは不要です。

## リポジトリ構成

| フォルダ              | アプリ                       | エントリファイル        |
| --------------------- | ---------------------------- | ----------------------- |
| **ios-END3min/**      | END 3min（終業用）           | `END3minApp.swift`      |
| **ios-SLEEP3min/**    | SLEEP 3min（就寝前用）       | `SLEEP3minApp.swift`    |
| **ios-NowNotDecide/** | NOW NOT DECIDE（判断停止用） | `NowNotDecideApp.swift` |

各フォルダ内は同じ構成です：`AppConfig.swift` / `ContentView.swift` / `LaunchView.swift` / `ExecutionView.swift` / `EndView.swift` / 上記の App ファイル。**AppConfig** の `current` だけがそのアプリ用に固定されています。

## 仕様概要

- **画面遷移**: 起動画面 → 実行画面（3分: 30-90-30-30秒） → 終了画面 → 凍結（戻る／やり直し／スキップ不可）
- **起動画面**: 背景 #111111。END/SLEEP は「開始」ボタン、NOW NOT DECIDE は開始ボタンなし・自動スタート
- **実行画面**: 背景 #141414、タップ無効、タイマー・進捗表示なし、中央テキストのみ
- **終了画面**: 背景 #0F0F0F。「閉じる」タップで凍結（以降一切の入力・遷移を受け付けない）
- **Haptic**: 開始(短1)、区間切替(短1)、終了(短2・0.3s間隔)
- **ログ・DB・広告・通知**: なし

---

## ステップバイステップ：3 本とも「1 プロジェクト = 1 アプリ」で作る

各アプリ用に **Xcode プロジェクトを 1 つずつ**作成し、対応するフォルダの Swift ファイルだけを追加します。ターゲットの追加や Info.plist の `AppVariant` は不要です。

### END 3min 用プロジェクト

1. **Xcode** → **File → New → Project…** → **iOS** → **App** → Next。
2. **Product Name**: `END3min`、**Interface**: SwiftUI、**Language**: Swift → Create。
3. 自動生成された **App のファイル**（例: `END3minApp.swift`）を開き、中身を**すべて削除**して、このリポジトリの **`ios-END3min/END3minApp.swift`** の内容を貼り付けて保存。
4. **ContentView.swift** を開き、中身を **`ios-END3min/ContentView.swift`** の内容で置き換え、保存。
5. **File → Add Files to "END3min"…** で **`ios-END3min`** フォルダを開き、**AppConfig.swift** / **LaunchView.swift** / **ExecutionView.swift** / **EndView.swift** を選択 → **Copy items if needed** にチェック → **Add**。  
   （既に ContentView は置き換え済みなので、追加するのは上記 4 ファイル。**END3minApp.swift** は既に貼り替え済みのため、重複して追加しない。）
6. **General** で **Bundle Identifier** を設定（例: `com.yourname.END3min`）。**⌘R** で実行。

### SLEEP 3min 用プロジェクト

1. 新規 **File → New → Project…** → **iOS** → **App** → **Product Name**: `SLEEP3min` → Create。
2. 自動生成された **App のファイル**を **`ios-SLEEP3min/SLEEP3minApp.swift`** の内容で置き換え。
3. **ContentView.swift** を **`ios-SLEEP3min/ContentView.swift`** の内容で置き換え。
4. **Add Files…** で **AppConfig.swift** / **LaunchView.swift** / **ExecutionView.swift** / **EndView.swift** を **ios-SLEEP3min** から追加。
5. **Bundle Identifier** を設定（例: `com.yourname.SLEEP3min`）。**⌘R** で実行。

### NOW NOT DECIDE 用プロジェクト

1. 新規 **File → New → Project…** → **iOS** → **App** → **Product Name**: `NowNotDecide` → Create。
2. 自動生成された **App のファイル**を **`ios-NowNotDecide/NowNotDecideApp.swift`** の内容で置き換え。
3. **ContentView.swift** を **`ios-NowNotDecide/ContentView.swift`** の内容で置き換え。
4. **Add Files…** で **AppConfig.swift** / **LaunchView.swift** / **ExecutionView.swift** / **EndView.swift** を **ios-NowNotDecide** から追加。
5. **Bundle Identifier** を設定（例: `com.yourname.NowNotDecide`）。**⌘R** で実行。

---

### クイック参照：フォルダと App ファイル

| アプリ         | フォルダ            | App ファイル（@main）   |
| -------------- | ------------------- | ----------------------- |
| END 3min       | `ios-END3min/`      | `END3minApp.swift`      |
| SLEEP 3min     | `ios-SLEEP3min/`    | `SLEEP3minApp.swift`    |
| NOW NOT DECIDE | `ios-NowNotDecide/` | `NowNotDecideApp.swift` |

※ **1 プロジェクト・3 ターゲット**で運用したい場合は、従来どおり **`ios/`** フォルダを使い、各ターゲットの Info.plist に **AppVariant** を設定する方法もあります。`ios/` はそのまま残してあります。

## アイコンをアプリ別に設定する（仕様書 6）

仕様: **背景は濃いグレー〜黒**。中央に**極小の点を 1 つだけ**（END=白 / SLEEP=青 / DECIDE=赤）。文字・ロゴ・記号は使わない。

---

### 方法 A：1 つの Asset Catalog で 3 種類の App Icon を用意する（推奨）

1. **Asset Catalog を開く**  
   Project Navigator で **Assets.xcassets** をクリックする。

2. **App Icon セットを 3 つ作る**
   - 左の一覧で **AppIcon** が既にある。それを **右クリック → Duplicate** して **AppIcon** のコピーを 2 つ作る。
   - 名前を変える: 1 つ目はそのまま **AppIcon**（または **AppIcon-NowNotDecide**）、2 つ目を **AppIcon-END3min**、3 つ目を **AppIcon-SLEEP3min** にする。
   - もしくは **左の一覧の空白で右クリック → App Icons → New App Icon** を 2 回実行し、名前を **AppIcon-END3min** / **AppIcon-SLEEP3min** にする（元の **AppIcon** を NOW NOT DECIDE 用にする）。

3. **各 App Icon セットに画像を入れる**
   - **AppIcon**（NOW NOT DECIDE 用）をクリックし、右側の **1024pt** のスロットに **1024×1024 px** の PNG をドラッグ＆ドロップする。
     - デザイン: 背景 #1a1a1a 程度の濃いグレー、中央に赤い小さい円 1 つ。
   - **AppIcon-END3min** をクリックし、同様に 1024×1024 の PNG を入れる（背景濃いグレー、中央に**白**の小さい円 1 つ）。
   - **AppIcon-SLEEP3min** をクリックし、同様に 1024×1024 の PNG を入れる（背景濃いグレー、中央に**青**の小さい円 1 つ）。

   ※ Xcode 14 以降は **Single Size** になっていれば、1024×1024 の 1 枚だけで OK。複数サイズが必要な場合は右側の **All Sizes** などで各スロットに画像を入れる。

4. **各ターゲットに「どの App Icon を使うか」を指定する**
   - 青いプロジェクトアイコンをクリック → **TARGETS** から **END3min** を選択 → **General** タブを開く。
   - **App Icons and Launch Screen** の **App Icon** で、ドロップダウンから **AppIcon-END3min** を選ぶ。
   - **SLEEP3min** ターゲットでは **App Icon** に **AppIcon-SLEEP3min** を選ぶ。
   - **NowNotDecide**（または元の 1 つ目のターゲット）では **App Icon** に **AppIcon**（または **AppIcon-NowNotDecide**）を選ぶ。

5. **ビルドして確認**  
   スキームで END3min / SLEEP3min / NowNotDecide を切り替えて **⌘R** で実行し、ホーム画面や App Switcher でアイコンが切り替わっているか確認する。

---

### 方法 B：ターゲットごとに別の Asset Catalog を使う

- ターゲットを複製したときに **Assets.xcassets** も複製されている場合、**END3min** 用・**SLEEP3min** 用・**NowNotDecide** 用で別々の **Assets.xcassets** が存在する。
- 各ターゲットの **General → App Icons and Launch Screen → App Icon** が、そのターゲット用の **Assets.xcassets** 内の **AppIcon** を指していることを確認する。
- それぞれの **Assets.xcassets** の **AppIcon** に、上記の仕様（背景＋ドット色）に合わせた 1024×1024 の画像を 1 枚ずつ入れる。

---

### アイコン画像の作り方（参考）

- **Figma / Photoshop / GIMP など**: 1024×1024 のキャンバスで、背景を #1a1a1a、中央に直径 20〜40 px 程度の円を 1 つ（白 / 青 #3366ff 系 / 赤 #cc0000 系）描画して PNG で書き出す。
- **コードで生成する場合**: Mac で **sips** や **ImageMagick** を使い、単色背景＋円 1 つの画像を 1024×1024 で出力するスクリプトを書くこともできる。
- 色の参考: `AppConfig.dotColor`（END=白、SLEEP=青、DECIDE=赤）に合わせるとよい。

## 動作確認のポイント

1. **3 分で必ず終わる**（30+90+30+30 秒）
2. 分岐・評価・記録は行わない
3. 終了後は「閉じる」で凍結し、それ以降は入力・遷移を受け付けない

---

### macOS 版（従来の単体 NOW NOT DECIDE）

ルート直下の `TimerSwiftApp.swift` / `ContentView.swift` / `NowNotDecideView.swift` は、macOS 用の単体アプリ用です。3 本統一仕様の iOS 版とは別です。
