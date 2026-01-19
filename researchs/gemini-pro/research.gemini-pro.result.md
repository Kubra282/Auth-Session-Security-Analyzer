# Kapsamlı Teknik Araştırma ve Mimari Analiz Raporu: Auth-Session-Security-Analyzer (ASSA)

## 1. Yönetici Özeti
Günümüzün dağıtık web mimarilerinde, mikroservis ekosistemlerinde ve bulut tabanlı uygulamalarda, kullanıcı oturumlarının güvenliği (Session Security) dijital güvenin temel taşıdır. **Auth-Session-Security-Analyzer (ASSA)**, bu kritik katmanın bütünlüğünü doğrulamak, oturum yönetim mekanizmalarını denetlemek ve kriptografik entropi seviyelerini analiz etmek üzere tasarlanmış ileri düzey bir güvenlik enstrümanıdır. Geleneksel durum tabanlı (stateful) mimarilerden, JSON Web Token (JWT) gibi durumsuz (stateless) paradigmalara geçiş, oturum güvenliği analizini deterministik kontrollerden olasılıksal ve istatistiksel analizlere kaydırmıştır.

Bu rapor, ASSA teknolojilerinin temel çalışma prensiplerini, bilgi teorisi ve istatistiksel analiz yöntemlerine (Shannon Entropisi, FIPS 140-2) dayalı olarak incelemektedir. OWASP ZAP, Burp Suite Sequencer ve özelleşmiş JWT araçlarından elde edilen veriler ışığında, bu sistemlerin oturum sabitleme (session fixation), tahmin edilebilirlik (predictability) ve imza manipülasyonu gibi zafiyetleri nasıl tespit ettiği derinlemesine analiz edilmiştir. Ayrıca rapor, NIST SP 800-63B standartlarına uyumluluk, kritik yapılandırma parametreleri ve DevSecOps süreçlerine entegrasyon stratejilerini kapsamlı bir şekilde ele almaktadır.

## 2. Temel Çalışma Prensipleri ve Teorik Altyapı
ASSA sistemlerinin operasyonel başarısı üç ana teorik sütun üzerine inşa edilmiştir: **İstatistiksel Entropi Analizi**, **Durum Makinesi Doğrulaması** (State Machine Verification) ve **Yapısal Fuzzing**.

### 2.1. Öngörülemezliğin Matematiği: Entropi Analizi
Bir oturum analizörünün en kritik yeteneği, oturum tanımlayıcılarının (Session ID) rastgelelik kalitesini ölçebilmesidir.

#### 2.1.1. Shannon Entropisi ve Bilgi Teorisi
Analizörlerin temel başvuru metriği, Claude Shannon tarafından geliştirilen **Shannon Entropisi**'dir.
* **Bit Gücü Hesaplaması:** Standart bir 128-bitlik oturum ID'si teorik olarak $2^{128}$ olası kombinasyon sunmalıdır. ASSA, istatistiksel anlamlılık için genellikle 20.000 ila 50.000 adetlik token örneklemleri üzerinde analiz yapar.
* **Karakter Frekans Analizi:** Analizör, token içerisindeki karakterlerin dağılımını inceler. Belirli karakterlerin sık tekrarı, kriptanalistlerin arama uzayını daraltmasına olanak tanıyan bir "bias" (eğilim) olduğunu gösterir.

#### 2.1.2. FIPS 140-2 İstatistiksel Test Paketi
ASSA sistemleri, ABD Federal Bilgi İşleme Standardı (FIPS) 140-2 testlerini entegre eder:
* **Monobit Testi:** Bit akışındaki 1 ve 0 sayısını karşılaştırır.
* **Poker Testi:** Bit akışını 4 bitlik segmentlere böler ve frekans sayar.
* **Runs (Koşu) Testi:** Ardışık aynı bitlerin dizisini sayar.
* **Uzun Koşu Testi (Long Runs Test):** Belirli bir eşiği aşan özdeş bit dizilerini işaretler.
* **Spektral ve Korelasyon Testleri:** Tekrarlayan desenleri tespit etmek için FFT gibi yöntemler kullanılır.

### 2.2. Durum Yönetimi ve Protokol Doğrulaması
ASSA, uygulamanın durum geçişlerini aktif olarak doğrular.

#### 2.2.1. Oturum Sabitleme (Session Fixation) Tespiti
ASSA, çok adımlı bir sezgisel süreç kullanır:
1.  **Hazırlık (Probe):** Kimliksiz bir oturum çerezi alınır.
2.  **Enjeksiyon (Injection):** Bu ID kullanılarak giriş isteği hazırlanır.
3.  **Kimlik Doğrulama:** Geçerli bilgilerle ancak "kirli" ID ile giriş yapılır.
4.  **Doğrulama:** Sunucunun yeni bir ID verip vermediği kontrol edilir.

