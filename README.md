# AWS IaC Training Repository

このリポジトリは、**AWS環境のInfrastructure as Code (IaC)** のトレーニング目的で作成されたものです。  
主に **Terraform** による最小構成のコードを管理しています。

## 構成内容

- TerraformによるS3バケット、IAMロール等のリソース定義
- モジュール化・環境分離などは最小限に抑えたシンプルな構成

## 利用手順

Terraformの基本的な実行手順は下記です：

```bash
terraform init
terraform plan
terraform apply
