-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 04.08.2026 klo 16:18
-- Palvelimen versio: 10.4.25-MariaDB
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `clinic`
--

-- --------------------------------------------------------

--
-- Rakenne taululle `appointments`
--

CREATE TABLE `appointments` (
  `ap_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `doctor_id` int(11) NOT NULL,
  `appointment_date` date DEFAULT NULL,
  `diago_treatment` varchar(225) DEFAULT NULL,
  `note` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Vedos taulusta `appointments`
--

INSERT INTO `appointments` (`ap_id`, `patient_id`, `doctor_id`, `appointment_date`, `diago_treatment`, `note`) VALUES
(1, 2, 1, '2025-09-16', 'fever', 'everything is ok'),
(2, 4, 1, '2025-09-16', 'fever', 'looks fine no need to worry.'),
(3, 4, 1, '2025-09-20', 'fever', 'looks fine no need to worry.'),
(4, 4, 1, '2025-09-20', 'fever', 'everything is ok'),
(5, 2, 4, '2025-09-25', 'cholesterol', 'not a big issues'),
(6, 5, 1, '2025-11-26', 'bacterial infection', 'no need to worry ');

-- --------------------------------------------------------

--
-- Rakenne taululle `doctors`
--

CREATE TABLE `doctors` (
  `doctor_id` int(11) NOT NULL,
  `doctor_name` varchar(100) NOT NULL,
  `doctor_password` varchar(255) NOT NULL,
  `doctor_phone` int(25) NOT NULL,
  `doctor_email` varchar(50) NOT NULL,
  `Specialization` varchar(50) NOT NULL,
  `Experience` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Vedos taulusta `doctors`
--

INSERT INTO `doctors` (`doctor_id`, `doctor_name`, `doctor_password`, `doctor_phone`, `doctor_email`, `Specialization`, `Experience`) VALUES
(1, 'alizeenat', 'hello@555', 451234564, 'alizeenat@gmail.com', 'Cardiologist, Dermatologist', '20 years of experience'),
(3, 'ali', 'alisahiwal555', 0, '', '', ''),
(4, 'younas', 'younas111', 333898905, 'younas@gmail.com', 'heart', '5 years ');

-- --------------------------------------------------------

--
-- Rakenne taululle `patient`
--

CREATE TABLE `patient` (
  `patient_id` int(11) NOT NULL,
  `patient_securitynum` varchar(100) NOT NULL,
  `patient_fname` varchar(100) NOT NULL,
  `patient_lname` varchar(100) NOT NULL,
  `gender` varchar(50) NOT NULL,
  `patient_address` varchar(100) NOT NULL,
  `patient_phone` int(15) NOT NULL,
  `patient_email` varchar(100) NOT NULL,
  `patient_allergies` varchar(100) NOT NULL,
  `patient_illness` varchar(100) NOT NULL,
  `patient_treatment` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Vedos taulusta `patient`
--

INSERT INTO `patient` (`patient_id`, `patient_securitynum`, `patient_fname`, `patient_lname`, `gender`, `patient_address`, `patient_phone`, `patient_email`, `patient_allergies`, `patient_illness`, `patient_treatment`) VALUES
(1, '1290', 'sara', 'ahmed', 'Female', 'paris', 123456789, 'sara@gmail.com', 'skin allergy', 'fever', 'working'),
(2, '1233', 'amna', 'irshad', 'Female', 'BARCELONA', 123456789, 'sara@gmail.com', 'skin allergy', 'fever', 'working'),
(3, '3385', 'minna', 'kapoor', 'Female', 'helsinki', 12457896, 'minna@gmail.comn', 'few', 'skin problem', 'taking time '),
(4, '1245', 'harry', 'lehtinen', 'Male', 'espoo sello', 672525252, 'harry@gmail.com', 'skin', 'sickness', 'continue'),
(5, '1111', 'diana', 'wilson', 'Female', 'america', 63743747, 'diana@gmail.com', 'nothing', 'headach', 'she need help'),
(6, '3356', 'sara', 'ahmed', 'Female', 'faislabad pakistan', 123456789, 'sara@gmail.com', '', '', 'working'),
(7, '5678', 'zara', 'ahmed', 'Female', 'lahore', 123456789, 'sara@gmail.com', '', '', 'working'),
(8, '9878', 'omar', 'khan', 'Male', 'vanta', 98789086, 'omar@gmail.com', 'few have', 'heart burn', 'working on');

-- --------------------------------------------------------

--
-- Rakenne taululle `prescription`
--

CREATE TABLE `prescription` (
  `pr_id` int(11) NOT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `doctor_id` int(11) DEFAULT NULL,
  `prescription_date` date DEFAULT NULL,
  `medicine` varchar(25) DEFAULT NULL,
  `strength` varchar(25) DEFAULT NULL,
  `instructions` varchar(25) DEFAULT NULL,
  `duration` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Vedos taulusta `prescription`
--

INSERT INTO `prescription` (`pr_id`, `patient_id`, `doctor_id`, `prescription_date`, `medicine`, `strength`, `instructions`, `duration`) VALUES
(1, 2, 1, '2025-09-16', 'bruna', '300ml', '2 weeks', 'eat two times a day'),
(2, 4, 1, '2025-09-16', 'penadol', '500ml', '1 week', 'morning and night'),
(3, 3, 1, '2025-09-19', 'bruna', '300ml', '1 week', 'eat two times a day'),
(4, 2, 4, '2025-09-25', 'atorvastatin (Lipitor) an', '100ml ', '3 months', 'with empty stomach');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `appointments`
--
ALTER TABLE `appointments`
  ADD PRIMARY KEY (`ap_id`),
  ADD KEY `patient_id` (`patient_id`),
  ADD KEY `doctor_id` (`doctor_id`);

--
-- Indexes for table `doctors`
--
ALTER TABLE `doctors`
  ADD PRIMARY KEY (`doctor_id`);

--
-- Indexes for table `patient`
--
ALTER TABLE `patient`
  ADD PRIMARY KEY (`patient_id`);

--
-- Indexes for table `prescription`
--
ALTER TABLE `prescription`
  ADD PRIMARY KEY (`pr_id`),
  ADD KEY `patient_id` (`patient_id`),
  ADD KEY `doctor_id` (`doctor_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `appointments`
--
ALTER TABLE `appointments`
  MODIFY `ap_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `doctors`
--
ALTER TABLE `doctors`
  MODIFY `doctor_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `patient`
--
ALTER TABLE `patient`
  MODIFY `patient_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `prescription`
--
ALTER TABLE `prescription`
  MODIFY `pr_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Rajoitteet vedostauluille
--

--
-- Rajoitteet taululle `appointments`
--
ALTER TABLE `appointments`
  ADD CONSTRAINT `appointments_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`),
  ADD CONSTRAINT `appointments_ibfk_2` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`doctor_id`);

--
-- Rajoitteet taululle `prescription`
--
ALTER TABLE `prescription`
  ADD CONSTRAINT `prescription_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`),
  ADD CONSTRAINT `prescription_ibfk_2` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`doctor_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
