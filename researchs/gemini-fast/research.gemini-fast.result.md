# Kimlik Doğrulama ve Oturum Güvenliği Analizörü: Mimari Tasarım, Endüstriyel Standartlar ve İleri Düzey Güvenlik Denetimi

Dijitalleşen dünyada, kullanıcı kimliklerinin doğrulanması ve bu kimliklere bağlı oturumların sürdürülebilir bir şekilde korunması, siber güvenliğin en kritik cephesini oluşturmaktadır. Modern web uygulamaları, mikro hizmet mimarileri ve bulut tabanlı sistemler, geleneksel çevresel güvenlik yaklaşımlarını aşarak kimlik merkezli bir güvenlik modeline geçiş yapmıştır. Bu bağlamda, kavramı, yalnızca bir yazılım aracını değil, aynı zamanda kimlik doğrulama akışlarını ve oturum yönetimi yaşam döngüsünü denetleyen kapsamlı bir teknolojik disiplini temsil etmektedir. Bu rapor, söz konusu teknolojinin derinliklerine inerek çalışma prensiplerini, küresel standartları, rekabetçi ekosistemi ve kritik yapılandırma parametrelerini teknik bir perspektifle incelemektedir.

## Kimlik Doğrulama ve Oturum Yönetiminin Teknik Temelleri

Kimlik doğrulama, bir kullanıcının veya sistemin iddia ettiği kimliği kanıtlama sürecidir. Bu süreç, genellikle "bilinen bir şey" (şifre), "sahip olunan bir şey" (token/donanım anahtarı) veya "olunan bir şey" (biyometrik veri) temelinde inşa edilir. Oturum yönetimi ise, bu doğrulama işleminin ardından kullanıcının durum bilgisinin (state) sunucu ve istemci arasında tutarlı bir şekilde korunmasıdır. HTTP protokolünün durumsuz (stateless) yapısı, her bir isteğin birbirinden bağımsız olarak değerlendirilmesine neden olur. Bu durum, sunucuların ardışık istekleri aynı kullanıcıya bağlayabilmesi için "session identifier" (oturum tanımlayıcı) adı verilen benzersiz anahtarlara ihtiyaç duymasına yol açar.

### Oturum Tanımlayıcılarının Üretimi ve Kriptografik Rastgelelik

Bir oturum analizörünün ilk odak noktası, üretilen oturum anahtarlarının kalitesidir. Eğer bir oturum anahtarı tahmin edilebilir veya belirli bir kalıba sahipse, saldırganlar geçerli bir oturumu kolayca taklit edebilirler. Bu risk, "Session Guessing" olarak adlandırılır. Güvenli bir sistem, anahtar üretiminde Kriptografik Olarak Güvenli Sözde Rastgele Sayı Üreteçleri (CSPRNG) kullanmalıdır.

Rastgeleliğin ölçüsü olan entropi, bit cinsinden hesaplanır. Bilgi teorisinde entropi, bir sistemdeki belirsizliğin ölçüsüdür. Bir oturum anahtarının güvenliği için önerilen minimum entropi seviyesi 64 bittir. Ancak modern standartlar, kaba kuvvet (brute force) saldırılarına karşı daha güçlü koruma sağlamak adına 128 bit ve üzeri entropiyi teşvik etmektedir.

| Parametre | Teknik Standart | Güvenlik Etkisi |
| :--- | :--- | :--- |
| **Minimum Entropi** | 64 bit | Tahmin edilebilirliğe karşı koruma. |
| **Minimum Uzunluk** | 50 karakter | Çarpışma riskini azaltma. |
| **Alfabe Genişliği** | Alfasayısal + Özel karakterler | Kaba kuvvet saldırısı maliyetini artırma. |
| **Kodlama Biçimi** | Base64 veya Hexadecimal | Veri bütünlüğünü ve taşıma kolaylığını sağlama. |

Oturum tanımlayıcılarının üretim süreci, sunucu tarafında gerçekleşmeli ve hiçbir zaman istemci tarafında (örneğin JavaScript ile) üretilmemelidir. Analizörler, ardışık üretilen binlerce oturum anahtarı toplayarak istatistiksel testler (Dieharder testleri gibi) yardımıyla rastgeleliği doğrularlar.

### Durumlu (Stateful) ve Durumsuz (Stateless) Oturum Mimarileri

Modern mimarilerde iki ana yaklaşım mevcuttur.
1.  **Durumlu Mimari:** Oturum verileri sunucu tarafında (RAM, Redis veya Veritabanı) saklanır ve istemciye yalnızca bir referans anahtarı (Session ID) gönderilir.
2.  **Durumsuz Mimari:** Genellikle JSON Web Token (JWT) gibi yapılar kullanılır ve tüm oturum verileri şifrelenmiş veya imzalanmış bir şekilde istemci tarafında taşınır.

Durumsuz yapının avantajı ölçeklenebilirliktir; çünkü sunucunun merkezi bir oturum deposuna her istekte erişmesi gerekmez. Ancak bu durum, oturumun anlık olarak iptal edilmesini (revocation) zorlaştırır.

## Endüstri Standartları ve Mevzuat Çerçevesi

### NIST SP 800-63B: Dijital Kimlik Kılavuzu

NIST, dijital kimlik yönetimi için en kapsamlı çerçeveyi sunar.
* **AAL1 (Düşük Güvence):** Tek faktörlü kimlik doğrulama yeterlidir.
* **AAL2 (Orta Güvence):** En az iki farklı faktör (şifre + OTP) gereklidir. 30 dk inaktivite sonrası oturum sonlandırılmalıdır.
* **AAL3 (Yüksek Güvence):** Kriptografik kanıt sunan donanım anahtarları zorunludur. 15 dk inaktivite limiti vardır.

### OWASP Oturum Yönetimi Prensipleri

* **Oturumun Yenilenmesi:** Yetki değişiminde Session ID yenilenmelidir.
* **Çerez Güvenlik Bayrakları:** `HttpOnly`, `Secure` ve `SameSite` mutlaka kullanılmalıdır.
* **HSTS Kullanımı:** İletişim sadece HTTPS üzerinden zorlanmalıdır.

## Önemli Açık Kaynak Projeler ve Rekabetçi Ekosistem

### Kimlik Sağlayıcıları (IdP)
* **Keycloak:** Java tabanlı, SSO, MFA ve federasyon desteği sunan en yaygın kurumsal çözüm.
* **Authentik:** Python tabanlı, hem IdP hem de proxy olarak çalışabilen modern yapı.
* **Authelia:** Docker/Kubernetes için hafif, reverse proxy entegrasyonlu çözüm.
* **Ory Hydra:** OAuth2 ve OIDC odaklı, yüksek performanslı token sunucusu.

### Güvenlik Analizi Araçları
* **OWASP ZAP:** Otomatik zafiyet tarama.
* **Burp Suite:** Manuel pentest ve entropi analizi (Sequencer).
* **Semgrep:** Kod içi hatalı konfigürasyon tespiti (SAST).
* **JWT-tool:** JWT sahteciliği ve imza bypass testleri.

## Kritik Yapılandırma Parametreleri

### Java Spring Security
```java
@Bean
public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
    http.sessionManagement(session -> session
           .sessionCreationPolicy(SessionCreationPolicy.IF_REQUIRED)
           .maximumSessions(1)
           .maxSessionsPreventsLogin(true)
        )
       .logout(logout -> logout.deleteCookies("JSESSIONID"))
       .sessionManagement(session -> session.sessionFixation().migrateSession());
    return http.build();
}
