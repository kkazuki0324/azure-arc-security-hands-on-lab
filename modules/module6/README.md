# モジュール 6: クリーンアップと次のステップ

このモジュールでは、ラボで使用したリソースをクリーンアップし、Azure Arc と Microsoft Defender for Servers を実際の環境で活用するための次のステップについて説明します。

## 目標

- ラボリソースをクリーンアップする
- 課金への影響を理解する
- Azure Arc と Microsoft Defender for Servers の主要な利点を復習する
- 次のステップとリソースを確認する

## タスク 1: ラボリソースのクリーンアップ

ラボが完了したら、不要なコストを避けるためにリソースをクリーンアップします。

1. [Azure ポータル](https://portal.azure.com)にサインインします。
2. 検索バーに「**リソースグループ**」と入力し、表示されるサービスをクリックします。
3. このラボで作成した以下のリソースグループを選択します：

   - ArcLab-RG（OnPremServer 仮想マシンを含む）
   - ArcServers-RG（Azure Arc に接続されたサーバーリソースを含む）
   - ArcSentinel-RG（Log Analytics ワークスペースと Microsoft Sentinel を含む）

4. 各リソースグループについて、「**リソースグループの削除**」をクリックします。
5. 確認のために、リソースグループ名を入力し、「**削除**」をクリックします。
6. すべてのリソースグループが削除されるまで待ちます。

## タスク 2: 課金への影響を理解する

このハンズオンラボで使用したサービスと、それらが課金に与える影響について理解しましょう。

### 仮想マシン（OnPremServer）

- **課金の仕組み**: 仮想マシンは実行時間（計算時間）とストレージ使用量に基づいて課金されます
- **コスト削減方法**: 
  - 使用しないときはVMを停止（割り当て解除）する
  - 可能な限り小さいVMサイズを選択する
  - リザーブドインスタンスを検討する（長期的な使用の場合）

### Microsoft Defender for Servers

- **課金の仕組み**: Defender for Servers Plan 2 は、保護対象のサーバーごとに1時間あたりの料金が課金されます
- **コスト削減方法**:
  - 必要なサーバーのみに有効化する
  - 無料の30日間試用期間を活用する
  - 大規模なデプロイメントの場合はエンタープライズ契約を検討する

### Azure Sentinel / Log Analytics

- **課金の仕組み**: データ取り込み量（GB単位）に基づいて課金されます
- **コスト削減方法**:
  - 必要なデータのみを収集するようにデータ収集ルールを設定する
  - 不要なアラートルールを無効化する
  - データ保持期間を最適化する（長期保存が必要ない場合は短く設定）

### Azure Arc

- **課金の仕組み**: 
  - 基本的な接続機能は無料
  - 高度な管理機能やAzure上のサービスのデプロイには料金が発生
- **コスト削減方法**:
  - 必要なサーバーのみを接続する
  - 使用していない拡張機能を削除する

## タスク 3: 主要な概念の復習

このラボで学んだ主要な概念を復習します：

### Azure Arc の主要な機能

- ハイブリッドおよびマルチクラウド環境の一元管理
- オンプレミスサーバーの Azure への接続
- Azure Policy によるコンプライアンス管理
- Azure Monitor によるモニタリング
- Azure の機能をオンプレミス環境に拡張

### Microsoft Defender for Servers の利点

- クラウドネイティブの脅威検出と対応
- サーバーのセキュリティ体制の強化
- 脆弱性評価と管理
- クラウドセキュリティポスチャー管理（CSPM）
- クラウドワークロード保護（CWP）

### Azure Sentinel によるセキュリティ対応

- セキュリティイベントの収集と分析
- インシデント検出と対応
- 自動化された脅威ハンティング
- セキュリティオーケストレーション、自動化、対応（SOAR）機能

## タスク 3: 次のステップとリソース

### 実稼働環境での適用

1. **環境評価の実施**:

   - オンプレミスサーバーのインベントリ
   - Azure Arc への段階的な移行計画
   - セキュリティベースラインの確立

2. **大規模デプロイの自動化**:

   - スクリプトによる一括オンボーディング
   - Azure Policy によるコンプライアンス自動化
   - Defender for Servers の一括展開

3. **継続的なセキュリティ監視の確立**:
   - 定期的な脆弱性評価の実施
   - セキュリティアラートの監視プロセス
   - インシデント対応プレイブックの作成

### 追加リソース

1. **ドキュメント**:

   - [Azure Arc のドキュメント](https://docs.microsoft.com/ja-jp/azure/azure-arc/)
   - [Microsoft Defender for Cloud のドキュメント](https://docs.microsoft.com/ja-jp/azure/defender-for-cloud/)
   - [Azure Sentinel のドキュメント](https://docs.microsoft.com/ja-jp/azure/sentinel/)

2. **トレーニング**:

   - [Azure Arc に関する Microsoft Learn モジュール](https://docs.microsoft.com/ja-jp/learn/browse/?terms=azure%20arc)
   - [Microsoft Defender for Cloud に関する Microsoft Learn モジュール](https://docs.microsoft.com/ja-jp/learn/browse/?terms=defender%20for%20cloud)
   - [Azure Sentinel に関する Microsoft Learn モジュール](https://docs.microsoft.com/ja-jp/learn/browse/?terms=azure%20sentinel)

3. **ブログとリソース**:
   - [Azure ブログ - Azure Arc](https://azure.microsoft.com/ja-jp/blog/topics/azure-arc/)
   - [Azure ブログ - セキュリティ](https://azure.microsoft.com/ja-jp/blog/topics/security/)
   - [Microsoft Security ブログ](https://www.microsoft.com/security/blog/)

## まとめ

このハンズオンラボでは、以下を学びました：

1. Azure Arc を使用してオンプレミスサーバーをオンボーディングする方法
2. Microsoft Defender for Servers を有効化して構成する方法
3. セキュリティイベントを検出する方法
4. Azure Sentinel を使用してインシデント対応を実施する方法

これらのスキルを活用して、組織のハイブリッドクラウド環境のセキュリティ体制を強化し、最新の脅威から保護することができます。

ご質問やフィードバックがある場合は、講師にお問い合わせください。

ハンズオンラボへの参加、お疲れ様でした！
