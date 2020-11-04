# Android Uygulama Paket, Market Yönetimi ve Fastlane

Artık uygulamamızın mimarisini yazıp başlayıp bitirdik ve marketlerde görmek istiyoruz.Burada Android tarafı için yapmamız gereken süreçler ve bu süreçler sonunda Google Play Store tarafında görmüş olacağız.

Peki Süreçler:

- Test Süreci:
  - En sağlam ve güvenilir olarak [Google Play Console](https://play.google.com/console/u/0/signup) üzerinden bu işleri yönetiyoruz.
  - [Firebase App Distiribution](https://firebase.google.com/docs/app-distribution/android/set-up-for-testing) ise hızlı ve hiç beklemeden müşterilere sunmak için iyi ve yeni bir çözüm.
- Canlı Yayın Süreci:
  - Artık test yaptık, ilgili [app bundle](https://developer.android.com/platform/technology/app-bundle) dosyamız hazır ve bu dosyayı ilgili store adımlarını tamamlayarak markete yüklüyoruz.
- Geri Bildirim
  - Uygulama ilgili markete çıktıktan sonrasında gelen yorumları okuyup store üzerinden cevap vererek uygulamamızı daha popüler hale getiriyoruz.

Biz bu mimari serisinde fastlane üzerinden daha çok gittik ama ilk sıfırdan nasıl bu süreçler olur merak edenler [**bu içerikten**](https://www.youtube.com/watch?v=RiuyVxte5vw) videoyu izleyip öğrenebilir.

> Google Play son süreçlerde artık daha fazla dikkat ederek paketleri kontrol edip çıkmaya çalışıyor. Test için attığınız ilk paketin bir kaç gün sonra görmeniz mümkün olabilir.

> Canlı yayına geçerken ekran görüntüleri dahil olmak üzere her şeye takıyorlar.Ben genelde [buradan](https://www.appstorescreenshot.com/) yapıyorum siz de seçebilirsiniz.

> Uygulamanızı çıkarken muhakkak önce internal test açıp ardından beta ve en son canlıya şeklinde gitmeyi unutmayın.

Paketi çıkma işleminde ya manuel yöntemler videoda anlattığım gibi yada şimdi anlatacağım fastlane gibi otomasyonlar ile doğrudan paketinizi canlıya çıkabilirsiniz.Bunun dışında paketinizi release modda çıkmış olmanız önemlidir.

## Fastlane

Fastlane bizim için ara tüm işlemleri yapan kocaman bir app distribition uygulamasıdır.İçinde envayi çeşit yöntem ile paketimizi tek tuşla çıkma imkanı sunar.

Bu paketlerden bazıları:

- [Google Play Track Number](http://docs.fastlane.tools/actions/google_play_track_version_codes/#google_play_track_version_codes)
- [Git push](http://docs.fastlane.tools/actions/push_git_tags/#push_git_tags)
- [Slack Message](http://docs.fastlane.tools/actions/slack/#slack)
- [Screen Shoot Upload](http://docs.fastlane.tools/getting-started/android/screenshots/#upload-screenshots-to-google-play)

Buradaki amacımız bir hat kurarak işlemleri yapmasını sağlayıp markete doğrudan hiç uğraşmadan paket çıkmaktır.

Örnek olarak bakacak olursak.

```sh
    desc "Deploy to internal test application"
  lane :internal do |options|
    versionNumberArrayLength = google_play_track_version_codes(track:INTERNAL)
    versionNumber = (versionNumberArrayLength.length > 0 ? versionNumberArrayLength[0] : 0).to_i + 1
    incerementVersion version: options[:version]
    setVersionNumber versionNumber: options[:versionNumber]
    versionName = getVersionName()
    flutter_build(versionName,versionNumber)
    buildStore(INTERNAL)
  end
```

Bakın burada marketten ilgili son paketin numarasını alıp bir artırıp bununla paket çıkıp doğrudan test flighta atıyor.Yorum satırı eğer yapsaydık doğrudan slack kanalınıza linki atıp teste hazırım diyebilirdi.

Burdan sonrasında fastlane size verdiği nimetleri kullanarak kendi kurallarınıza göre yapacaksınız.

> Eğer burada if else gibi bir yapı kurup kod yazmak isterseniz ruby diline bakıp burada kullanabilirsiniz.

```ruby
 private_lane :setVersionNumber do |options|
      if options[:versionNumber] != nil
       set_properties_value(
        key: ANDROID_VERSION_NAME,
        path: ENV_PATH,
        value: options[:versionNumber]
        )
    end
  end
```

Buradaki gibi misal kendi kullandığım bir projede hazırlayıp kullanıcı farklı bir şey girerse standart olarak minoru alıyordum.Bu projede paket çıkmak için yaptığım tek adım ise şu şekilde:

`cd android fastlane release env:patch(minor||major)`

---

Ve ana modelimizde hazır daha fazlası için 🥳

[![Mobx](https://img.youtube.com/vi/RiuyVxte5vw/0.jpg)](https://www.youtube.com/watch?v=RiuyVxte5vw)

[![Android](https://img.youtube.com/vi/6RK45v7M1wQ/0.jpg)](https://www.youtube.com/watch?v=poog2mJ4Tko&list=PL1k5oWAuBhgV_XnhMSyu2YLZMZNGuD0Cv&index=13)
