# cloud-initについて
amazon-linux上では下記のバージョンが使われている。古い。。

```
# cloud-init --version
cloud-init 0.7.6
```

公式ドキュメントは[ここ](https://cloudinit.readthedocs.io/en/0.7.7)

# mime type指定したuser_dataを使う方法

- text/x-include-once-url
- text/x-include-url
  - 記述されたURLからファイルを読み込む
- text/cloud-config-archive
- text/upstart-job
  - upstartの仕組みを使ってdaemon化できる。
  - https://heartbeats.jp/hbblog/2013/02/upstart-daemon.html
- text/cloud-config
  - cloud-configシンタックスに則って記述する
  - [sample](https://cloudinit.readthedocs.io/en/0.7.7/topics/examples.html#yaml-examples)
  - /etc/cloud/cloud.cfgをインターセプトする？
- text/part-handler
  - /var/lib/cloud/data以下にファイルが保持される
  - [公式](https://cloudinit.readthedocs.io/en/0.7.7/topics/format.html#part-handler)を読んでも釈然としない
  - [このブログ](http://foss-boss.blogspot.jp/2011/01/advanced-cloud-init-custom-handlers.html)が参考になるらしい。
- text/x-shellscript
  - shellスクリプトを実施する
- text/cloud-boothook
  - /var/lib/cloud以下にファイルが保持される
  - 即時実行する
  - 1回だけの実行という仕組みができない

# Directoryレイアウト

```
/var/lib/cloud/
    - data/
       - instance-id
       - previous-instance-id
       - datasource
       - previous-datasource
       - previous-hostname
    - handlers/
    - instance
    - instances/
        i-00000XYZ/
          - boot-finished
          - cloud-config.txt
          - datasource
          - handlers/
          - obj.pkl
          - scripts/
          - sem/
          - user-data.txt
          - user-data.txt.i
    - scripts/
       - per-boot/
       - per-instance/
       - per-once/
    - seed/
    - sem/
```
