# Kaynak Listesi ve Referanslar

Bu teknik araştırma raporu hazırlanırken kullanılan ve Auth-Session-Security-Analyzer projesinin temelini oluşturan kaynaklar, standartlar ve araçlar aşağıda listelenmiştir.

## 1. Endüstri Standartları ve Kılavuzlar
* **OWASP Application Security Verification Standard (ASVS) v4.0:**
    * *Bölüm V3:* Session Management Verification Requirements.
* **OWASP Session Management Cheat Sheet:**
    * Oturum yönetimi yaşam döngüsü ve güvenlik pratikleri.
* **RFC 6265 (HTTP State Management Mechanism):**
    * Cookie yapısı, özellikleri ve güvenlik bayrakları (Secure, HttpOnly).
* **RFC 7519 (JSON Web Token - JWT):**
    * JWT yapısı, iddialar (claims) ve imzalama standartları.

## 2. Benzer Açık Kaynak Projeler (GitHub)
* **EfeSidal/AuthSessionSecurityAnalyzer:**
    * Oturum yönetimi mekanizmalarını analiz eden pentest aracı referansı.
* **SessionGuard Pro (Session-Cookie-Protection-Tool):**
    * Tarayıcı tabanlı oturum koruma ve izleme engelleme aracı.
* **AGAT (Ağ Güvenlik Açığı Tarayıcıları):**
    * Çoklu güvenlik aracı entegrasyonu örneği.

## 3. Rakip ve Alternatif Ticari Çözümler
* **Burp Suite Professional/Community:**
    * Kapsamlı web güvenlik tarayıcısı (Session handling kuralları).
* **OWASP ZAP (Zed Attack Proxy):**
    * Açık kaynaklı web uygulama güvenlik tarayıcısı.
* **Acunetix:**
    * Otomatik zafiyet tarama ve yönetim aracı.
* **Google Cloud Custom Security Health Analytics:**
    * Bulut tabanlı oturum ve güvenlik analitiği.

## 4. Kullanılan Teknolojiler ve Kütüphaneler
* **Python (Programlama Dili)**
* **Requests:** HTTP istek yönetimi.
* **PyJWT:** Python için JWT kodlama ve kod çözme kütüphanesi.
* **Selenium / Playwright:** Tarayıcı otomasyonu ve UI testleri.

## 5. Yasal Düzenlemeler ve Uyumluluk
* **KVKK (Kişisel Verilerin Korunması Kanunu - Türkiye):**
    * Kişisel veri güvenliği ve test izin süreçleri.
* **GDPR (General Data Protection Regulation):**
    * Avrupa veri koruma standartları.
* **ISO/IEC 27001:**
    * Bilgi güvenliği yönetim sistemi standartları.

## 6. Teknik Dokümantasyonlar
* **MDN Web Docs (Mozilla Developer Network):**
    * HTTP Cookies, `Set-Cookie` ve `SameSite` öznitelikleri dokümantasyonu.
* **PHP Manual:**
    * `session_set_cookie_params` fonksiyonu ve konfigürasyonu.
