# Uzantılar (Extensions)

Bir projeyi en rahatlacak ve kodlarımıza güç katacak kısım tam burası olarak düşünebiliriz.Buradaki amacımız yapılara güç kazandırıp, hem kodsal açıdan avantaj elde etmek hemde fazladan değer katmaktır.

Extension hemen hemen tüm modern dillerde mevcuttur.Dillere göre fakrlı özellikleri misal swift dili için kendi kurucu metodu olması içinde fonksiyon yazılmaı gibi gelişmiş kullanımları mevcut dartta daha standart ama işimizi oldukça kolaylaştırıyor.

Bir extension yazmadan önce düşünmemiz gereken neye nerede ne kadar ihtiyacımız var.Örneğin tüm sayfalarda hemen hemen padding kullanırız.Yani boşluk vermek için bir değer atarız bunu her yerde elle tanımlamak yerine bir extension yazarak context değerimiz aracılığıyla erişebiliriz.

```dart
extension PaddingExtension on BuildContext {
    EdgeInsets get paddingLow => EdgeInsets.all(lowValue);
}
```

İlk extensionumuzn ismini yazıyoruz 'on' dan sonraki kısımda ise neye değer kattığımızı ekleyerek tamamlamış oluyoruz.

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

Diyerek hem merkezi hemde sayfalarımızın hepsinde ortak bir padding değeri kullanmış oluyoruz.Bunu istediğimiz her yere bu mantıkla dahil edebiliriz.

!> Burada dikkat etmeniz gereken bir extensionu ilgili sınıfa kazandırabilmeniz için o extension sınıfını ilgili sayfaya import etmiş olmanız gerekiyor.Bu path sayesinde o extensiona erişip gücünü o değere veriyor.

---

Ve ana modelimizde hazır daha fazlası için 🥳
[![Theme Management](https://img.youtube.com/vi/FRStsCaAm_g/0.jpg)](https://www.youtube.com/watch?v=FRStsCaAm_g&list=PL1k5oWAuBhgV_XnhMSyu2YLZMZNGuD0Cv&index=9)
