#!/bin/bash

# ==========================================================
# Proje: Auth-Session-Security-Analyzer (v1.0)
# Hazırlayan: kübra fison
# Teknik: Unix I/O Streams (0/1/2) & Regex Pattern Matching
# ==========================================================

# Renk tanımlamaları
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Banner - stdout (1)
echo -e "${CYAN}--------------------------------------------------${NC}"
echo -e "${CYAN}   AUTH & SESSION SECURITY ANALYZER TOOL v1.0     ${NC}"
echo -e "${CYAN}   Hazırlayan: kübra fison                      ${NC}"
echo -e "${CYAN}--------------------------------------------------${NC}"

# Hata Kontrolü - stderr (2) kullanımı
if [ -z "$1" ]; then
    echo -e "${RED}[ERROR]${NC} Kullanım: ./auth_scanner.sh <dosya_veya_log>" >&2
    exit 1
fi

TARGET_FILE=$1

# Dosya Varlık Kontrolü
if [ ! -f "$TARGET_FILE" ]; then
    echo -e "${RED}[ERROR]${NC} Dosya bulunamadı: $TARGET_FILE" >&2
    exit 1
fi

echo -e "Analiz Başlatıldı: ${GREEN}$TARGET_FILE${NC}"
echo "--------------------------------------------------"

# Zafiyet Sayacı
THREATS=0

# 1. Hardcoded Credentials (Gömülü Şifre/API Anahtarı)
# Kod içinde unutulmuş şifre veya API key atamalarını arar.
if grep -qi "password\s*=\s*['\"]\|api_key\s*=\s*['\"]\|secret_key" "$TARGET_FILE"; then
    echo -e "${RED}[CRITICAL]${NC} Hardcoded Credentials (Gömülü Şifre/Key) Tespit Edildi!"
    ((THREATS++))
fi

# 2. Session Token Leaking in URL (GET Metodu ile Token İfşası)
# URL içinde taşınan token veya session id var mı kontrol eder.
if grep -qi "?token=\|?session_id=\|?auth=" "$TARGET_FILE"; then
    echo -e "${RED}[CRITICAL]${NC} Session Token URL Üzerinden İletiliyor (GET Leak)!"
    ((THREATS++))
fi

# 3. Insecure Transport (HTTP Kullanımı)
# Şifrelenmemiş HTTP protokolü kullanımı kontrolü.
if grep -qi "http://" "$TARGET_FILE"; then
    echo -e "${YELLOW}[WARNING]${NC} Güvensiz Protokol (HTTP) Kullanımı Tespit Edildi!"
    ((THREATS++))
fi

# 4. Weak Cookie Configuration (Güvensiz Çerez Ayarları)
# document.cookie ile istemci taraflı erişim riski kontrolü.
if grep -qi "document\.cookie" "$TARGET_FILE"; then
    echo -e "${YELLOW}[WARNING]${NC} Potansiyel XSS ile Oturum Çalma Riski (document.cookie)!"
    ((THREATS++))
fi

echo "--------------------------------------------------"

# Final Raporu
if [ $THREATS -eq 0 ]; then
    echo -e "${GREEN}[SUCCESS]${NC} Güvenli! Herhangi bir Auth/Session zafiyeti bulunamadı."
else
    echo -e "${RED}[RESULT]${NC} Toplam $THREATS adet güvenlik riski tespit edildi."
    echo -e "${YELLOW}Öneri:${NC} Lütfen ilgili satırları temizleyip tekrar tarama yapınız."
fi 
