# Terraform Chef Tutorial
Chefのチュートリアル環境をTerraformで構築

# 準備
## terraformのインストール

下記からダウンロードしてPATHを通す

https://www.terraform.io/downloads.html

## 開発環境
Jetbrainsのpluginが良い感じなのでJetbrains系のIDEを使う

https://plugins.jetbrains.com/plugin/7808-hashicorp-terraform--hcl-language-support

# terraformの習熟に向けて
- 使い込みが足りないので妄想が入っているかもしれないので注意
- aws, azureあたりで使うことを想定
- openstackでの利用は挫折している

Deprecatedになってしまったが、githubのhashicorpが出しているbest-practicesに学ぶ所はあった。

https://github.com/hashicorp/best-practices

はじめはベタ書きして簡単な構成を組み、その後大きくなってくる構成のリファクタをこのbest-practicesで学ぶことができると思う。

各種exampleから盗むもよし

- https://github.com/terraform-providers/terraform-provider-aws/tree/master/examples
- https://github.com/terraform-providers/terraform-provider-azurerm/tree/master/examples

# 鍵の管理
aws consoleのEC2管理画面でkeyを作成して、それをtfファイル内で指定している。

chef-nodeとchef-server(workstation)間でsshで手軽に行き来したかったので、鍵を保持してしまっている。

適宜差し替えが必要。

秘密鍵から公開鍵を作成する場合は以下のコマンドでいけるはず
```
$ ssh-keygen -y -f ~/.ssh/chef_sample.pem > ~/.ssh/chef_sample.pub
```

# その他
[cloud-initに関して](docs/cloud-init.md)
