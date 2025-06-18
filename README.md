# Coin-Pro Mobil Uygulaması

## 📱 Proje Hakkında

Bu proje, İstanbul Sabahattin Zaim Üniversitesi'nde verilen "Mobil Uygulama Geliştirme" dersi kapsamında geliştirilmiştir.  
Flutter tabanlı bu mobil uygulama, kullanıcıların oturum açabilmesi ve kaydolabilmesi için **Supabase** tabanlı bir veritabanı ile entegre edilmiştir. Ayrıca, **Google hesabı ile giriş** özelliği de desteklenmektedir.

## 🔧 Kullanılan Teknolojiler

- Flutter (Dart)
- Supabase
- Firebase (Google Sign-In için)
- Android & iOS uyumluluğu

## 🚀 Özellikler

- E-posta ve şifre ile kayıt olma (sign-up)
- E-posta ve şifre ile giriş yapma (sign-in)
- Google hesabı ile giriş yapabilme
- Supabase ile gerçek zamanlı veritabanı bağlantısı
- Mobil uyumluluk: Android ve iOS desteği

## ⚙️ Kurulum

1. Bu repoyu klonlayın:
   ```bash
   git clone https://github.com/innery/Project_Coin_Pro.git

2. Proje dizinine girin:
   ```bash
   cd Project_Coin_Pro

3. Gerekli paketleri yükleyin:
   ```bash
   flutter pub get

4. Gerekli yapılandırmaları yapın:

   lib/constants.dart gibi bir dosyaya kendi Supabase URL ve API KEY bilgilerinizi ekleyin.
   Google Sign-In yapılandırmasını Firebase üzerinden gerçekleştirin.
   ```bash
   flutter pub get

5. Uygulamayı çalıştırın:
   ```bash
   flutter run




