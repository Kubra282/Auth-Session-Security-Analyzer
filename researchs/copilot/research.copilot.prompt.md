# Kullanılan Promptlar

Aşağıdaki promptlar, "Auth-Session-Security-Analyzer" projesi için teknik araştırma raporunu oluşturmak ve yapılandırmak amacıyla kullanılmıştır:

## Ana Araştırma Prompt'u
> "Auth-Session-Security-Analyzer adlı açık kaynaklı güvenlik aracı için kapsamlı bir teknik araştırma raporu hazırla. Rapor şu başlıkları içermeli:
> 1. Proje tanımı ve amacı (Session Management güvenliği).
> 2. Temel çalışma prensipleri (Cookie, JWT, Black-box testing).
> 3. OWASP ASVS ve Session Management standartlarına göre en iyi uygulama yöntemleri.
> 4. Benzer açık kaynak projeler (örn: EfeSidal/AuthSessionSecurityAnalyzer) ve rakip analizleri.
> 5. Kritik yapılandırma dosyaları ve parametreler (config, cookie flags).
> 6. Güvenlik açısından dikkat edilmesi gerekenler (XSS, CSRF, Session Fixation, KVKK).
> 7. Güncel araştırmalar ve 2024-2026 güvenlik trendleri.
> Rapor teknik, detaylı ve akademik bir dille yazılmalı."

## Ayrıştırma ve Formatlama Prompt'u
> "Yukarıdaki teknik araştırma metnini incele. Bu metni benim için `researchs` klasörüne kaydedilmek üzere şu dosyalara ayrıştır:
> - `research.copilot.sources.md`: Kaynak listesi.
> - `research.copilot.result.md`: Ana araştırma sonucu.
> - `research.copilot.prompt.md`: Kullanılan promptlar.
> - `research.copilot.chat_link.txt`: Paylaşım linki."
