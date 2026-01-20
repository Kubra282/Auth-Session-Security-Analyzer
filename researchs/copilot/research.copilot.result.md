# Auth-Session-Security-Analyzer: Kapsamlı Teknik Araştırma ve Güncel Güvenlik Standartları

## Giriş: Proje Tanımı ve Amacı
Auth-Session-Security-Analyzer, modern web uygulamalarında oturum yönetimi (Session Management) mekanizmalarının güvenliğini analiz etmek ve olası zafiyetleri tespit etmek amacıyla geliştirilmiş, modüler ve açık kaynaklı bir güvenlik analiz aracıdır. Proje, özellikle kimlik doğrulama sonrası oluşan oturumların (Session ID, Token, Cookie) güvenliğini otomatik veya yarı-otomatik olarak denetlemeyi hedefler.

Proje, OWASP Session Management ve Application Security Verification Standard (ASVS) gibi endüstri standartlarını temel alarak, HTTP Cookies ve JSON Web Token (JWT) gibi yaygın oturum yönetim protokollerini analiz eder.

## 1. Temel Çalışma Prensipleri: Oturum Yönetimi ve Analiz Metodolojisi

### 1.1 Oturum Yönetimi (Session Management) Nedir?
Web uygulamalarında oturum yönetimi, bir kullanıcının kimliğinin ve yetkilerinin, birden fazla HTTP isteği boyunca korunmasını sağlar. HTTP protokolü stateless (durumsuz) olduğundan, Session ID veya Token (Cookie, URL, Header) kullanılarak süreklilik sağlanır.

**Temel Süreçler:**
* Oturumun başlatılması ve kimlik doğrulama.
* Session ID'nin güvenli iletimi ve saklanması.
* Oturumun sürdürülmesi, zaman aşımı ve sonlandırma (logout).

### 1.2 Kullanılan Protokoller
* **HTTP Cookies:** `Secure`, `HttpOnly`, `SameSite` bayrakları ile korunur.
* **JSON Web Token (JWT):** İmzalı, taşınabilir token yapısıdır.

### 1.3 Analiz Metodolojisi: Black-Box Testing
Araç, uygulamanın iç koduna erişmeden dışarıdan bir kullanıcı gibi davranarak testler gerçekleştirir. Bu sayede gerçek saldırı senaryoları simüle edilir.

### 1.4 Test Modülleri ve Zafiyet Türleri
1.  **Session Hijacking:** Entropy analizi, XSS ile sızıntı, session fixation.
2.  **Cookie Güvenliği:** Bayrak kontrolleri (HttpOnly, Secure, SameSite).
3.  **Timeout Analizi:** Idle ve Absolute timeout testleri.
4.  **Yetki Yükseltme (IDOR):** Kullanıcı izolasyon testleri.
5.  **JWT Güvenliği:** İmza, algoritma ve claim manipülasyonu.

### 1.5 Otomasyon
Python (Requests, PyJWT) ve Selenium kullanılarak geliştirilmekte olup, CI/CD süreçlerine entegre edilebilir.

## 2. En İyi Uygulama Yöntemleri ve Endüstri Standartları

### 2.1 OWASP ASVS ve Standartlar
OWASP standartlarına göre temel gereksinimler:
* En az 64-bit entropi.
* Güvenli iletim (HTTPS, HttpOnly).
* Kritik olaylarda oturum yenileme.
* Loglama ve izleme.

### 2.2 Cookie Güvenliği: Best Practices
* **Secure:** Sadece HTTPS.
* **HttpOnly:** JS erişimine kapalı (XSS koruması).
* **SameSite:** CSRF koruması (Lax/Strict).

### 2.3 JWT Güvenliği: Best Practices
* Kısa ömürlü Access Token, HttpOnly Cookie'de Refresh Token.
* Güçlü algoritma (HS256/RS256).
* "None" algoritması engellenmeli.

## 3. Benzer Açık Kaynak Projeler ve Rakip Çözümler

### 3.1 Benzer Projeler
* **EfeSidal/AuthSessionSecurityAnalyzer:** Session hijacking, IDOR ve cookie güvenliğine odaklanan pentest aracı.
* **SessionGuard Pro:** Tarayıcı tabanlı cookie koruma eklentisi.
* **AGAT:** Ağ güvenlik açığı tarayıcıları topluluğu.

### 3.2 Karşılaştırmalı Analiz
Auth-Session-Security-Analyzer, özellikle oturum yönetimi odaklı olması, modüler yapısı ve CI/CD entegrasyonu ile genel amaçlı tarayıcılardan (Burp Suite, ZAP) ayrışır.

## 4. Kritik Yapılandırma ve Parametreler

**Config Dosyası Parametreleri:**
* `timeout_idle`, `timeout_absolute`
* `cookie_flags` (Secure, HttpOnly)
* `jwt_algorithms`, `jwt_secret`

**PHP Cookie Örneği:**
```php
session_set_cookie_params([
    'lifetime' => 0,
    'path' => '/',
    'domain' => '.example.com',
    'secure' => true,
    'httponly' => true,
    'samesite' => 'Lax'
]);

