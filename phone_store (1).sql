-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Mar 28, 2026 at 04:50 AM
-- Server version: 8.4.7
-- PHP Version: 8.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `phone_store`
--

-- --------------------------------------------------------

--
-- Table structure for table `carts`
--

DROP TABLE IF EXISTS `carts`;
CREATE TABLE IF NOT EXISTS `carts` (
  `cart_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`cart_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `carts`
--

INSERT INTO `carts` (`cart_id`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 1, '2026-03-17 17:08:42', '2026-03-17 17:08:42'),
(2, 2, '2026-03-17 17:08:42', '2026-03-17 17:08:42'),
(3, NULL, '2026-03-23 11:17:38', '2026-03-23 11:17:38');

-- --------------------------------------------------------

--
-- Table structure for table `cart_items`
--

DROP TABLE IF EXISTS `cart_items`;
CREATE TABLE IF NOT EXISTS `cart_items` (
  `cart_item_id` int NOT NULL AUTO_INCREMENT,
  `cart_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`cart_item_id`),
  KEY `cart_id` (`cart_id`),
  KEY `product_id` (`product_id`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cart_items`
--

INSERT INTO `cart_items` (`cart_item_id`, `cart_id`, `product_id`, `quantity`) VALUES
(13, 3, 1, 5),
(3, 2, 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`category_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`category_id`, `name`, `description`) VALUES
(1, 'Apple', 'Điện thoại của Apple với thiết kế đẹp và hiệu năng mạnh mẽ'),
(2, 'Samsung', 'Điện thoại của Samsung, nổi bật với màn hình tuyệt vời và camera chất lượng'),
(3, 'Xiaomi', 'Điện thoại Xiaomi với giá cả phải chăng và tính năng đa dạng');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
CREATE TABLE IF NOT EXISTS `orders` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `status` enum('pending','processing','completed','cancelled') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`order_id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `user_id`, `total_price`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 1799.98, 'pending', '2026-03-17 17:08:42', '2026-03-17 17:08:42'),
(2, 1, 849.99, 'completed', '2026-03-17 17:08:42', '2026-03-17 17:08:42'),
(3, 2, 1599.98, 'processing', '2026-03-17 17:08:42', '2026-03-17 17:08:42'),
(4, 1, 2499.97, 'pending', '2026-03-18 01:41:01', '2026-03-18 01:41:01'),
(5, NULL, 3999.96, 'pending', '2026-03-23 11:34:37', '2026-03-23 18:34:37'),
(6, NULL, 10749.89, 'pending', '2026-03-24 19:07:35', '2026-03-25 02:07:35'),
(7, NULL, 1999.98, 'pending', '2026-03-24 19:09:14', '2026-03-25 02:09:14'),
(8, NULL, 5999.94, 'pending', '2026-03-24 19:11:29', '2026-03-25 02:11:29'),
(9, NULL, 999.99, 'pending', '2026-03-24 19:12:59', '2026-03-25 02:12:59'),
(10, NULL, 999.99, 'pending', '2026-03-24 19:16:13', '2026-03-25 02:16:13'),
(11, NULL, 1999.98, 'pending', '2026-03-24 19:45:06', '2026-03-25 02:45:06');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
CREATE TABLE IF NOT EXISTS `order_items` (
  `order_item_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `quantity` int NOT NULL,
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`order_item_id`),
  KEY `order_id` (`order_id`),
  KEY `idx_product_id` (`product_id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`order_item_id`, `order_id`, `product_id`, `quantity`, `price`) VALUES
(1, 1, 1, 2, 999.99),
(2, 2, 2, 1, 849.99),
(3, 3, 1, 1, 999.99),
(4, 3, 3, 1, 749.99),
(5, 4, 1, 1, 999.99),
(6, 4, 3, 2, 749.99),
(7, 5, 1, 4, 999.99),
(8, 6, 3, 1, 749.99),
(9, 6, 1, 10, 999.99),
(10, 7, 1, 2, 999.99),
(11, 8, 1, 6, 999.99),
(12, 9, 1, 1, 999.99),
(13, 10, 1, 1, 999.99),
(14, 11, 1, 2, 999.99);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
CREATE TABLE IF NOT EXISTS `products` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `price` decimal(10,2) NOT NULL,
  `stock_quantity` int DEFAULT '0',
  `category_id` int DEFAULT NULL,
  `image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`product_id`),
  KEY `idx_category_id` (`category_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `name`, `description`, `price`, `stock_quantity`, `category_id`, `image_url`, `created_at`, `updated_at`) VALUES
(1, 'iPhone 14', 'Điện thoại iPhone 14, màn hình Super Retina XDR, chip A15 Bionic', 999.99, 50, 1, 'images/products/iphone14.jpg', '2026-03-17 17:08:42', '2026-03-25 02:22:58'),
(2, 'Samsung Galaxy S22', 'Samsung Galaxy S22 với màn hình Dynamic AMOLED 2X và camera 108MP', 849.99, 30, 2, 'https://example.com/s22.jpg', '2026-03-17 17:08:42', '2026-03-17 17:08:42'),
(3, 'Xiaomi Mi 11', 'Xiaomi Mi 11, màn hình AMOLED, Snapdragon 888, camera 108MP', 749.99, 40, 3, 'https://example.com/mi11.jpg', '2026-03-17 17:08:42', '2026-03-17 17:08:42');

-- --------------------------------------------------------

--
-- Table structure for table `product_images`
--

DROP TABLE IF EXISTS `product_images`;
CREATE TABLE IF NOT EXISTS `product_images` (
  `image_id` int NOT NULL AUTO_INCREMENT,
  `product_id` int DEFAULT NULL,
  `image_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`image_id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_images`
--

INSERT INTO `product_images` (`image_id`, `product_id`, `image_url`) VALUES
(1, 1, 'images/products/iphone14_1.jpg'),
(2, 1, 'images/products/iphone14_2.jpg'),
(3, 1, 'images/products/iphone14_3.jpg'),
(4, 2, 'images/products/s22_1.jpg'),
(5, 2, 'images/products/s22_2.jpg'),
(6, 2, 'images/products/s22_3.jpg'),
(7, 3, 'images/products/mi11_1.jpg'),
(8, 3, 'images/products/mi11_2.jpg'),
(9, 3, 'images/products/mi11_3.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `product_specifications`
--

DROP TABLE IF EXISTS `product_specifications`;
CREATE TABLE IF NOT EXISTS `product_specifications` (
  `spec_id` int NOT NULL AUTO_INCREMENT,
  `product_id` int DEFAULT NULL,
  `spec_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `spec_value` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`spec_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_specifications`
--

INSERT INTO `product_specifications` (`spec_id`, `product_id`, `spec_name`, `spec_value`) VALUES
(1, 1, 'Màn hình', '6.1 inch Super Retina XDR'),
(2, 1, 'Chip', 'Apple A15 Bionic'),
(3, 1, 'Camera', '12MP'),
(4, 1, 'Pin', '3279 mAh');

-- --------------------------------------------------------

--
-- Table structure for table `product_variants`
--

DROP TABLE IF EXISTS `product_variants`;
CREATE TABLE IF NOT EXISTS `product_variants` (
  `variant_id` int NOT NULL AUTO_INCREMENT,
  `product_id` int DEFAULT NULL,
  `ram` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `storage` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `stock` int DEFAULT '0',
  `image_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`variant_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_variants`
--

INSERT INTO `product_variants` (`variant_id`, `product_id`, `ram`, `storage`, `color`, `price`, `stock`, `image_url`, `created_at`, `updated_at`) VALUES
(1, 1, '6GB', '128GB', 'Black', 999.99, 20, NULL, '2026-03-25 18:14:50', '2026-03-25 18:14:50'),
(2, 1, '6GB', '256GB', 'Black', 1099.99, 15, NULL, '2026-03-25 18:14:50', '2026-03-25 18:14:50'),
(3, 1, '6GB', '512GB', 'Black', 1199.99, 10, NULL, '2026-03-25 18:14:50', '2026-03-25 18:14:50');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone_number` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `role` enum('user','admin') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'user',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `password`, `email`, `phone_number`, `address`, `role`, `created_at`, `updated_at`) VALUES
(1, 'john_doe', '$2y$10$YTMfj0HHVExyUXaLShCDp.DGFxejgqak7zqbzYmt6DqOgWBN7q0fq', 'john@example.com', '0123456789', '123 Main St, City, Country', 'user', '2026-03-17 17:08:42', '2026-03-18 02:39:47'),
(2, 'admin', 'admin123', 'admin@example.com', '0987654321', '456 Admin St, City, Country', 'admin', '2026-03-17 17:08:42', '2026-03-17 17:08:42');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
