🛡️ Auth-Session-Security-Analyzer Araştırma Projesi
Bu proje, web uygulamalarındaki Kimlik Doğrulama (Authentication) ve Oturum Yönetimi (Session Management) zafiyetlerini analiz etmek, güvensiz oturum çerezlerini ve şifresiz veri iletimini tespit etmek amacıyla geliştirilmiştir.

👤 Hazırlayan
İsim Soyisim: Kübra Fison

Üniversite: İstinye Üniversitesi

Bölüm: Bilişim Güvenliği Teknolojisi

🎯 Proje Amacı
Web güvenliğinin en kritik katmanlarından biri olan "Auth & Session" yönetimindeki güvenlik açıklarını (Session Hijacking, Credential Leaking vb.) anlamak ve Unix I/O mimarisi kullanarak bu riskleri dosya/log seviyesinde otomatik olarak tarayabilmektir.

🔍 1. Güvenlik ve Zafiyet Araştırması (Adım 5)
Proje kapsamında, modern web uygulamalarında sıkça rastlanan oturum güvenliği ihlalleri incelenmiş ve bu zafiyetlerin tespit yöntemleri karşılaştırılmıştır:

Hardcoded Credentials: Kaynak kod içine gömülen şifre ve API anahtarlarının risk analizi.

Session Token Exposure: URL (GET metodları) üzerinden taşınan hassas oturum bilgilerinin tespiti.

Insecure Transport (HTTP vs HTTPS): Şifrelenmemiş protokol kullanımının Man-in-the-Middle (MitM) saldırılarına etkisi.

Client-Side Cookie Access: document.cookie kullanımının XSS (Cross-Site Scripting) ile oturum çalma riskleri.

Tüm teknik analiz notlarına researchs/ klasöründen ulaşılabilir.

🛠️ 2. Terminal Otomasyonu: Auth Scanner (Adım 6)
Projenin kalbi olan auth_scanner.sh, Unix I/O akışlarını (Streams) ve Regex (Düzenli İfadeler) gücünü kullanarak dosyalar içindeki güvensiz kalıpları tarar.

Özellikler:
Gömülü Şifre Tespiti: Kod içinde unutulmuş password, api_key gibi kritik atamaları yakalar.

GET Metodu Sızıntı Analizi: URL parametrelerinde (?token=, ?session_id=) ifşa olan oturum anahtarlarını bulur.

Protokol Güvenliği: Güvensiz http:// bağlantılarını tespit eder.

Unix I/O Yönetimi: Hata mesajlarını stderr (2), analiz sonuçlarını stdout (1) üzerinden, renkli ve okunaklı bir formatta döndürür.

Nasıl Çalıştırılır?
Terminal üzerinden hedef dosya veya log dosyasını taramak için şu komut kullanılır:

Bash

./auth_scanner.sh target_code.js
