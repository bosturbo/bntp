# OS X Mavericks用の独自NTP daemonを作る

OS X Mavericksのntpdで時刻をNTP serverと同期出来ずに遅れていく現象が出ることがある。
一度この現象が出て解消する方法がよくわからず、独自にNTP daemonをbuildして実行すれば良いという話があったので、OS Xのappとして作ってみた。

## インストール

git cloneしてmakeするとbntp.appが出来るので、Finderで/Applications へインストールする。

## 実行

bntp.appを実行するとsudoする為にAppleScriptでパスワードを聞いてくるのでユーザーのパスワードを入力して特権を得、ntpdを実行する。

## 終了

AppleScriptにon quitを記述してあるので、bntp.appを終了する時にpkill ntpをする。sudoのパスワードを聞かれるかもしれない。

## アンインストール

bntp.appをゴミ箱へ捨てます。

## バグ

解決するって話があったようだが、手元のMacBook ProとOS X Mavericksでは時刻が遅れる現象は解消出来ない事があった。時刻の進み具合を同期するのに時間がかかっていたなど、環境によるかもしれないが、このappが役に立つかは分からない。
