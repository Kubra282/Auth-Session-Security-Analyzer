# Auth Analyzer – Teknik Araştırma Sonucu

## 1. Genel Tanım
Auth Analyzer, :contentReference[oaicite:0]{index=0} için geliştirilmiş bir **BApp (Burp eklentisi)** olup, web uygulamalarındaki **yetkilendirme (authorization)** ve **erişim kontrolü (access control)** açıklarını tespit etmeye odaklanan bir güvenlik test aracıdır.

Araç, aynı HTTP isteklerini farklı kullanıcı oturumları (session) ile otomatik olarak tekrar göndererek, **yetki atlama**, **yatay (horizontal) ve dikey (vertical) privilege escalation** gibi zafiyetleri saldırgan perspektifiyle analiz eder.

Auth Analyzer, Burp Suite Professional ve Community Edition üzerinde proxy trafiği üzerinden çalışır ve kullanıcı gezintisi sırasında yakalanan istekleri temel alır.

---

## 2. Temel Çalışma Prensipleri

### 2.1 Oturum Tanımlama
- Farklı kullanıcı rollerini temsil eden session tanımları oluşturulur.
- Admin, standart kullanıcı veya anonim kullanıcı gibi roller için cookie veya token değerleri manuel olarak eklenir.

### 2.2 Parametre Çekme ve Yerine Koyma
- CSRF token, session cookie ve bearer token gibi dinamik değerler otomatik olarak yanıt içinden çekilir.
- Bu parametreler URL, header, JSON body veya cookie alanlarında güncellenir.

### 2.3 İstekleri Tekrar Gönderme
- Kullanıcı tarayıcıyla uygulamayı gezerken oluşan istekler, tanımlı tüm oturumlar için otomatik olarak yeniden gönderilir.
- Böylece bir rolün erişemediği kaynağa başka bir rolün erişip erişemediği test edilir.

### 2.4 Bypass Analizi
- Dönen yanıtlar karşılaştırılır.
- Sonuçlar **SAME**, **SIMILAR** ve **DIFFERENT** olarak sınıflandırılır.
- Yetkisiz erişim veya veri sızıntısı ihtimalleri değerlendirilir.

---

## 3. Best Practices (En İyi Uygulamalar)

### 3.1 Test Kapsamı
- Sadece oturum ve yetkilendirme içeren endpoint’lerin test edilmesi yanlış pozitifleri azaltır.
- Burp Suite scope ayarları aktif kullanılmalıdır.

### 3.2 Parametre Doğruluğu
- Auto extract yapılandırmaları dikkatle ayarlanmalıdır.
- Yanlış token çekimi test sonuçlarını geçersiz kılabilir.

### 3.3 Farklı Roller
- Birden fazla yetki seviyesine sahip oturum tanımlanmalıdır.
- Bu yaklaşım yatay ve dikey yetki atlama açıklarını ortaya çıkarır.

### 3.4 Manuel Doğrulama
- Otomatik etiketler manuel inceleme ile doğrulanmalıdır.
- Yanıt içerikleri detaylı olarak analiz edilmelidir.

---

## 4. Benzer Araçlar ve Rakipler

| Araç | Açıklama |
|----|----|
| Autorize | IDOR ve access control testleri için Burp eklentisi |
| Burp Extensions | Param Miner gibi çeşitli test eklentileri |
| :contentReference[oaicite:1]{index=1} | Burp’a alternatif açık kaynak DAST aracı |

---

## 5. Kritik Yapılandırmalar

### 5.1 Session Header Ayarları
- Cookie veya Authorization header’ları tanımlanır.
- Farklı oturumlar için ayrı değerler kullanılır.

### 5.2 Extraction Parametreleri
- Auto Extract veya From–To yöntemleri ile dinamik token’lar çekilir.

### 5.3 Filtreler
- Statik dosyalar veya test dışı istekler filtrelenebilir.

---

## 6. Güvenlik Perspektifi

- Horizontal ve vertical privilege escalation açıkları ana hedeflerdir.
- Dinamik token ve CSRF yapılandırmaları doğru olmalıdır.
- Yanlış session tanımları yanlış pozitif sonuçlara yol açabilir.

---

## Sonuç
Auth Analyzer, web uygulamalarında oturum ve yetkilendirme zafiyetlerini yarı otomatik olarak test eden güçlü bir Burp Suite eklentisidir. Doğru konfigürasyon ve manuel analizle birlikte kullanıldığında, güvenlik test süreçlerinde yüksek değer sağlar.
