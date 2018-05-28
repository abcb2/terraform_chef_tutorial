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
- aws, azureあたりで使うことを想定
- openstackでの利用は挫折している

Deprecatedになってしまったが、githubのhashicorpが出しているbest-practicesに学ぶ所はあった。

https://github.com/hashicorp/best-practices

はじめはベタ書きして簡単な構成を組み、その後大きくなってくる構成のリファクタをこのbest-practicesで学ぶことができると思う。

各種exampleから盗むもよし

- https://github.com/terraform-providers/terraform-provider-aws/tree/master/examples
- https://github.com/terraform-providers/terraform-provider-azurerm/tree/master/examples

# 鍵の管理
aws consoleのEC2管理画面でkeyを作成して、それをこのレポジトリ外で管理している。

chef-nodeとchef-server(workstation)間をsshで手軽に行き来したかったので、ssh-agentを利用してエージェントフォワーディングしている。

chefのbootstrapのためにrootユーザーでも行き来できるようにcloud-initのshellスクリプト実行で鍵は配布している。

つまるところssh-agentは使わないでもよいが、記述は残しておく。

ssh-agentを起動して鍵を追加しておく
```
$ ssh-agent
$ ssh-add ~/.ssh/chef_sample.pem
```

```
$ ssh -A -i /path/to/key_of_ec2 ec2-user@xxx.xxx.xxx.xxx
$ ssh -A chef-server
```

## tips

秘密鍵から公開鍵を作成する場合は以下のコマンド

```
$ ssh-keygen -y -f ~/.ssh/chef_sample.pem > ~/.ssh/chef_sample.pub
```

# terraformでのインフラ準備

## validate

```
$ terraform plan  -var-file=config/user01.tfvars
```

## 実行

```
$ terraform apply -var-file=config/user01.tfvars
```

## 削除

```
$ terraform destroy -var-file=config/user01.tfvars
```

# chef tutorial

[ここ](https://qiita.com/abcb2/items/f3f390ee7f83943293fc)を参考に。。

chef-workstationとchef-serverは同一の場所にしている。

# その他
[cloud-initに関して](docs/cloud-init.md)
