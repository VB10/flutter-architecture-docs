# Tema Değişikliği

Tema konusu flutter da çok önemli bir yer tutuyor. Özellikle flutter'in bize vermiş olduğu en büyük güçlerden olan tema karanlık(dark) ve aydınlık(light) özelliği bize ilk olarak verilmekte.

```dart
MaterialApp(theme: ThemeData.dark()) // ThemeData.light()
```

Örnekteki şekilde görebilirsiniz. Bizim yapacağımız adımla bu tema değişimini proje çalışrıken yapmayı sağlayacağız.

> Flutter bizim için ilk halinde bir [tema](https://flutter.dev/docs/cookbook/design/themes) sunuyor projelerimizde elle değer vermek yerine bu temayı kullanarak adım atabiliriz.

Bunu yapmak yerine;
`Text("VB",style:TextStyle(fontsize:35))`

[Bu ve benzeri](https://material.io/design/typography/the-type-system.html#type-scale) mantığı kullanmalısınız;

`Text("VB",style:Theme.of(context).textTheme.headline5)`

Bu yapıyı kullanmak çok önemli isterseniz [panache](https://rxlabz.github.io/panache/#/) kullanarak kendi temanızı oluşutabilirsiniz bu konuda [bu içeriğe de göz](https://www.youtube.com/watch?v=Eve_oMoH_WM) atabilirsiniz..

Şimdi gelelim asıl işimize bu tema nasıl olacakta proje boyunca değişecek işte o noktada flutter projelerinde en çok kullanılan [provider](https://pub.dev/packages/provider) paketinden yararlanacağız.

> Provider konusu state yönetimi dersindede işleyeceğim ama özetle bilmeniz gereken provider bizim için proje en üstünde saklamak veya anlık değişlikler yapmak istediğimiz noktlarda kolayca erişme imkanı sunan bir paket.

Burada ana amacımız bir teme sınıfı oluşturup bunu provider objemiz ile tanımlamak ve artık geri kalanını ona bırakmak olacak.

Bir ThemeNotifier sınıfı oluşturuyor ve bu sınıfı ChangeNotifier dan türeterek bu sınıfın objelerine dinleyenlere anlık değişimlerde kendilerini yenileme haberi veriyoruz.

`class ThemeNotifier extends ChangeNotifier {}`

Ardından ilgili sınıfımzda şuanki temamızı tutan bir değişken tanımlıyoruz.

`ThemeData _currentTheme = AppThemeLight.instance.theme;`

Son olarak yapmamız gereken bu sınıftan türeyenlere değişikleri haber verecek kısımda

```dart
 void changeValue(AppThemes theme) {
    if (theme == AppThemes.LIGHT) {
      _currentTheme = ThemeData.light();
    } else {
      _currentTheme = ThemeData.dark();
    }
    notifyListeners();
  }
```

!> Bu kısımda ben cache yapımıda dahil edip değişiklikleri telefon hafızasında tutuyorum.İlk açılıdığı anda değeri oradan tanımlayıp bu sayede son değişiklikle tekrar çalıştırmış oluyorum.

Tema değişikliği özelliğimiz hazır yapmamız gereken bu değeri provider kısmında tanımlamak.

```dart
   List<SingleChildWidget> dependItems = [
    ChangeNotifierProvider(
      create: (context) => ThemeNotifier(),
    )
  ];
```

İlgili provider obje sınıfını da main.dart dosyamızda çağırdıktan sonrasında projemizin herhangi bir yerinde bu objeye erişip temayı değiştirebiliriz.

`MultiProvider( providers: [...ApplicationProvider.instance.dependItems],`

Artık MaterialApp altındakı temayı şu şekilde tanımlıyoruz;
`theme: Provider.of<ThemeNotifier>(context, listen: false).currentTheme,`

Örnek kullanım ise;
`Provider.of<ThemeNotifier>(context).changeValue(AppThemes.dark)`

Diğer detaylara buradan erişebilirsiniz;
[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/Xn8q9ywXKDc/0.jpg)](https://www.youtube.com/watch?v=Xn8q9ywXKDc&list=PL1k5oWAuBhgV_XnhMSyu2YLZMZNGuD0Cv)
