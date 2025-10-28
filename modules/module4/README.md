# モジュール 4: テスト攻撃シナリオの実施

このモジュールでは、セキュリティアラートとインシデントを生成するために、テスト攻撃シナリオを実施します。これらのテストは安全な方法で行われ、実際のシステムに害を与えることはありません。

## 目標

- テスト攻撃ツールをインストールする
- 悪意のあるコマンドの実行をシミュレートする
- 権限昇格のシミュレーション
- 疑わしいプロセスの実行

## 注意事項

**重要**: これらのテストは教育目的のみで実施されます。実際の環境では、これらのコマンドは実行しないでください。

## タスク 1: テストツールのダウンロード

1. OnPremServer への RDP 接続を確認します。
2. 管理者権限で PowerShell を開きます。
3. テスト用フォルダを作成します：

```powershell
New-Item -Path "C:\SecurityTests" -ItemType Directory -Force
cd C:\SecurityTests
```

4. Microsoft のテストファイルをダウンロードします：

```powershell
Invoke-WebRequest -Uri "https://aka.ms/ASI-FakeTools" -OutFile "ASI-FakeTools.zip"
Expand-Archive -Path "ASI-FakeTools.zip" -DestinationPath "C:\SecurityTests" -Force
cd C:\SecurityTests\ASI-FakeTools
```

## タスク 2: Windows Defender のリアルタイム保護を一時的に無効化する

テスト中に Windows Defender が検出をブロックしないように、一時的にリアルタイム保護を無効にします：

```powershell
Set-MpPreference -DisableRealtimeMonitoring $true
```

## タスク 3: シミュレーション攻撃 1 - 疑わしいプロセスの実行

1. PowerShell で以下のコマンドを実行して、EICAR テストファイルを作成します：

```powershell
"X5O!P%@AP[4\PZX54(P^)7CC)7}$EICAR-STANDARD-ANTIVIRUS-TEST-FILE!$H+H*" | Out-File "C:\SecurityTests\eicar.txt"
```

2. 次に、Mimikatz の実行をシミュレートするテストファイルを実行します：

```powershell
.\ASI-MimikatzTest.exe
```

3. このツールは実際のミミカッツを実行するわけではなく、Microsoft Defender for Servers がミミカッツの実行パターンを検出できるようにシミュレーションします。

## タスク 4: シミュレーション攻撃 2 - 権限昇格の試み

次のコマンドを実行して、権限昇格の試みをシミュレートします：

```powershell
.\ASI-PrivEscTest.exe
```

## タスク 5: シミュレーション攻撃 3 - 悪意のあるコマンドの実行

1. 悪意のあるコマンドの実行をシミュレートします：

```powershell
.\ASI-ProcessInjectionTest.exe
```

2. レジストリの変更をシミュレートします：

```powershell
.\ASI-PersistenceTest.exe
```

## タスク 6: Windows Defender のリアルタイム保護を再度有効化する

テストが完了したら、Windows Defender のリアルタイム保護を再度有効にします：

```powershell
Set-MpPreference -DisableRealtimeMonitoring $false
```

## タスク 7: Azure ポータルでのアラートの確認

1. [Azure ポータル](https://portal.azure.com)にサインインします。
2. 検索バーに「**Microsoft Defender for Cloud**」と入力し、表示されるサービスをクリックします。
3. 左側のメニューから「**セキュリティ アラート**」をクリックします。
4. しばらく待ちます（15〜30 分程度）。テスト攻撃に関連するアラートが表示されるはずです。

![Defender のセキュリティアラート](../../images/module4/security-alerts.png)

5. いくつかのアラートをクリックして詳細を確認します。以下のようなアラートが表示される可能性があります：
   - 疑わしいプロセスの実行
   - 認証情報の窃取の試み
   - 権限昇格の試み
   - 永続化メカニズムの検出

## 次のステップ

これで、テスト攻撃シナリオが実施され、Microsoft Defender for Servers によってセキュリティアラートが生成されました。次のモジュールでは、Azure Sentinel を使用してこれらのインシデントに対応する方法を学びます。

[モジュール 5: Azure Sentinel でのインシデント対応](../module5/README.md)に進みます。
