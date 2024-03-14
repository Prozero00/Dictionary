-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 14, 2024 at 05:25 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_kamus`
--

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(25) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` text NOT NULL,
  `fullname` varchar(50) NOT NULL,
  `tgl_daftar` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `fullname`, `tgl_daftar`) VALUES
(1, 'yusmiPutra', 'udayusmi9@gmail.com', '4297f44b13955235245b2497399d7a93', 'Yusmi Putra', '2023-04-03 14:29:15'),
(2, 'testNama', 'test@gmail.com', '4297f44b13955235245b2497399d7a93', 'test', '2023-04-03 16:45:02'),
(3, 'rizki1', 'rizki@gmail.com', '4297f44b13955235245b2497399d7a93', 'rizki syaputra', '2023-04-10 14:04:24'),
(4, 'rizki2', 'rizki2@gmail.com', '22fe8c5a186a927a430f467b96c75bb1', 'rizki syaputra', '2023-04-10 14:05:09'),
(5, 'rizkipm', 'rizki@udacoding.id', '4297f44b13955235245b2497399d7a93', 'RIzki Syaputrta', '2023-05-05 08:34:38'),
(6, 'rizkipm2', 'rizki2@udacoding.id', '4297f44b13955235245b2497399d7a93', 'RIzki Syaputrta1', '2023-05-05 09:23:27'),
(7, 'udin', 'udain@gmail.com', '4297f44b13955235245b2497399d7a93', 'udin', '2023-05-05 09:44:45'),
(8, 'udin2', 'udin2@gmail.com', '4297f44b13955235245b2497399d7a93', 'udin2', '2023-05-05 09:46:31'),
(9, 'rizkipm2', 'aim@gmail.com', '4297f44b13955235245b2497399d7a93', 'Rizki Syaputra Udacoding', '2023-05-12 09:10:34'),
(10, 'rizkiaimar', 'rizki_aimar@udacoding.com', 'ed2b1f468c5f915f3f1cf75d7068baae', 'Rizki Aimar', '2024-02-28 20:22:16'),
(11, 'udin2024', 'udin2024@gmail.com', 'f5bb0c8de146c67b44babbf4e6584cc0', 'udin syaputra', '2024-03-04 19:35:44'),
(12, 'udinaja', 'udinaja@gmail.com', '4297f44b13955235245b2497399d7a93', 'udin2023', '2024-03-04 20:02:56'),
(13, 'aufa', 'aufa@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', 'Aufa Yuliansyah', '2024-03-13 21:31:28'),
(14, 'dono', 'dono@gmail.com', 'e3b810115555736a216f137df55789f6', 'dono', '2024-03-13 21:32:37'),
(15, 'lono', 'lono@gmail.com', '02d04e717f6b332a8bc0368aa97d48d1', 'lono', '2024-03-14 00:09:20'),
(17, 'tono', 'tono', '14d2d4119982cd6c68a566e523cb16ae', 'tono', '2024-03-14 02:05:37'),
(19, 'lucas', 'lucashartman@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', 'Lucas Hartman', '2024-03-14 10:42:09'),
(20, 'budi', 'budi@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', 'budi', '2024-03-14 10:53:00');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
