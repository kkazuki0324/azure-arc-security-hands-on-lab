# Mimikatzシミュレーションスクリプト
# このスクリプトは、実際の悪意のあるアクティビティを実行するものではなく、
# Microsoft Defender for Serversのアラートをトリガーするためのテスト用です。

Write-Host "Mimikatzシミュレーションを開始します..." -ForegroundColor Yellow

# 疑わしいコマンドパターンを実行
Write-Host "認証情報ダンプのシミュレーション中..." -ForegroundColor Cyan
$testCommands = @(
    "sekurlsa::logonpasswords",
    "lsadump::sam",
    "privilege::debug"
)

foreach ($cmd in $testCommands) {
    Write-Host "[偽のMimikatz] > $cmd" -ForegroundColor DarkYellow
    Start-Sleep -Seconds 2
}

# 疑わしいファイル名のテキストファイルを作成
$suspiciousFileNames = @(
    "mimikatz.exe",
    "mimilib.dll",
    "mimidrv.sys"
)

foreach ($fileName in $suspiciousFileNames) {
    $filePath = "C:\Windows\Temp\$fileName.txt"
    "このファイルはテスト用です。実際のマルウェアではありません。" | Out-File -FilePath $filePath
    Write-Host "疑わしいファイル名のテストファイルを作成しました: $filePath" -ForegroundColor Cyan
}

# LSASSプロセスアクセスのシミュレーション
Write-Host "LSASSプロセスアクセスのシミュレーション中..." -ForegroundColor Cyan
$lsassProcess = Get-Process -Name "lsass" -ErrorAction SilentlyContinue
if ($lsassProcess) {
    Write-Host "LSASSプロセスID: $($lsassProcess.Id)" -ForegroundColor DarkYellow
    Write-Host "[偽のアクセス] プロセスの列挙のみを実行。実際のアクセスは行いません。" -ForegroundColor DarkYellow
}

# クリーンアップ
foreach ($fileName in $suspiciousFileNames) {
    $filePath = "C:\Windows\Temp\$fileName.txt"
    if (Test-Path $filePath) {
        Remove-Item -Path $filePath -Force
    }
}

Write-Host "Mimikatzシミュレーションが完了しました。Microsoft Defender for Serversのアラートが発生するはずです。" -ForegroundColor Green
Write-Host "注意: アラートが表示されるまでに15〜30分かかる場合があります。" -ForegroundColor Yellow
