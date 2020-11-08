# Uzantılar (Extensions)

Bir projeyi en rahatlacak ve kodlarımıza güç katacak kısım olarak tam da burayı düşünebiliriz.Buradaki amacımız yapılara güç kazandırıp hem kodsal açıdan avantaj elde etmek hem de fazladan değer katmaktır.

Extension hemen hemen tüm modern dillerde mevcuttur.Dillere göre farklı özellikleri; örneğin swift dili için kendi kurucu metodu olması içinde fonksiyon yazılması gibi gelişmiş kullanımları mevcut dartta daha standart ama işimizi oldukça kolaylaştırıyor.

Bir extension yazmadan önce düşünmemiz gereken neye, nerede, ne kadar ihtiyacımız var.Örneğin tüm sayfalarda hemen hemen padding kullanırız.Yani boşluk vermek için bir değer atarız bunu her yerde elle tanımlamak yerine bir extension yazarak context değerimiz aracılığıyla erişebiliriz.

```dart
extension PaddingExtension on BuildContext {
    EdgeInsets get paddingLow => EdgeInsets.all(lowValue);
}
```

İlk extension'umuzun ismini yazıyoruz 'on' dan sonraki kısımda ise neye değer kattığımızı ekleyerek tamamlamış oluyoruz.

```dart
import 'context_extension.dart';

class HelloView extends StatelessWidget {
  const HelloView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:context.paddingLow,
      child: child,
    );
  }
}
```

Diyerek hem merkezi hem de sayfalarımızın hepsinde ortak bir padding değeri kullanmış oluyoruz.Bunu istediğimiz her yere bu mantıkla dahil edebiliriz.

Burada dikkat etmeniz gereken bir extension'u ilgili sınıfa kazandırabilmeniz için o extension sınıfını ilgili sayfaya import etmiş olmanız gerekiyor.Bu path sayesinde o extension'a erişip gücünü o değere veriyor.

---

Ve ana modelimiz de hazır daha fazlası için 🥳

[![Extension](https://img.youtube.com/vi/FRStsCaAm_g/0.jpg)](https://www.youtube.com/watch?v=FRStsCaAm_g&list=PL1k5oWAuBhgV_XnhMSyu2YLZMZNGuD0Cv&index=9)
