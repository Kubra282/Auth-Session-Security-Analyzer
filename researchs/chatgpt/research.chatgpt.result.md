# Auth Analyzer – Derinlemesine Teknik Araştırma Raporu

## 1. Tanım ve Amaç
Auth Analyzer, web uygulamalarındaki **yetkilendirme (authorization)** ve **oturum yönetimi (session management)** mekanizmalarını test etmek amacıyla geliştirilen, :contentReference[oaicite:0]{index=0} üzerinde çalışan bir pentest uzantısıdır. Araç özellikle **privilege escalation** (yatay ve dikey yetki yükseltme) ve **authorization bypass** açıklarının tespitine odaklanır.

---

## 2. Temel Çalışma Prensipleri

### 2.1 Nasıl Çalışır?
- Burp Suite proxy aktif edilerek hedef web uygulaması üzerinde gezinilir.
- Auth Analyzer, seçilen kullanıcı session’larını klonlar veya farklı roller için yeni session’lar tanımlar.
- Yüksek yetkili kullanıcıya ait HTTP istekleri, düşük yetkili roller için otomatik olarak tekrar gönderilir.
- Dönen yanıtlar analiz edilerek yetki atlamaları tespit edilmeye çalışılır.

### 2.2 Akış Özeti
- Admin / user gibi farklı roller oluşturulur.
- HTTP istekleri otomatik olarak yeniden oynatılır.
- CSRF token’ları, session cookie’leri ve parametreler otomatik olarak extract & replace edilir.
- Yanıtlar karşılaştırılır ve **SAME / SIMILAR / DIFFERENT** olarak etiketlenir.

---

## 3. Best Practices ve Endüstri Standartları

### 3.1 Güvenli Oturum Yönetimi
Auth Analyzer bir koruma aracı değil, analiz aracıdır. Güvenli oturum yönetimi için:
- Cookie’lerde `Secure` ve `HttpOnly` flag’leri aktif olmalıdır.
- State-changing istekler CSRF koruması ile korunmalıdır.
- Logout sonrası session token’ları geçersiz hale getirilmelidir.

### 3.2 Yetkilendirme Kontrolleri
- Tüm roller sistematik olarak test edilmelidir.
- Düşük ve yüksek yetki istekleri otomasyon ile denenmelidir.
- HTTP status code, response body ve içerik uzunlukları karşılaştırılmalıdır.

### 3.3 İzleme ve Loglama
- Yetkisiz erişim denemeleri loglanmalıdır.
- Test sonuçları karşılaştırmalı raporlar halinde saklanmalıdır.

---

## 4. Benzer Araçlar ve Ekosistem

| Araç | Tür | Amaç |
|----|----|----|
| Auth Analyzer | Burp Extension | Yetki açıkları |
| Autorize | Burp Extension | IDOR & authorization |
| Session Auth | Burp Extension | Auth escalation |
| :contentReference[oaicite:1]{index=1} | Proxy Tool | Auth & session testleri |

---

## 5. Kritik Yapılandırmalar

### 5.1 Session ve Header Parametreleri
- Authorization
- Cookie
- CSRF / Bearer Token

### 5.2 Filtreler
- HTTP method filtreleri (GET / POST)
- Status code filtreleri
- Path ve query exclude listeleri

### 5.3 Raporlama
- XML veya HTML formatında dışa aktarma
- Karşılaştırmalı analiz raporları

---

## 6. Güvenlik Açısından Kritik Noktalar

### 6.1 Test Riskleri
- Production ortamda test yapılması ciddi risk oluşturur.
- Yanıtlarda hassas veriler bulunabilir.

### 6.2 False Positive
- Yanıt gövdesindeki küçük farklar yanlış pozitif üretebilir.
- %5 toleranslı response length karşılaştırması kullanılır.

### 6.3 Oturum Veri Koruması
- Session ID ve token’lar güvenli saklanmalıdır.
- CSRF ve SameSite cookie politikaları güçlü tutulmalıdır.

---

## 7. Örnek Kullanım Akışı

1. Burp Proxy aktif edilir.
2. Admin kullanıcı ile uygulamaya giriş yapılır.
3. Session Auth Analyzer’a eklenir.
4. Düşük yetkili kullanıcı için ikinci session tanımlanır.
5. Yetkili istekler tekrar edilir.
6. SAME / SIMILAR / DIFFERENT sonuçları analiz edilir.
7. CSV veya HTML formatında rapor alınır.

