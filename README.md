# app-testing-demo-actions
Azure App TestのGitHub Actionsによるデモ

# 0. 前提事項
- 有効なAzureサブスクリプションを保持していること
- Azure DevOps環境を保持していること
- GitHub 環境を保持していること

# 1. Azure リソースの作成
```
az group create --name <your-resource-group> --location japaneast

az deployment group create `
--resource-group <your-resource-group> `
--template-file deploy/main.bicep `
--parameters envFullName='<your-full-name>'
```

![image.png](images/000.png)

# 2. Load Test の作成
Load test自体は 2025年10月現在 APIが提供されていないため IaC化ができない。そのため手動による構成が必要。

- URLベースのテストを作成する

![image.png](images/001.png)

- Basics

|要素|値|備考|
|--|--|--|
|テスト名|load-test-demo-001|任意でOK、ただし半角英数字|
|テストの目的|demo用の簡単なテスト|任意でOK|
|詳細設定を有効にする|OFF|―|
|テストURL|`https://asp-app-testing-demo.azurewebsites.net/`|テストしたいエンドポイント ここではApp Serviceのエンドポイントを指定|
|負荷の指定|仮想ユーザー|―|
|仮想ユーザーの数|50|任意|
|テスト期間(分)|2|デフォルトは20|
|増加時間(分)|1|任意|

![image.png](images/002.png)

- 確認および作成で、作成をクリック

![image.png](images/003.png)

- テストが作成され、自動的に開始される

![image.png](images/004.png)

# 3. Azure Pipelines による App Testing 自動化

## 3.1 Azure DevOpsへ拡張機能をインストール
マーケットプレースより、`Azure Load Test` をインストール

![image.png](images/005.png)

## 3.2 Service Connectionの作成

Create service connection をクリックし、Azure Resource Managerを選択しNext
![image.png](images/006.png)

|要素|値|備考|
|--|--|--|
|Identity type|Managed Identity|―|
|Subscription for managed identity.|<your-subscription-id>|―|
|Resource group for managed identity.|<your-resource-group>|`#1で作成したリソースグループ`|
|Managed Identity|<your-managedid>|`#1で作成したマネージドID`|
|Scope level for service connection.|
Subscription|―|
|Subscription for service connection.|<your-subscription-id>|―|
|Service Connection Name|sp-app-testing-demo|任意の名称を指定|
|Security|ON|―|

## 3.3 Azure Repos を作成
任意の Projectへ、Azure Reposを作成する

GitHub リポジトリからAzDOフォルダをAzure DevOpsへ移してPushする

![image.png](images/007.png)

> [!IMPORTANT]
> testId を Load Test のIDに変更すること

## 3.4 Azure Pipelines を作成

![image.png](images/008.png)

![image.png](images/009.png)

![image.png](images/010.png)

# 4. GitHub Actions による App Testing 自動化

## 4.1 GitHub Repository を作成
任意の Organizationへ、Repositoryを作成する

GitHub リポジトリから作成したリポジトリへ移してPushする

