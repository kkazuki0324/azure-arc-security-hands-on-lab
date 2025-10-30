# Azure Arc と Microsoft Defender for Servers ハンズオンラボ

このハンズオンラボでは、オンプレミス環境にあるサーバーを Azure Arc を使用してオンボーディングし、Microsoft Defender for Servers を適用してセキュリティ監視を設定します。さらに、Azure Sentinel を使用してインシデント対応の方法を学びます。

## ラボの目的

このラボを完了することで、以下のスキルを習得できます：

1. Azure Arc を使用したオンプレミスサーバーのオンボーディング
2. Microsoft Defender for Servers の有効化と設定

## 実装パターン

このハンズオンラボでは、以下の 2 つの実装パターンをサポートしています：

1. **Azure VM パターン**：Azure 仮想マシンを使用してオンプレミス環境をシミュレーション
2. **オンプレミス VM パターン**：実際のオンプレミス環境にある Windows Server 仮想マシンを使用

どちらのパターンも同じ手順で進めることができ、モジュール 1 でお好みのパターンを選択していただけます。

## ラボの概要

このラボは以下のモジュールで構成されています：

1. **[モジュール 1](modules/module1/README.md)**: 環境のセットアップと前提条件の確認
2. **[モジュール 2](modules/module2/README.md)**: Azure Arc でのサーバーオンボーディング
3. **[モジュール 3](modules/module3/README.md)**: Microsoft Defender for Servers の有効化と構成
4. **[モジュール 4](modules/module4/README.md)**: クリーンアップ
5. **[オプションモジュール](modules/optional/README.md)**: Azure Arc 対応サーバーや Azure VM の情報を Power BI で一元可視化

- インフラストラクチャ管理者
- セキュリティ管理者
- クラウドアーキテクト
- IT 運用担当者

## 前提条件

- Azure サブスクリプション
- 基本的な Azure ポータルの操作知識
- 基本的な Windows サーバー管理の知識
- PowerShell の基本的な知識

## 課金に関する注意事項

このハンズオンラボでは、以下の Azure リソースを使用します。これらのリソースには費用が発生する可能性があります：

1. **仮想マシン（VM）**: ラボで使用する Windows Server 仮想マシン（約 5 時間の実行で約$5-10）
2. **Azure Arc**: Azure Arc 接続マシンの料金（無料枠あり、詳細は[こちら](https://azure.microsoft.com/ja-jp/pricing/details/azure-arc/)
3. **Microsoft Defender for Servers**: Defender for Servers Plan 2（約$0.75/サーバー/日）

> **注意**: 上記の価格は概算であり、実際の料金は利用状況や契約条件によって異なる場合があります。最新の料金情報については、[Azure 料金計算ツール](https://azure.microsoft.com/ja-jp/pricing/calculator/)を参照してください。
