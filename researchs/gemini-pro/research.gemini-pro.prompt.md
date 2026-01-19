**Rol:** Sen uzman bir Siber Güvenlik Araştırmacısı ve Sistem Mimarı'sın.

**Görev:** "Auth-Session-Security-Analyzer" (ASSA) adında hayali ama teknik olarak gerçekçi bir güvenlik aracı/konsepti üzerine kapsamlı bir teknik araştırma ve mimari analiz raporu hazırla.

**İçerik Gereksinimleri:**

1.  **Yönetici Özeti:** Oturum güvenliğinin (Session Security) önemi, stateful vs stateless mimariler ve ASSA'nın amacı.
2.  **Temel Çalışma Prensipleri:**
    * **Entropi Analizi:** Shannon Entropisi, Bit Gücü, PRNG zayıflıkları ve FIPS 140-2 istatistiksel testleri (Monobit, Poker, Runs vb.).
    * **Protokol Doğrulaması:** Session Fixation tespiti (Probe, Injection, Verification adımları).
    * **Yapısal Fuzzing:** Özellikle JWT ve stateless yapılar için imza atlatma ve claim enjeksiyonu.
3.  **Endüstri Standartları:** NIST SP 800-63B (AAL seviyeleri, oturum bağlama) ve OWASP ASVS gereksinimleri.
4.  **Rakip Analizi:** Burp Suite Sequencer, OWASP ZAP ve JWT Hack araçlarının karşılaştırmalı tablosu.
5.  **Kritik Yapılandırmalar:**
    * Analizör için örneklem büyüklüğü ve throttle ayarları.
    * Spring Security, Express.js ve Nginx için iyileştirme (remediation) kod örnekleri.
6.  **Zafiyet Analizi:** Oturum tahmin edilebilirliği, sabitleme, JWT 'none' algoritması gibi kritik açıkların teknik detayları.
7.  **Ek Çıktılar:** Raporun özetini içeren bir HTML şablonu ve infografik oluşturmak için bir prompt.

**Format:** Profesyonel, teknik ve akademik bir dil kullan. Matematiksel terimleri (LaTeX formatında olabilir) ve kod bloklarını uygun şekilde yerleştir. En sona geniş kapsamlı bir kaynakça ekle.
