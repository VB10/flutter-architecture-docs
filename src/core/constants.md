# Sabit Değerler (Constants)

Bir uygulama hayatında çok önemli olmasada yönetimi açısından önemli olan bir kavramdır. Özellikle sabit tanımlarken iki tavır belirliyorum genelde:

1. Proje boyunca kullanılacak ve katma değeri çok yüksek ise(Proje ismi gibi) bunları [Magic Number](https://help.semmle.com/wiki/display/JAVA/Magic+numbers#:~:text=A%20magic%20number%20is%20a,for%20other%20programmers%20to%20understand.) olarak tanımlıyorum.
2. Projede gerekli alanlarda ihtiyacım olacak ise [lazy singleton pattern](https://www.journaldev.com/1377/java-singleton-design-pattern-best-practices-examples#eager-initialization) kullanarak yapıyorum.

> Bu tarz tanımlamalar yaparken kendi oluşturduğum snippet'larımı kullanarak çok hızlıca tanımlıyorum

## Magic Number

Burada aslında temel olarak bize anlatılmak istenen ilgili değişkenin projenin en üstünde ve değerli bir başka developerin bu değişkene dokunmaması gerektiği anlamına gelmektedir.

Tanımlanırken `constant static Type veriable_name = value;` formatında olur. Örnek olarak bakalım;

```dart
class YourConstantsClass {
  static const String PROJECT_NAME = "HWA";
  static const String FONT_FAMILY = "POPPINS";
}
```

## Lazy Singleton Pattern

Singleton pattern bildiğimiz gibi bir değişkenin hayatı boyunca ayakta tutan ve yeni bir nesne üretmemizi engelleyen dizayn olarak düşünebiliriz. Burada dizaynın alt dalları mevcut.Ben kullanırken lazy yaklaşımını seviyorum. Buradaki amaç ilgili obje çağırıldığı anda doldurulması ve bundan sonra hayatına devam etmesi.

```dart
class YourConstantsClass {
  static YourConstantsClass _instace;
  static YourConstantsClass get instance {
    if (_instace == null) _instace = YourConstantsClass._init();
    return _instace;
  }

  YourConstantsClass._init();

  String phoneNumber = "********";
  String mailAdress = "**********";
}
```

Kullanırken ise;

`Text(YourConstantsClass.instance.phoneNumber)` şeklinde çağırmış oluruz.

> Snippetlar ile magicnumber ve eager or lazy yazarak bu patterni dahil etmiş oluyorum. Sadece ismini vererek oluşuyor.

Diğer detaylara buradan erişebilirsiniz🥳

[![Theme Management](https://img.youtube.com/vi/buUw_mU-Idg/0.jpg)](https://www.youtube.com/watch?v=buUw_mU-Idg&list=PL1k5oWAuBhgV_XnhMSyu2YLZMZNGuD0Cv&index=8)