#### 2.2.2. Sonlandırma ve Zaman Aşımı Analizi
Çıkış sonrası sunucu tarafında oturumun canlı kalıp kalmadığı ve NIST standartlarına (örn. 15-30 dk) uygun eylemsizlik zaman aşımları test edilir.

### 2.3. Yapısal Fuzzing (JWT ve Stateless Mimariler)
Durumsuz mimarilerde odak noktası Bütünlük ve Fuzzing işlemleridir.
* **İmza Atlatma (Signature Evasion):** `alg: none` testi.
* **Anahtar Karışıklığı (Key Confusion):** Public Key'in HMAC sırrı olarak kullanılması.
* **Hak Talebi (Claim) Enjeksiyonu:** `user_id` veya `role` alanlarına payload enjeksiyonu.

## 3. Endüstri Standartları ve En İyi Uygulama Yöntemleri
### 3.1. NIST SP 800-63B Dijital Kimlik Yönergeleri
* **AAL Seviyeleri:** Risk profiline göre yeniden kimlik doğrulama sıklıkları (örn. AAL2 için 12 saat).
* **Oturum Bağlama:** Tokenların onaylı RBG ile üretilmesi ve HTTPS zorunluluğu.

### 3.2. OWASP Uygulama Güvenliği Doğrulama Standardı (ASVS)
* **Uzunluk ve Entropi:** En az 128 bit (16 bayt).
* **Çerez Güvenlik Bayrakları:** `Secure`, `HttpOnly`, `SameSite` eksikliği taranır.
* **Yenileme:** Yetki değişiminde ID yenileme zorunluluğu.

## 4. Benzer Açık Kaynak Projeler ve Karşılaştırma
| Özellik | Burp Suite Sequencer | OWASP ZAP | JWT Tool / JWT Hack |
| :--- | :--- | :--- | :--- |
| **Birincil Odak** | İstatistiksel Entropi | Aktif Zafiyet Taraması | Durumsuz Token (JWT) |
| **Entropi Analizi** | Altın Standart (FIPS 140-2) | Temel betik desteği | Minimal (Yapısal) |
| **Oturum Sabitleme** | Manuel doğrulama | Otomatik (SessionFixationScanRule) | Mevcut Değil |
| **JWT Desteği** | Eklentiler (JWT Editor) | Aktif tarama kuralları | Sınıfının En İyisi |
| **Otomasyon** | Enterprise / CI Sürücüleri | Docker, API, HUD | CLI, Pipeline uyumlu |

## 5. Kritik Yapılandırma Dosyaları ve Parametreleri
### 5.1. Analizör (ASSA) Yapılandırması
* **Örneklem Büyüklüğü:** Min. 20.000 token.
* **Throttle:** DoS korumasına takılmamak için 100ms gecikme.
* **Token Dolgusu:** Sabit uzunluklu analiz için padding.

### 5.2. Hedef Sistem Yapılandırması (Remediation)
* **Spring Security:** `sessionFixation().migrateSession()` ve `maximumSessions(1)`.
* **Express.js:** `trust proxy` ayarı ve güvenli cookie parametreleri (`secure: true`, `httpOnly: true`).
* **Nginx:** `proxy_cookie_path` ile zorla güvenli bayrak enjeksiyonu.

## 6. Kritik Zafiyet Analizi
* **Oturum ID Entropisi:** Zayıf PRNG kullanımı sonucu tahmin edilebilir ID'ler. ASSA "Guess" özelliği ile bir sonraki token'ı tahmin etmeye çalışır.
* **Oturum Sabitleme:** Giriş sonrası ID'nin değişmemesi.
* **JWT Hataları:** "None" algoritması ve Zayıf Sır (Brute-force ile kırılabilir).
* **Hatalı Sonlandırma:** Çıkış yapılmasına rağmen sunucuda oturumun sürmesi.

## 7. Ek Çıktılar
### 7.1. Web Sayfası Üretimi (HTML Rapor Özeti)
*(Kullanıcı tarafından sağlanan HTML kodu raporda mevcuttur)*

### 7.2. İnfografik Oluşturma Yönergesi (Prompt)
"Auth-Session-Security-Analyzer Mimarisi ve Oturum Güvenliği" konulu dikey infografik tasarımı için, Veri Toplama, Analiz Motoru ve Sonuçlar bölümlerini içeren teknik prompt hazırlanmıştır.
