# İsimlendirme

![nameds](../../image/drawio/nameds.png)

Ve geldik yine benim en değer verdiğim konuya isimlendirme yaparken nelere dikkat etmeliyiz neler önemli.

> Bir projede her şey belirli bir düzende ilerleyebilir ama özellikle kodun okunması, yeri veya anlamı gibi konular ilk isimlendirmelerle başlar.

## Klasörler

- Ana katmana kod yazmak istiyorsak;

`core/KATMANLAR`

- Ekran geliştirmek istiyorsak;

`features/GELİŞTİRMELER`

- Ana katmana modül eklemek istiyorsak;

`core/base/Modüller`

`core/init/Modüller`

`core/constants/Modüller`

`core/components/Modüller`

`core/extensions/Modüller`

- Bir ekran geliştirmesine parça yapmak için;

`features/login/model`

`features/login/view`

`features/login/view-model`

`features/login/service` (isteğe bağlı ama ayırmayı severim)

## Dosya İsimlendirme

Yine burada en iyi kullanım olarak [camel case pattern ](https://www.geeksforgeeks.org/convert-camel-case-string-to-snake-case-in-java/)tercih ediyorum.

- Bir geliştirmenin alt dallarını yaparken;

`features/login/model/login_model.dart`

`features/login/view/login_view.dart`

`features/login/view-model/login_view_model.dart`

`features/login/service/login_service.dart`

- Bir atomic widget yaparken;

`ATOMADI_YAKINLIK.dart` örneğin `facebook_text.dart`

- Eğer bir yönetim sınıfı yapıyorsak ise bu şekilde gidebiliriz;

  `network_manager.dart`

  `locale_manager.dart`

  `state_manager.dart`

## Değişkenler ve Sabitler

Yine çok fazla önemli olan bir konuya geldik. Burada tercih de var ama tabiki lint kuralları da göz önüne alınarak seçimler var.

- Proje boyunca değişmeyecek ve değerini bir çok yerde kullanacağımız bir değişkene ihtiyacımız varsa "[Magic Number](https://help.semmle.com/wiki/display/JAVA/Magic+numbers#:~:text=A%20magic%20number%20is%20a,for%20other%20programmers%20to%20understand.)" tercih ediyorum.

`static const PROJECT_NAME = "HWA"`

- Proje içinde sadece sınıf içinde değişmeyecek bir değişken kullanıyorsak;

`final String userName = "Veli"`

> Genel olarak isimlendirmede [camelCase](https://techterms.com/definition/camelcase) tercih ediyorum ama sabitlerde bu durumu değiştriyorum.

- Bir sınıf tanımlarken;

`class User{} or class UserDetail{}`

- Bir sıralama sınıfı kullanmak istersek;

`enum TimeValues {MIN,NORMAL,MAX}`

> Burada enumlarımıza extension yazarak ona güç kazandırabiliriz.
> Örnek olarak extension TimeValuesExtension on TimeValues { String get name => this.toString() } gibi.
> Bu konuyu extension başlığında inceleyeceğiz.
