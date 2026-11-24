-- Skema Basis Data TukangKu
-- Sesuai Proposal Tugas Akhir Pemrograman Web (IF220603)
-- Dosen Master: Edison ST, MKOM

CREATE DATABASE IF NOT EXISTS `tukangku_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `tukangku_db`;

-- 1. Tabel users
CREATE TABLE IF NOT EXISTS `users` (
  `id_user` INT(11) NOT NULL AUTO_INCREMENT,
  `nama` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `role` ENUM('pelanggan', 'mitra', 'admin') NOT NULL DEFAULT 'pelanggan',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_user`),
  UNIQUE KEY `uq_users_email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 2. Tabel services
CREATE TABLE IF NOT EXISTS `services` (
  `id_service` INT(11) NOT NULL AUTO_INCREMENT,
  `id_mitra` INT(11) NOT NULL,
  `nama_layanan` VARCHAR(150) NOT NULL,
  `kategori` VARCHAR(50) NOT NULL,
  `harga` DECIMAL(10, 2) NOT NULL,
  `deskripsi` TEXT DEFAULT NULL,
  PRIMARY KEY (`id_service`),
  KEY `fk_services_mitra` (`id_mitra`),
  CONSTRAINT `fk_services_mitra` FOREIGN KEY (`id_mitra`) REFERENCES `users` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 3. Tabel orders
CREATE TABLE IF NOT EXISTS `orders` (
  `id_order` INT(11) NOT NULL AUTO_INCREMENT,
  `id_pelanggan` INT(11) NOT NULL,
  `id_service` INT(11) NOT NULL,
  `tanggal_booking` DATE NOT NULL,
  `alamat_lokasi` TEXT NOT NULL,
  `status` ENUM('pending', 'diterima', 'selesai', 'dibatalkan') NOT NULL DEFAULT 'pending',
  `catatan` TEXT DEFAULT NULL,
  PRIMARY KEY (`id_order`),
  KEY `fk_orders_pelanggan` (`id_pelanggan`),
  KEY `fk_orders_service` (`id_service`),
  CONSTRAINT `fk_orders_pelanggan` FOREIGN KEY (`id_pelanggan`) REFERENCES `users` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_service` FOREIGN KEY (`id_service`) REFERENCES `services` (`id_service`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
