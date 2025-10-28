# モジュール 2: Arc Connected Machine Agent のインストール

このモジュールでは、オンプレミス環境のサーバーを Azure Arc を使用してオンボーディングします。

## 目標

- サーバーの準備と確認
- Azure Arc 接続スクリプトを生成する
- Arc Connected Machine Agent をインストールする
- エージェント接続を確認する
- Azure Arc 機能を確認する

## タスク 1: サーバーの準備

以下の手順は、モジュール 1 で選択したオプション（Azure VM またはオンプレミス環境）に基づいて実行してください。

### オプション A: Azure VM を使用した場合

1. モジュール 1 でセットアップした仮想マシンに Bastion 接続します。
2. スタートメニューを右クリックし、「**Windows PowerShell (管理者)**」を選択します。
3. 次のコマンドを実行して、サーバーの名前を確認します：

```powershell
hostname
```

4. PowerShell ウィンドウを開いたままにしておきます。

### オプション B: オンプレミス環境を使用した場合

1. 既存のオンプレミス Windows Server マシンに管理者としてログインします。
2. スタートメニューを右クリックし、「**Windows PowerShell (管理者)**」を選択します。
3. 次のコマンドを実行して、サーバーの名前を確認します：

```powershell
hostname
```

4. PowerShell ウィンドウを開いたままにしておきます。

## タスク 2: Azure Arc 接続スクリプトを生成する

1. Azure ポータルで、検索バーに「**Azure Arc**」と入力し、表示されるサービスをクリックします。
2. 左側のメニューから「**Azure Arc リソース - マシン**」をクリックします。
3. 「**追加**」ボタンをクリックします。
4. 「**サーバーの追加**」をクリックします。

![Arc Onboarding 1](../../images/module2/arc_onboarding_1.png)

5. 単一サーバーの追加の「**スクリプトを生成する**」タブを選択します。

※「複数のサーバーの追加」の場合、サービスプリンシパルを利用したスクリプトが生成されるため、スクリプト実行時に Azure へのログインが求められません。一度に多数のサーバーを追加する場合に最適です。

![Arc Onboarding 2](../../images/module2/arc_onboarding_2.png)

6. 次の設定を入力します：

   - **サブスクリプション**: ご使用のサブスクリプション
   - **リソースグループ**: rg-arcservers
   - **地域**: お近くのリージョン
   - **オペレーティングシステム**: Windows
   - **接続方法**: パブリックエンドポイント
     ※プロキシ経由であればその設定を入れる旨の記載をする
     ※ExpressRoute 経由の設定は可能だが、インターネット経由が必要であることに関しては注意が必要

![Arc Onboarding 3](../../images/module2/arc_onboarding_3.png)

7. 「**次へ: タグ**」をクリックします。
8. 任意のタグを追加します（例: Environment=Lab）。
9. 「**次へ: スクリプトのダウンロード**」をクリックします。
10. 「**スクリプトのダウンロード**」をクリックし、スクリプトをダウンロードまたはコピーします。

![Arc Onboarding 4](../../images/module2/arc_onboarding_4.png)

## タスク 3: Arc Connected Machine Agent のインストール

### オプション A: Azure VM を使用した場合

1. ダウンロードまたはコピーしたスクリプト（OnboardingScript.ps1）を対象の仮想マシンで実行します。

2. 対象サーバー の管理者 PowerShell で、スクリプトがある場所に移動します：

```powershell
cd C:\path\to\script\folder
```

3. スクリプトを実行します：

```powershell
.\OnboardingScript.ps1
```

4. スクリプトが実行されると、Azure 認証が要求されます。表示される URL にアクセスし、コードを入力してログインします。
5. インストールが完了するまで待ちます（約 5 分程度）。

### オプション B: オンプレミス仮想マシンを使用した場合

1. ダウンロードしたスクリプト（OnboardingScript.ps1）をオンプレミス Windows Server マシンにコピーします。例えば：

   - USB ドライブを使用してスクリプトを転送する
   - ファイル共有を介してスクリプトをコピーする
   - オンプレミスサーバーから直接 Azure ポータルにアクセスしてスクリプトをダウンロードする

2. 管理者 PowerShell で、スクリプトがある場所に移動します：

```powershell
cd C:\path\to\script\folder
```

3. スクリプトを実行します：

```powershell
.\OnboardingScript.ps1
```

4. スクリプトが実行されると、Azure 認証が要求されます。表示される URL にアクセスし、コードを入力してログインします。
5. インストールが完了するまで待ちます（約 5 分程度）。

> **注意**: オンプレミス環境から Azure に接続する場合、プロキシ設定が必要な場合があります。その場合はスクリプト内のプロキシ設定部分を適宜変更してください。

## タスク 5: オンボーディングの確認

1. Azure ポータルに戻り、「**Azure Arc**」→「**マシン - Azure Arc**」に移動します。
2. リストにサーバーが表示され、ステータスが「接続済み」になっていることを確認します。
3. サーバーをクリックして、詳細ページを確認します。

![Azure Arc接続済みサーバー](../../images/module2/check_connected_server.png)

## 次のステップ

これで、オンプレミスサーバーが Azure Arc に正常にオンボーディングされました。次のモジュールでは、Microsoft Defender for Servers を有効化して構成します。

[モジュール 3: Microsoft Defender for Servers の有効化と構成](../module3/README.md)に進みます。
