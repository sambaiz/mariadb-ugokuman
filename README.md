# MariaDB動くマン

- 192.168.33.10::3306でMariaDBが稼働する
- root/rootで接続できる
- デフォルト文字コードはUTF-8

## 使い方

- box add (最初だけ)

```
vagrant box add centos7  https://f0fff3908f081cb6461b407be80daf97f07ac418.googledrive.com/host/0BwtuV7VyVTSkUG1PM3pCeDJ4dVE/centos7.box
```

- install itamae (最初だけ)

```
bundle install
```

- up (立ち上がってないなら)

```
vagrant up
```

- MariaDBのインストール+設定

```
itamae ssh -h 192.168.33.10 -u vagrant roles/db.rb
```

- 確認

```
mysql -h192.168.33.10 -uroot -proot
mysql > status
```
