-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 01, 2026 at 05:53 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mindseed`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `admin_id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`admin_id`, `name`, `email`, `password`) VALUES
(1, 'Admin One', 'admin1@coaching.com', 'admin123'),
(2, 'Admin Two', 'admin2@coaching.com', 'admin123');

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

CREATE TABLE `attendance` (
  `attendance_id` int(11) NOT NULL,
  `student_id` int(11) DEFAULT NULL,
  `class` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `status` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `attendance`
--

INSERT INTO `attendance` (`attendance_id`, `student_id`, `class`, `date`, `status`) VALUES
(1, 2, 1, '2025-12-28', 'Present'),
(2, 3, 1, '2025-12-28', 'Present'),
(3, 4, 1, '2025-12-28', 'Absent'),
(4, 5, 1, '2025-12-28', 'Present'),
(5, 6, 1, '2025-12-28', 'Present'),
(6, 7, 1, '2025-12-28', 'Present'),
(7, 8, 1, '2025-12-28', 'Present'),
(8, 9, 1, '2025-12-28', 'Absent'),
(9, 10, 1, '2025-12-28', 'Present'),
(10, 11, 1, '2025-12-28', 'Absent'),
(11, 12, 1, '2025-12-28', 'Present'),
(12, 13, 1, '2025-12-28', 'Present'),
(13, 14, 1, '2025-12-28', 'Present'),
(14, 15, 1, '2025-12-28', 'Present'),
(15, 16, 1, '2025-12-28', 'Present'),
(16, 17, 1, '2025-12-28', 'Present'),
(17, 18, 1, '2025-12-28', 'Present'),
(18, 19, 1, '2025-12-28', 'Present'),
(19, 20, 1, '2025-12-28', 'Present'),
(20, 21, 1, '2025-12-28', 'Present'),
(21, 22, 1, '2025-12-28', 'Present'),
(22, 23, 1, '2025-12-28', 'Present'),
(23, 24, 1, '2025-12-28', 'Present'),
(24, 25, 1, '2025-12-28', 'Present'),
(25, 26, 1, '2025-12-28', 'Present'),
(26, 27, 1, '2025-12-28', 'Present'),
(27, 28, 1, '2025-12-28', 'Present'),
(28, 29, 1, '2025-12-28', 'Present'),
(29, 30, 1, '2025-12-28', 'Present'),
(30, 31, 1, '2025-12-28', 'Present'),
(31, 32, 1, '2025-12-28', 'Present'),
(32, 33, 1, '2025-12-28', 'Present'),
(33, 34, 1, '2025-12-28', 'Present'),
(34, 35, 1, '2025-12-28', 'Present'),
(35, 36, 1, '2025-12-28', 'Present'),
(36, 37, 1, '2025-12-28', 'Present'),
(37, 38, 1, '2025-12-28', 'Present'),
(38, 39, 1, '2025-12-28', 'Present'),
(39, 40, 1, '2025-12-28', 'Present'),
(40, 41, 1, '2025-12-28', 'Present'),
(41, 42, 1, '2025-12-28', 'Present'),
(42, 43, 1, '2025-12-28', 'Present'),
(43, 44, 1, '2025-12-28', 'Present'),
(44, 45, 1, '2025-12-28', 'Present'),
(45, 46, 1, '2025-12-28', 'Present'),
(46, 47, 1, '2025-12-28', 'Present'),
(47, 48, 1, '2025-12-28', 'Present'),
(48, 49, 1, '2025-12-28', 'Present'),
(49, 50, 1, '2025-12-28', 'Present'),
(50, 51, 1, '2025-12-28', 'Present'),
(51, 52, 1, '2025-12-28', 'Present'),
(52, 53, 1, '2025-12-28', 'Present'),
(53, 54, 1, '2025-12-28', 'Present'),
(54, 55, 1, '2025-12-28', 'Present'),
(55, 56, 1, '2025-12-28', 'Present'),
(56, 57, 1, '2025-12-28', 'Present'),
(57, 58, 1, '2025-12-28', 'Present'),
(58, 59, 1, '2025-12-28', 'Present'),
(59, 60, 1, '2025-12-28', 'Present'),
(60, 61, 1, '2025-12-28', 'Present'),
(61, 62, 1, '2025-12-28', 'Present'),
(62, 63, 1, '2025-12-28', 'Present'),
(63, 64, 1, '2025-12-28', 'Present'),
(64, 65, 1, '2025-12-28', 'Present'),
(65, 66, 1, '2025-12-28', 'Present'),
(66, 67, 1, '2025-12-28', 'Present'),
(67, 68, 1, '2025-12-28', 'Present'),
(68, 69, 1, '2025-12-28', 'Present'),
(69, 70, 1, '2025-12-28', 'Present'),
(70, 71, 1, '2025-12-28', 'Present'),
(71, 72, 1, '2025-12-28', 'Present'),
(72, 73, 1, '2025-12-28', 'Present'),
(73, 74, 1, '2025-12-28', 'Present'),
(74, 75, 1, '2025-12-28', 'Present'),
(75, 76, 1, '2025-12-28', 'Present'),
(76, 77, 1, '2025-12-28', 'Present'),
(77, 78, 1, '2025-12-28', 'Present'),
(78, 79, 1, '2025-12-28', 'Present'),
(79, 80, 1, '2025-12-28', 'Present'),
(80, 81, 1, '2025-12-28', 'Present'),
(81, 82, 1, '2025-12-28', 'Present'),
(82, 83, 1, '2025-12-28', 'Present'),
(83, 84, 1, '2025-12-28', 'Present'),
(84, 85, 1, '2025-12-28', 'Present'),
(85, 86, 1, '2025-12-28', 'Present'),
(86, 87, 1, '2025-12-28', 'Present'),
(87, 88, 1, '2025-12-28', 'Present'),
(88, 89, 1, '2025-12-28', 'Present'),
(89, 90, 1, '2025-12-28', 'Present'),
(90, 91, 1, '2025-12-28', 'Present'),
(91, 92, 1, '2025-12-28', 'Present'),
(92, 93, 1, '2025-12-28', 'Present'),
(93, 94, 1, '2025-12-28', 'Present'),
(94, 95, 1, '2025-12-28', 'Present'),
(95, 96, 1, '2025-12-28', 'Present'),
(96, 97, 1, '2025-12-28', 'Present'),
(97, 98, 1, '2025-12-28', 'Present'),
(98, 99, 1, '2025-12-28', 'Present'),
(99, 100, 1, '2025-12-28', 'Present'),
(100, 101, 1, '2025-12-28', 'Present'),
(101, 12, 2, '2025-12-29', 'Absent'),
(102, 13, 2, '2025-12-29', 'Present'),
(103, 14, 2, '2025-12-29', 'Absent'),
(104, 15, 2, '2025-12-29', 'Present'),
(105, 16, 2, '2025-12-29', 'Present'),
(106, 17, 2, '2025-12-29', 'Absent'),
(107, 18, 2, '2025-12-29', 'Present'),
(108, 19, 2, '2025-12-29', 'Present'),
(109, 20, 2, '2025-12-29', 'Absent'),
(110, 21, 2, '2025-12-29', 'Present');

-- --------------------------------------------------------

--
-- Table structure for table `exams`
--

CREATE TABLE `exams` (
  `exam_id` int(11) NOT NULL,
  `student_id` int(11) DEFAULT NULL,
  `subject` varchar(50) DEFAULT NULL,
  `marks` int(11) DEFAULT NULL,
  `exam_name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `student_id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `class` int(11) DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`student_id`, `name`, `email`, `password`, `class`, `gender`) VALUES
(2, 'Aarav Mehta', 'aarav.c1@cms.com', 'student123', 1, 'Male'),
(3, 'Vihaan Patel', 'vihaan.c1@cms.com', 'student123', 1, 'Male'),
(4, 'Aditya Kulkarni', 'aditya.c1@cms.com', 'student123', 1, 'Male'),
(5, 'Rohan Deshmukh', 'rohan.c1@cms.com', 'student123', 1, 'Male'),
(6, 'Kabir Shah', 'kabir.c1@cms.com', 'student123', 1, 'Male'),
(7, 'Anaya Joshi', 'anaya.c1@cms.com', 'student123', 1, 'Female'),
(8, 'Ishita Kulkarni', 'ishita.c1@cms.com', 'student123', 1, 'Female'),
(9, 'Riya Patil', 'riya.c1@cms.com', 'student123', 1, 'Female'),
(10, 'Sneha More', 'sneha.c1@cms.com', 'student123', 1, 'Female'),
(11, 'Pooja Jadhav', 'pooja.c1@cms.com', 'student123', 1, 'Female'),
(12, 'Aryan Verma', 'aryan.c2@cms.com', 'student123', 2, 'Male'),
(13, 'Dev Malhotra', 'dev.c2@cms.com', 'student123', 2, 'Male'),
(14, 'Yash Chavan', 'yash.c2@cms.com', 'student123', 2, 'Male'),
(15, 'Nikhil Pawar', 'nikhil.c2@cms.com', 'student123', 2, 'Male'),
(16, 'Siddharth Jain', 'siddharth.c2@cms.com', 'student123', 2, 'Male'),
(17, 'Aditi Rao', 'aditi.c2@cms.com', 'student123', 2, 'Female'),
(18, 'Neha Bansal', 'neha.c2@cms.com', 'student123', 2, 'Female'),
(19, 'Kavya Singh', 'kavya.c2@cms.com', 'student123', 2, 'Female'),
(20, 'Tanvi Kulkarni', 'tanvi.c2@cms.com', 'student123', 2, 'Female'),
(21, 'Shruti Agarwal', 'shruti.c2@cms.com', 'student123', 2, 'Female'),
(22, 'Omkar Shinde', 'omkar.c3@cms.com', 'student123', 3, 'Male'),
(23, 'Atharva Gokhale', 'atharva.c3@cms.com', 'student123', 3, 'Male'),
(24, 'Harsh Vora', 'harsh.c3@cms.com', 'student123', 3, 'Male'),
(25, 'Manas Iyer', 'manas.c3@cms.com', 'student123', 3, 'Male'),
(26, 'Kunal Mishra', 'kunal.c3@cms.com', 'student123', 3, 'Male'),
(27, 'Prachi Kulkarni', 'prachi.c3@cms.com', 'student123', 3, 'Female'),
(28, 'Sakshi Patil', 'sakshi.c3@cms.com', 'student123', 3, 'Female'),
(29, 'Nandini Desai', 'nandini.c3@cms.com', 'student123', 3, 'Female'),
(30, 'Ira Banerjee', 'ira.c3@cms.com', 'student123', 3, 'Female'),
(31, 'Megha Kulkarni', 'megha.c3@cms.com', 'student123', 3, 'Female'),
(32, 'Ritvik Sen', 'ritvik.c4@cms.com', 'student123', 4, 'Male'),
(33, 'Ansh Tiwari', 'ansh.c4@cms.com', 'student123', 4, 'Male'),
(34, 'Parth Kulkarni', 'parth.c4@cms.com', 'student123', 4, 'Male'),
(35, 'Rudra Naik', 'rudra.c4@cms.com', 'student123', 4, 'Male'),
(36, 'Samar Joshi', 'samar.c4@cms.com', 'student123', 4, 'Male'),
(37, 'Mrunal Patil', 'mrunal.c4@cms.com', 'student123', 4, 'Female'),
(38, 'Aishwarya Kulkarni', 'aishwarya.c4@cms.com', 'student123', 4, 'Female'),
(39, 'Rupal Shah', 'rupal.c4@cms.com', 'student123', 4, 'Female'),
(40, 'Bhavya Jain', 'bhavya.c4@cms.com', 'student123', 4, 'Female'),
(41, 'Komal More', 'komal.c4@cms.com', 'student123', 4, 'Female'),
(42, 'Shaurya Khanna', 'shaurya.c5@cms.com', 'student123', 5, 'Male'),
(43, 'Arjun Bhat', 'arjun.c5@cms.com', 'student123', 5, 'Male'),
(44, 'Mohit Shetty', 'mohit.c5@cms.com', 'student123', 5, 'Male'),
(45, 'Tejas Kulkarni', 'tejas.c5@cms.com', 'student123', 5, 'Male'),
(46, 'Rakesh Yadav', 'rakesh.c5@cms.com', 'student123', 5, 'Male'),
(47, 'Anjali Pandey', 'anjali.c5@cms.com', 'student123', 5, 'Female'),
(48, 'Swara Joshi', 'swara.c5@cms.com', 'student123', 5, 'Female'),
(49, 'Palak Arora', 'palak.c5@cms.com', 'student123', 5, 'Female'),
(50, 'Kriti Malhotra', 'kriti.c5@cms.com', 'student123', 5, 'Female'),
(51, 'Sonal Thakur', 'sonal.c5@cms.com', 'student123', 5, 'Female'),
(52, 'Raghav Kapoor', 'raghav.c6@cms.com', 'student123', 6, 'Male'),
(53, 'Ishaan Sethi', 'ishaan.c6@cms.com', 'student123', 6, 'Male'),
(54, 'Pranav Kulkarni', 'pranav.c6@cms.com', 'student123', 6, 'Male'),
(55, 'Abhay Chitale', 'abhay.c6@cms.com', 'student123', 6, 'Male'),
(56, 'Varun Nair', 'varun.c6@cms.com', 'student123', 6, 'Male'),
(57, 'Aarohi Kulkarni', 'aarohi.c6@cms.com', 'student123', 6, 'Female'),
(58, 'Ritika Menon', 'ritika.c6@cms.com', 'student123', 6, 'Female'),
(59, 'Juhi Saxena', 'juhi.c6@cms.com', 'student123', 6, 'Female'),
(60, 'Kanishka Roy', 'kanishka.c6@cms.com', 'student123', 6, 'Female'),
(61, 'Pallavi Deshpande', 'pallavi.c6@cms.com', 'student123', 6, 'Female'),
(62, 'Lakshya Arora', 'lakshya.c7@cms.com', 'student123', 7, 'Male'),
(63, 'Ritesh Kulkarni', 'ritesh.c7@cms.com', 'student123', 7, 'Male'),
(64, 'Sameer Shaikh', 'sameer.c7@cms.com', 'student123', 7, 'Male'),
(65, 'Soham Pande', 'soham.c7@cms.com', 'student123', 7, 'Male'),
(66, 'Akash Raut', 'akash.c7@cms.com', 'student123', 7, 'Male'),
(67, 'Esha Kulkarni', 'esha.c7@cms.com', 'student123', 7, 'Female'),
(68, 'Namrata Jadhav', 'namrata.c7@cms.com', 'student123', 7, 'Female'),
(69, 'Trisha Sengupta', 'trisha.c7@cms.com', 'student123', 7, 'Female'),
(70, 'Mitali Joshi', 'mitali.c7@cms.com', 'student123', 7, 'Female'),
(71, 'Renu Bhatia', 'renu.c7@cms.com', 'student123', 7, 'Female'),
(72, 'Advik Malhotra', 'advik.c8@cms.com', 'student123', 8, 'Male'),
(73, 'Naman Gupta', 'naman.c8@cms.com', 'student123', 8, 'Male'),
(74, 'Tanishq Khandelwal', 'tanishq.c8@cms.com', 'student123', 8, 'Male'),
(75, 'Roshan Dsouza', 'roshan.c8@cms.com', 'student123', 8, 'Male'),
(76, 'Piyush Kulkarni', 'piyush.c8@cms.com', 'student123', 8, 'Male'),
(77, 'Diya Bhat', 'diya.c8@cms.com', 'student123', 8, 'Female'),
(78, 'Apeksha Kulkarni', 'apeksha.c8@cms.com', 'student123', 8, 'Female'),
(79, 'Shivani Rane', 'shivani.c8@cms.com', 'student123', 8, 'Female'),
(80, 'Rashmi Pillai', 'rashmi.c8@cms.com', 'student123', 8, 'Female'),
(81, 'Kiran Kaur', 'kiran.c8@cms.com', 'student123', 8, 'Female'),
(82, 'Neil Fernandes', 'neil.c9@cms.com', 'student123', 9, 'Male'),
(83, 'Armaan Qureshi', 'armaan.c9@cms.com', 'student123', 9, 'Male'),
(84, 'Saurabh Kulkarni', 'saurabh.c9@cms.com', 'student123', 9, 'Male'),
(85, 'Jayant Desai', 'jayant.c9@cms.com', 'student123', 9, 'Male'),
(86, 'Rohit Saxena', 'rohit.c9@cms.com', 'student123', 9, 'Male'),
(87, 'Anushka Kulkarni', 'anushka.c9@cms.com', 'student123', 9, 'Female'),
(88, 'Simran Kaur', 'simran.c9@cms.com', 'student123', 9, 'Female'),
(89, 'Madhura Gawande', 'madhura.c9@cms.com', 'student123', 9, 'Female'),
(90, 'Pallak Mehra', 'pallak.c9@cms.com', 'student123', 9, 'Female'),
(91, 'Shreya Nair', 'shreya.c9@cms.com', 'student123', 9, 'Female'),
(92, 'Kartik Kulkarni', 'kartik.c10@cms.com', 'student123', 10, 'Male'),
(93, 'Rohan Malviya', 'rohan.c10@cms.com', 'student123', 10, 'Male'),
(94, 'Amit Borkar', 'amit.c10@cms.com', 'student123', 10, 'Male'),
(95, 'Nilesh Purohit', 'nilesh.c10@cms.com', 'student123', 10, 'Male'),
(96, 'Sanket Jadhav', 'sanket.c10@cms.com', 'student123', 10, 'Male'),
(97, 'Shraddha Kulkarni', 'shraddha.c10@cms.com', 'student123', 10, 'Female'),
(98, 'Aparna Joshi', 'aparna.c10@cms.com', 'student123', 10, 'Female'),
(99, 'Ritu Chawla', 'ritu.c10@cms.com', 'student123', 10, 'Female'),
(100, 'Monika Bansal', 'monika.c10@cms.com', 'student123', 10, 'Female'),
(101, 'Vaishnavi Patil', 'vaishnavi.c10@cms.com', 'student123', 10, 'Female');

-- --------------------------------------------------------

--
-- Table structure for table `subjects`
--

CREATE TABLE `subjects` (
  `subject_id` int(11) NOT NULL,
  `subject_name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `subjects`
--

INSERT INTO `subjects` (`subject_id`, `subject_name`) VALUES
(1, 'Mathematics'),
(2, 'English'),
(3, 'Science'),
(4, 'Social Studies');

-- --------------------------------------------------------

--
-- Table structure for table `teachers`
--

CREATE TABLE `teachers` (
  `teacher_id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `subject` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `teachers`
--

INSERT INTO `teachers` (`teacher_id`, `name`, `email`, `password`, `subject`) VALUES
(1, 'Teacher_1_Maths', 't1@cms.com', 'teacher123', 'Mathematics'),
(2, 'Teacher_2_English', 't2@cms.com', 'teacher123', 'English'),
(3, 'Teacher_3_Science', 't3@cms.com', 'teacher123', 'Science'),
(4, 'Teacher_4_SST', 't4@cms.com', 'teacher123', 'Social Studies'),
(5, 'Teacher_5_Maths', 't5@cms.com', 'teacher123', 'Mathematics'),
(6, 'Teacher_6_English', 't6@cms.com', 'teacher123', 'English'),
(7, 'Teacher_7_Science', 't7@cms.com', 'teacher123', 'Science'),
(8, 'Teacher_8_SST', 't8@cms.com', 'teacher123', 'Social Studies'),
(9, 'Teacher_9_Maths', 't9@cms.com', 'teacher123', 'Mathematics'),
(10, 'Teacher_10_English', 't10@cms.com', 'teacher123', 'English');

-- --------------------------------------------------------

--
-- Table structure for table `timetable`
--

CREATE TABLE `timetable` (
  `timetable_id` int(11) NOT NULL,
  `class` int(11) DEFAULT NULL,
  `subject` varchar(50) DEFAULT NULL,
  `teacher` varchar(100) DEFAULT NULL,
  `day` varchar(20) DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `teacher_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `timetable`
--

INSERT INTO `timetable` (`timetable_id`, `class`, `subject`, `teacher`, `day`, `start_time`, `end_time`, `teacher_id`) VALUES
(1, 1, 'Mathematics', 'Teacher 1', 'Monday', '08:00:00', '08:30:00', 1),
(2, 1, 'English', 'Teacher 2', 'Monday', '08:30:00', '09:00:00', 2),
(3, 2, 'Science', 'Teacher 3', 'Monday', '08:00:00', '08:30:00', 3),
(4, 2, 'Mathematics', 'Teacher 1', 'Monday', '08:30:00', '09:00:00', 1),
(5, 3, 'English', 'Teacher 2', 'Monday', '09:00:00', '09:30:00', 2),
(6, 3, 'Science', 'Teacher 3', 'Monday', '09:30:00', '10:00:00', 3),
(7, 4, 'Mathematics', 'Teacher 4', 'Monday', '09:00:00', '09:30:00', 4),
(8, 4, 'English', 'Teacher 2', 'Monday', '09:30:00', '10:00:00', 2),
(9, 5, 'Science', 'Teacher 3', 'Monday', '10:00:00', '10:30:00', 3),
(10, 5, 'Mathematics', 'Teacher 5', 'Monday', '10:30:00', '11:00:00', 5),
(11, 6, 'English', 'Teacher 6', 'Monday', '13:50:00', '14:20:00', 6),
(12, 6, 'Science', 'Teacher 3', 'Monday', '14:20:00', '14:50:00', 3),
(13, 7, 'Mathematics', 'Teacher 5', 'Monday', '13:50:00', '14:20:00', 5),
(14, 7, 'English', 'Teacher 6', 'Monday', '14:20:00', '14:50:00', 6),
(15, 8, 'Science', 'Teacher 7', 'Monday', '14:50:00', '15:20:00', 7),
(16, 8, 'Mathematics', 'Teacher 1', 'Monday', '15:20:00', '15:50:00', 1),
(17, 9, 'English', 'Teacher 6', 'Monday', '14:50:00', '15:20:00', 6),
(18, 9, 'Science', 'Teacher 7', 'Monday', '15:20:00', '15:50:00', 7),
(19, 10, 'Mathematics', 'Teacher 4', 'Monday', '13:50:00', '14:20:00', 4),
(20, 10, 'English', 'Teacher 6', 'Monday', '14:20:00', '14:50:00', 6),
(21, 1, 'Science', 'Teacher 3', 'Tuesday', '08:00:00', '08:30:00', 3),
(22, 1, 'Mathematics', 'Teacher 1', 'Tuesday', '08:30:00', '09:00:00', 1),
(23, 2, 'English', 'Teacher 2', 'Tuesday', '08:00:00', '08:30:00', 2),
(24, 2, 'Science', 'Teacher 3', 'Tuesday', '08:30:00', '09:00:00', 3),
(25, 3, 'Mathematics', 'Teacher 1', 'Tuesday', '09:00:00', '09:30:00', 1),
(26, 3, 'English', 'Teacher 2', 'Tuesday', '09:30:00', '10:00:00', 2),
(27, 4, 'Science', 'Teacher 3', 'Tuesday', '09:00:00', '09:30:00', 3),
(28, 4, 'Mathematics', 'Teacher 4', 'Tuesday', '09:30:00', '10:00:00', 4),
(29, 5, 'English', 'Teacher 2', 'Tuesday', '10:00:00', '10:30:00', 2),
(30, 5, 'Science', 'Teacher 3', 'Tuesday', '10:30:00', '11:00:00', 3),
(31, 6, 'Mathematics', 'Teacher 5', 'Tuesday', '13:50:00', '14:20:00', 5),
(32, 6, 'English', 'Teacher 6', 'Tuesday', '14:20:00', '14:50:00', 6),
(33, 7, 'Science', 'Teacher 7', 'Tuesday', '13:50:00', '14:20:00', 7),
(34, 7, 'Mathematics', 'Teacher 5', 'Tuesday', '14:20:00', '14:50:00', 5),
(35, 8, 'English', 'Teacher 6', 'Tuesday', '14:50:00', '15:20:00', 6),
(36, 8, 'Science', 'Teacher 7', 'Tuesday', '15:20:00', '15:50:00', 7),
(37, 9, 'Mathematics', 'Teacher 1', 'Tuesday', '13:50:00', '14:20:00', 1),
(38, 9, 'English', 'Teacher 6', 'Tuesday', '14:20:00', '14:50:00', 6),
(39, 10, 'Science', 'Teacher 7', 'Tuesday', '14:50:00', '15:20:00', 7),
(40, 10, 'Mathematics', 'Teacher 4', 'Tuesday', '15:20:00', '15:50:00', 4),
(41, 1, 'English', 'Teacher 2', 'Wednesday', '08:00:00', '08:30:00', 2),
(42, 1, 'Science', 'Teacher 3', 'Wednesday', '08:30:00', '09:00:00', 3),
(43, 2, 'Mathematics', 'Teacher 1', 'Wednesday', '09:00:00', '09:30:00', 1),
(44, 2, 'English', 'Teacher 2', 'Wednesday', '09:30:00', '10:00:00', 2),
(45, 3, 'Science', 'Teacher 3', 'Wednesday', '08:00:00', '08:30:00', 3),
(46, 3, 'Mathematics', 'Teacher 1', 'Wednesday', '08:30:00', '09:00:00', 1),
(47, 4, 'English', 'Teacher 2', 'Wednesday', '09:00:00', '09:30:00', 2),
(48, 4, 'Science', 'Teacher 3', 'Wednesday', '09:30:00', '10:00:00', 3),
(49, 5, 'Mathematics', 'Teacher 4', 'Wednesday', '10:00:00', '10:30:00', 4),
(50, 5, 'English', 'Teacher 2', 'Wednesday', '10:30:00', '11:00:00', 2),
(51, 6, 'Science', 'Teacher 3', 'Wednesday', '13:50:00', '14:20:00', 3),
(52, 6, 'Mathematics', 'Teacher 5', 'Wednesday', '14:20:00', '14:50:00', 5),
(53, 7, 'English', 'Teacher 6', 'Wednesday', '13:50:00', '14:20:00', 6),
(54, 7, 'Science', 'Teacher 7', 'Wednesday', '14:20:00', '14:50:00', 7),
(55, 8, 'Mathematics', 'Teacher 5', 'Wednesday', '14:50:00', '15:20:00', 5),
(56, 8, 'English', 'Teacher 6', 'Wednesday', '15:20:00', '15:50:00', 6),
(57, 9, 'Science', 'Teacher 7', 'Wednesday', '13:50:00', '14:20:00', 7),
(58, 9, 'English', 'Teacher 6', 'Wednesday', '14:20:00', '14:50:00', 6),
(59, 10, 'Mathematics', 'Teacher 4', 'Wednesday', '14:50:00', '15:20:00', 4),
(60, 10, 'Science', 'Teacher 3', 'Wednesday', '15:20:00', '15:50:00', 3),
(61, 1, 'Mathematics', 'Teacher 1', 'Thursday', '08:00:00', '08:30:00', 1),
(62, 1, 'English', 'Teacher 2', 'Thursday', '08:30:00', '09:00:00', 2),
(63, 2, 'Science', 'Teacher 3', 'Thursday', '09:00:00', '09:30:00', 3),
(64, 2, 'Mathematics', 'Teacher 1', 'Thursday', '09:30:00', '10:00:00', 1),
(65, 3, 'English', 'Teacher 2', 'Thursday', '08:00:00', '08:30:00', 2),
(66, 3, 'Science', 'Teacher 3', 'Thursday', '08:30:00', '09:00:00', 3),
(67, 4, 'Mathematics', 'Teacher 4', 'Thursday', '09:00:00', '09:30:00', 4),
(68, 4, 'English', 'Teacher 2', 'Thursday', '09:30:00', '10:00:00', 2),
(69, 5, 'Science', 'Teacher 3', 'Thursday', '10:00:00', '10:30:00', 3),
(70, 5, 'Mathematics', 'Teacher 4', 'Thursday', '10:30:00', '11:00:00', 4),
(71, 6, 'English', 'Teacher 6', 'Thursday', '13:50:00', '14:20:00', 6),
(72, 6, 'Science', 'Teacher 3', 'Thursday', '14:20:00', '14:50:00', 3),
(73, 7, 'Mathematics', 'Teacher 5', 'Thursday', '13:50:00', '14:20:00', 5),
(74, 7, 'English', 'Teacher 6', 'Thursday', '14:20:00', '14:50:00', 6),
(75, 8, 'Science', 'Teacher 7', 'Thursday', '14:50:00', '15:20:00', 7),
(76, 8, 'Mathematics', 'Teacher 5', 'Thursday', '15:20:00', '15:50:00', 5),
(77, 9, 'Mathematics', 'Teacher 8', 'Thursday', '13:50:00', '14:20:00', 8),
(78, 9, 'Science', 'Teacher 7', 'Thursday', '14:20:00', '14:50:00', 7),
(79, 10, 'English', 'Teacher 6', 'Thursday', '14:50:00', '15:20:00', 6),
(80, 10, 'Mathematics', 'Teacher 4', 'Thursday', '15:20:00', '15:50:00', 4),
(81, 1, 'Science', 'Teacher 3', 'Friday', '08:00:00', '08:30:00', 3),
(82, 1, 'Mathematics', 'Teacher 1', 'Friday', '08:30:00', '09:00:00', 1),
(83, 2, 'English', 'Teacher 2', 'Friday', '09:00:00', '09:30:00', 2),
(84, 2, 'Science', 'Teacher 3', 'Friday', '09:30:00', '10:00:00', 3),
(85, 3, 'Mathematics', 'Teacher 1', 'Friday', '08:00:00', '08:30:00', 1),
(86, 3, 'English', 'Teacher 2', 'Friday', '08:30:00', '09:00:00', 2),
(87, 4, 'Science', 'Teacher 3', 'Friday', '09:00:00', '09:30:00', 3),
(88, 4, 'Mathematics', 'Teacher 4', 'Friday', '09:30:00', '10:00:00', 4),
(89, 5, 'English', 'Teacher 2', 'Friday', '10:00:00', '10:30:00', 2),
(90, 5, 'Science', 'Teacher 3', 'Friday', '10:30:00', '11:00:00', 3),
(91, 6, 'Mathematics', 'Teacher 5', 'Friday', '13:50:00', '14:20:00', 5),
(92, 6, 'English', 'Teacher 6', 'Friday', '14:20:00', '14:50:00', 6),
(93, 7, 'Science', 'Teacher 7', 'Friday', '13:50:00', '14:20:00', 7),
(94, 7, 'Mathematics', 'Teacher 5', 'Friday', '14:20:00', '14:50:00', 5),
(95, 8, 'English', 'Teacher 6', 'Friday', '14:50:00', '15:20:00', 6),
(96, 8, 'Science', 'Teacher 7', 'Friday', '15:20:00', '15:50:00', 7),
(97, 9, 'Science', 'Teacher 7', 'Friday', '13:50:00', '14:20:00', 7),
(98, 9, 'Mathematics', 'Teacher 8', 'Friday', '14:20:00', '14:50:00', 8),
(99, 10, 'Mathematics', 'Teacher 4', 'Friday', '14:50:00', '15:20:00', 4),
(100, 10, 'English', 'Teacher 6', 'Friday', '15:20:00', '15:50:00', 6);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`admin_id`);

--
-- Indexes for table `attendance`
--
ALTER TABLE `attendance`
  ADD PRIMARY KEY (`attendance_id`);

--
-- Indexes for table `exams`
--
ALTER TABLE `exams`
  ADD PRIMARY KEY (`exam_id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`student_id`);

--
-- Indexes for table `subjects`
--
ALTER TABLE `subjects`
  ADD PRIMARY KEY (`subject_id`);

--
-- Indexes for table `teachers`
--
ALTER TABLE `teachers`
  ADD PRIMARY KEY (`teacher_id`);

--
-- Indexes for table `timetable`
--
ALTER TABLE `timetable`
  ADD PRIMARY KEY (`timetable_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `attendance`
--
ALTER TABLE `attendance`
  MODIFY `attendance_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=111;

--
-- AUTO_INCREMENT for table `exams`
--
ALTER TABLE `exams`
  MODIFY `exam_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `student_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=102;

--
-- AUTO_INCREMENT for table `subjects`
--
ALTER TABLE `subjects`
  MODIFY `subject_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `teachers`
--
ALTER TABLE `teachers`
  MODIFY `teacher_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `timetable`
--
ALTER TABLE `timetable`
  MODIFY `timetable_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=125;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
