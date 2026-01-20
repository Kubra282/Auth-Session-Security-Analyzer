🛡️ Auth-Session-Security-Analyzer & Servis Yönetimi Güvenlik Projesi
Bu proje, modern web servislerinde ve uygulamalarında Kimlik Doğrulama (Authentication) ve Oturum Yönetimi (Session Management) süreçlerindeki güvenlik zafiyetlerini analiz etmek, servis yönetimindeki riskleri belirlemek ve bu süreçleri otomatize etmek amacıyla geliştirilmiştir.

👤 Hazırlayan
İsim Soyisim: Kübra Fison

Üniversite: İstinye Üniversitesi

Bölüm: Bilişim Güvenliği Teknolojisi

🎯 Proje Amacı
Servis yönetimi kapsamındaki oturum güvenliği sınırlarını test etmek, "Broken Authentication" ve "Session Hijacking" (Oturum Çalma) gibi kritik riskleri anlamak; sistem yöneticileri için bu risklere karşı proaktif bir tarama ve raporlama mekanizması oluşturmaktır.

🔍 1. Çoklu Yapay Zeka Araştırması (Benchmarking)
Proje kapsamında, güvenlik senaryolarını analiz etmek ve en doğru iyileştirme önerilerini sunmak için farklı AI modellerinin yetenekleri karşılaştırılmıştır:

Gemini Pro (Google): Karmaşık oturum senaryolarında mantıksal analiz ve geniş bağlam yeteneği.

ChatGPT (OpenAI): Standart güvenlik protokolleri (OWASP) ile uyumluluk ve detaylı raporlama.

Gemini Fast: Hızlı veri işleme ve gerçek zamanlıya yakın yanıt süreleri ile pratik analiz.

Microsoft Copilot: Kurumsal güvenlik standartları ve GitHub kaynaklarıyla entegre risk değerlendirmesi.

Tüm karşılaştırmalı analiz raporlarına researchs/ klasöründen ulaşılabilir.

🛠️ 2. Terminal Otomasyonu: Session & Auth Scanner
Projenin teknik kalbi olan src/auth_scanner.sh, Unix I/O mimarisini kullanarak servis logları ve konfigürasyon dosyaları içindeki zafiyet imzalarını tarar.

Özellikler:

Zayıf Token Tespiti: Tahmin edilebilir veya süresi dolmuş oturum anahtarlarını yakalar.

Servis Yönetimi Analizi: Yetkisiz erişim denemelerini ve hatalı yapılandırılmış servis izinlerini (IDOR) tespit eder.

Unix I/O Yönetimi: Kritik hataları stderr üzerinden, analiz sonuçlarını stdout üzerinden raporlar.

Nasıl Çalıştırılır?
Terminal üzerinden şu komut ile test edilebilir:
./src/ tests/ auth_scanner.sh test_payloads.json# QLineSec
