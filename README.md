# Business Intelligence Dashboard Frontend

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green.svg?style=for-the-badge)

## 📌 Deskripsi Proyek
**Business Intelligence Dashboard** adalah aplikasi frontend berbasis mobile/web yang dikembangkan menggunakan **Flutter**. Aplikasi ini dirancang untuk memvisualisasikan data performa bisnis secara interaktif, memungkinkan pengguna untuk memantau metrik kunci (KPI), tren penjualan, dan segmentasi pasar secara real-time melalui integrasi API.

## ✨ Fitur Utama
* **KPI Overview Cards:** Menampilkan metrik utama seperti total penjualan, total profit, unit terjual, dan harga jual rata-rata secara ringkas.
* **Sales Analysis by Country:** Visualisasi data penjualan berdasarkan letak geografis (negara).
* **Monthly Sales Trends:** Grafik garis yang menunjukkan fluktuasi penjualan dari bulan ke bulan.
* **Market Segmentation:** Analisis pembagian pasar berdasarkan segmen pelanggan (Government, Small Business, Enterprise, dll).
* **Discount Band Analysis:** Visualisasi hubungan antara tingkat diskon dengan profit yang dihasilkan.
* **Dynamic Filtering:** Fitur filter data berdasarkan periode atau kriteria tertentu untuk mendapatkan insight yang lebih spesifik.
* **Responsive Design:** Antarmuka yang optimal baik untuk perangkat mobile maupun desktop.

## 🛠️ Teknologi yang Digunakan
* **Framework:** [Flutter SDK](https://flutter.dev/)
* **Bahasa Pemrograman:** Dart
* **State Management:** [Provider](https://pub.dev/packages/provider)
* **Pemrosesan Data:** JSON Serialization
* **Visualisasi Data:** FL Chart / Syncfusion Flutter Charts (berdasarkan struktur widget)
* **Network Service:** HTTP Client untuk integrasi REST API

## 📋 Prasyarat Instalasi
Pastikan Anda sudah menginstal alat-alat berikut di perangkat Anda:
1.  **Flutter SDK** (Versi terbaru disarankan)
2.  **Dart SDK**
3.  **Android Studio / VS Code** (dengan plugin Flutter & Dart)
4.  **Emulator atau Device Fisik** (Android/iOS/Chrome)

## ⚙️ Langkah Instalasi
1.  **Clone Repositori:**
    ```bash
    git clone [https://github.com/Agussaputr44/business-intelligence-dashboard-fe.git](https://github.com/Agussaputr44/business-intelligence-dashboard-fe.git)
    cd business-intelligence-dashboard-fe
    ```

2.  **Instal Dependensi:**
    ```bash
    flutter pub get
    ```

3.  **Konfigurasi API:**
    Buka file `lib/config/api_config.dart` dan sesuaikan `baseUrl` dengan endpoint backend Anda.

4.  **Jalankan Aplikasi:**
    ```bash
    flutter run
    ```

## 📂 Struktur Proyek
```text
lib/
├── config/           # Konfigurasi API dan endpoint
├── models/           # Data models (KPI, Sales, Segments, etc.)
├── providers/        # Logika state management (DashboardProvider)
├── services/         # Layanan API (DashboardService)
├── views/
│   ├── pages/        # DashboardPage (Main UI)
│   └── widgets/      # Komponen UI (Charts, KPI Cards, Filters)
└── main.dart         # Titik masuk utama aplikasi

```

## 🚀 Contoh Penggunaan

Aplikasi akan otomatis memuat data saat dibuka. Pengguna dapat:

1. Melihat ringkasan keuangan pada deretan **KPI Cards** di bagian atas.
2. Menggunakan **Filters Section** untuk menyaring data yang ditampilkan pada grafik.
3. Menekan elemen grafik untuk melihat detail angka pada setiap kategori negara atau bulan.

## 🤝 Kontribusi

Kontribusi selalu terbuka! Jika Anda ingin meningkatkan fitur atau melaporkan bug:

1. Fork repositori ini.
2. Buat branch fitur baru (`git checkout -b fitur/FiturBaru`).
3. Commit perubahan Anda (`git commit -m 'Menambahkan Fitur X'`).
4. Push ke branch tersebut (`git push origin fitur/FiturBaru`).
5. Buat Pull Request.

## 📄 Lisensi

Proyek ini dilisensikan di bawah **MIT License** - lihat file [LICENSE](https://www.google.com/search?q=LICENSE) untuk detail lebih lanjut.

---

**Developed by [Agus Saputra**](https://www.google.com/search?q=https://github.com/Agussaputr44)

