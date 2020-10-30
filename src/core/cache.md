# Veri Saklama (Local Cache)

Veri konusu özellikle mobil uygulamada en önemli noktlaradan birisi değil takendisidir çünkü uygulamamız canlıya çıktığında(ilgili marketler de yayına girdiği an) eğer bir güvenlik testine girerse ilk baktıkları nokta uygulamnın cihaz içindeki verileri nerede ve nasıl tuttuğudur. Peki bu veriler nedir:

1. Kullanıcının kimlik bilgileri(token,id vb)
2. Uygulamanın verileri
3. Az sıklıkla kullanılacak servisden gelen bilgiler(iller, kan grupları vb.)

Tabiki liste uzar gider. Biz bu verileri mobil uygulamalarda yine bir kaç yöntem ile saklayabiliriz:

- Key-Value([Shared](https://developer.android.com/reference/android/content/SharedPreferences),[UserDefaults](https://developer.apple.com/documentation/foundation/userdefaults))
- File (Doğrudan bir json veya txt dosyasına yazmak)
- [SQLite](https://www.sqlite.org/index.html) (Mobil telefonlar için basit sql database)
- [Core Data ](https://developer.apple.com/documentation/coredata)(Sadece IOS Framework'ü destekleyen bir database mimarisi)

Ve bir kaç özel platform dahilindeki çözümler ile bize saklama imkanı sunuyor. Basit veriler saklamak için en sevdiğim çözüm ise shared yapısı.

Burada verilerin saklandığı yerde önemli bir notka. Bu noktada elimizde uygulama içinde kullancının direk erişemediği alan ve telefonun içine kaydetmek üzere alanlar bulunmaktadır.

!> Özellikle bu verileri saklamalardan hangisini seçerseniz seçin bir şekilde telefon rootlanarak güvenlik şirketleri tarafından teste sokulup sakladığınız veriler erişip buradan sizin zaafiyetinizi bulabilirler. Bundan ötürü şimdiki yazacağımız cache katmanı önemli ve isterseniz bir kaç özellik katarak bazı verileri kullacının bilgilerini şifreleyebilir ve bu sayede güvenliğinizi artırabilirsiniz.

[Shared Preferences](https://pub.dev/packages/shared_preferences) yani key-value kullanacağım yapıda saklamak için bir kaç özel ekleme yapıyor ve bu proje boyunca kullanacağım için bir eager singleton pattern kullanarak bu değeri bir kere üretip devam ettiriyorum.

[Bu yazımda](https://medium.com/flutter-community/cache-manager-with-flutter-5a5db0d3a3e6) projede özellikle bu cache katmanını bir kaç kalemde ele alıp [strategy pattern](https://refactoring.guru/design-patterns/strategy) kullanarak detay bir şekilde ele aldım.

```dart
class LocaleManager {
  static LocaleManager _instance = LocaleManager._init();

  SharedPreferences _preferences;
  static LocaleManager get instance => _instance;
}
```

Burada ilk sınıf oluşurken [SharedPreferences](https://www.youtube.com/watch?v=aV4eLUTPSUM) değerinin bir oluşması gerekiyor.(Asenkron bir istek bu değeri ilk sınıf oluşruken çağırıyoruz ama dediğim gibi bir asenkron olmaa durumu olduğu için değerin tam olarak almama durumu mevcut.).

```dart
  LocaleManager._init() {
    SharedPreferences.getInstance().then((value) {
      _preferences = value;
    });
  }
```

Bu durumu önlemek için bir şöyle bir çözüm getirip kesin bir şekilde değerin verilmiş olmasını sağlıyorum.

```dart
  static prefrencesInit() async {
    if (instance._preferences == null) {
      instance._preferences = await SharedPreferences.getInstance();
    }
    return;
  }

```

Ve ilgili değeri `main.dart` dosyasında çağırıyorum.

```dart
Future<void> main() {
  WidgetsFlutterBinding.ensureInitialized();
  await LocaleManager.prefrencesInit();
  runApp(...)
}
```

Ve hazırız artık shared değerimiz elimizde hazır. Şimdi ben projelerimde şu şekil de gidiyorum:

- [Key - value](https://www.youtube.com/watch?v=aV4eLUTPSUM) yapısı olduğu için key değerini adamın elle vermemesi için enum istiyorum ve gelen enumun değerini toString diyerek key yapıyorum.
- İlgili metodları ben kendim tekrar yazıyorum.(setStringValue ,setBoolValue)
- Yine ilgili değerleri verdikten sonra bu değerleri almak için getStringValue metodlarını yazmış oluyorum

> İşte bu yönetici sınıfı ile ileride her kaydettiğimiz verinin şifrelenmesini burada yapmış olacağız.
> Değeri ilk başta asenkron olarak yüklediğimiz için getStringValue dediğimizde doğrudan değeri okuyabiliyoruz aksi halde async dememiz gerekecekti.

```dart
 Future<void> setStringValue(PreferencesKeys key, String value) async {
    await _preferences.setString(key.toString(), value);
  }

  String getStringValue(PreferencesKeys key) =>
      _preferences.getString(key.toString()) ?? "";
```

Paramtre olarak istenilen ise bir enum olup her yeni değer saklamak istediğimizde buraya paramtre olarak ekleyeceğiz.

```dart
enum PreferencesKeys {
    APP_NAME
}
```

Ve artık hazırız. Projemizde istediğimiz an şu şekilde çağırabiliriz:

```dart
Text(LocaleManager.getStringValue(PreferencesKeys.APP_NAME));
```

Diğer detaylara buradan erişebilirsiniz 🥳

[![Theme Management](https://img.youtube.com/vi/4U8ekZJLxac/0.jpg)](https://www.youtube.com/watch?v=4U8ekZJLxac&list=PL1k5oWAuBhgV_XnhMSyu2YLZMZNGuD0Cv&index=6)
