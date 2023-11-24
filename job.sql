-- phpMyAdmin SQL Dump
-- version 3.2.0.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Oct 29, 2013 at 05:28 PM
-- Server version: 5.5.8
-- PHP Version: 5.3.3
-- Your SQL dump with Trigger and Log Table modifications

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `job`
--

-- --------------------------------------------------------

--
-- Table structure for table `application_master`
--

CREATE TABLE IF NOT EXISTS `application_master` (
  `ApplicationId` int(11) NOT NULL AUTO_INCREMENT,
  `JobSeekId` int(11) NOT NULL,
  `JobId` int(11) NOT NULL,
  `Status` varchar(30) NOT NULL,
  `Description` varchar(200) NOT NULL,
  PRIMARY KEY (`ApplicationId`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `application_master`
--

INSERT INTO `application_master` (`ApplicationId`, `JobSeekId`, `JobId`, `Status`, `Description`) VALUES
(1, 3, 1, 'Call Latter Send', 'Invited on 21-Dec-2013.'),
(2, 3, 2, 'Call Latter Send', 'You are Invited For Interview on 10-MAR-2013.'),
(3, 3, 3, 'Call Latter Send', 'Invited on 21-Dec-2013.'),
(5, 3, 4, 'Call Latter Send', 'Invited on 21-Dec-2013.');

-- --------------------------------------------------------

--
-- Table structure for table `application_log`
--

CREATE TABLE IF NOT EXISTS `application_log` (
  `LogId` int(11) NOT NULL AUTO_INCREMENT,
  `JobSeekId` int(11) NOT NULL,
  `JobId` int(11) NOT NULL,
  `Status` varchar(30) NOT NULL,
  `Description` varchar(200) NOT NULL,
  `AppliedDate` DATE NOT NULL, -- New column added
  `LogDate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`LogId`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Trigger to log changes in application_master table
--
DELIMITER //

CREATE TRIGGER application_master_trigger
AFTER INSERT ON application_master
FOR EACH ROW
BEGIN
    INSERT INTO application_log (JobSeekId, JobId, Status, Description, AppliedDate)
    VALUES (NEW.JobSeekId, NEW.JobId, NEW.Status, NEW.Description, NEW.AppliedDate);
END;
//

DELIMITER ;

-- --------------------------------------------------------

-- Cursor Example
DELIMITER //
CREATE PROCEDURE displayJobApplications(IN jobSeekerId INT)
BEGIN
    -- Display job applications for a specific job seeker
    SELECT a.ApplicationId, a.Status, a.Description, j.JobTitle, j.CompanyName
    FROM application_master a
    JOIN job_master j ON a.JobId = j.JobId
    WHERE a.JobSeekId = jobSeekerId;
END //
DELIMITER ;

DELIMITER //
CALL displayJobApplications(3);

CREATE PROCEDURE Getjobseeker_regCount()
BEGIN
    SELECT COUNT(*) AS 'Totaljobseeker_reg' FROM jobseeker_reg;
  
END //
DELIMITER ;
CALL Getjobseeker_regCount();

DELIMITER //

CREATE PROCEDURE Getjobseeker_educationCount()
BEGIN
   
    SELECT COUNT(*) AS 'Totaljobseeker_education' FROM jobseeker_education;
     
END //

DELIMITER ;
CALL Getjobseeker_educationCount();


-- functions example
DELIMITER //
CREATE FUNCTION getJobApplications(jobSeekerId INT) RETURNS INT DETERMINISTIC
BEGIN
    DECLARE totalApplications INT;

    -- Count the number of job applications for a specific job seeker
    SELECT COUNT(*) INTO totalApplications
    FROM application_master
    WHERE JobSeekId = jobSeekerId;

    RETURN totalApplications;
END //
DELIMITER ;

-- Call the function for a specific job seeker ID (replace 3 with the desired JobSeekId)
SELECT getJobApplications(3) AS 'Total Job Applications';

-- nested query
SELECT JobTitle FROM job_master WHERE JobId IN ( SELECT JobId FROM application_master WHERE Status = 'Call Latter Send');

SELECT JobTitle, CompanyName FROM job_master WHERE JobId NOT IN (SELECT JobId FROM application_master);

--
-- Table structure for table `employer_reg`
--

CREATE TABLE IF NOT EXISTS `employer_reg` (
  `EmployerId` int(11) NOT NULL AUTO_INCREMENT,
  `CompanyName` varchar(20) NOT NULL,
  `ContactPerson` varchar(20) NOT NULL,
  `Address` varchar(100) NOT NULL,
  `City` varchar(20) NOT NULL,
  `Email` varchar(40) NOT NULL,
  `Mobile` bigint(20) NOT NULL,
  `Area_Work` varchar(40) NOT NULL,
  `Status` varchar(10) NOT NULL,
  `UserName` varchar(20) NOT NULL,
  `Password` varchar(20) NOT NULL,
  `Question` varchar(100) NOT NULL,
  `Answer` varchar(50) NOT NULL,
  PRIMARY KEY (`EmployerId`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `employer_reg`
--

INSERT INTO `employer_reg` (`EmployerId`, `CompanyName`, `ContactPerson`, `Address`, `City`, `Email`, `Mobile`, `Area_Work`, `Status`, `UserName`, `Password`, `Question`, `Answer`) VALUES
(2, 'TCS Private Limited', 'Mr. Mohan Shah', 'Navarangpura1', 'Ahmedabad', 'mohan@gmail.com', 9898989898, 'Software', 'Confirm', 'mohan', 'mohan', 'Who is Your Favourite Person?', 'sachin'),
(3, 'Wipro Infotech', 'Mr. Sunil Pandya', 'Baroda', 'Baroda', 'sunil@wipro.com', 8989898989, 'Hardware', 'Confirm', 'sunil', 'sunil', '', ''),
(4, 'Solusoft  Pvt Limite', 'Mr. Nirav Soni', 'Narayanpura', 'Ahmedabad', 'nirav@gmail.com', 9898989898, 'Software', 'Confirm', 'nirav', 'nirav', 'What is Your Pet Name?', 'niru'),
(5, 'Info Matrics', 'Mr. Narayan', 'Sahibagh', 'Ahmedabad', 'narayan@yahoo.com', 6767676767, 'Software', 'Confirm', 'narayan', 'narayan', 'What is Your Pet Name?', 'nari');

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE IF NOT EXISTS `feedback` (
  `FeedbackId` int(11) NOT NULL AUTO_INCREMENT,
  `JobSeekId` int(11) NOT NULL,
  `Feedback` varchar(200) NOT NULL,
  `FeedbakDate` date NOT NULL,
  PRIMARY KEY (`FeedbackId`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `feedback`
--

INSERT INTO `feedback` (`FeedbackId`, `JobSeekId`, `Feedback`, `FeedbakDate`) VALUES
(5, 3, 'asdad', '2018-09-13'),
(6, 3, 'asd', '2013-09-18'),
(7, 4, 'Thanks For Your Support.', '2013-09-18'),
(8, 3, 'asd', '2013-09-22');

-- --------------------------------------------------------

--
-- Table structure for table `jobseeker_education`
--

CREATE TABLE IF NOT EXISTS `jobseeker_education` (
  `EduId` int(11) NOT NULL AUTO_INCREMENT,
  `JobSeekId` int(11) NOT NULL,
  `Degree` varchar(20) NOT NULL,
  `University` varchar(100) NOT NULL,
  `PassingYear` mediumint(9) NOT NULL,
  `Percentage` float NOT NULL,
  PRIMARY KEY (`EduId`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `jobseeker_education`
--

INSERT INTO `jobseeker_education` (`EduId`, `JobSeekId`, `Degree`, `University`, `PassingYear`, `Percentage`) VALUES
(3, 3, 'B.C.A', 'Ganpat Universiy', 2011, 68.89),
(4, 3, 'M.C.A', 'Ganpat University', 2013, 89.9),
(5, 3, 'S.S.C', 'GSEB', 2005, 80);

-- --------------------------------------------------------

--
-- Table structure for table `jobseeker_reg`
--

CREATE TABLE IF NOT EXISTS `jobseeker_reg` (
  `JobSeekId` int(11) NOT NULL AUTO_INCREMENT,
  `JobSeekerName` varchar(20) NOT NULL,
  `Address` varchar(100) NOT NULL,
  `City` varchar(20) NOT NULL,
  `Email` varchar(40) NOT NULL,
  `Mobile` bigint(20) NOT NULL,
  `Qualification` varchar(20) NOT NULL,
  `Gender` varchar(10) NOT NULL,
  `BirthDate` date NOT NULL,
  `Resume` varchar(200) NOT NULL,
  `Status` varchar(10) NOT NULL,
  `UserName` varchar(20) NOT NULL,
  `Password` varchar(20) NOT NULL,
  `Question` varchar(100) NOT NULL,
  `Answer` varchar(50) NOT NULL,
  PRIMARY KEY (`JobSeekId`),
  KEY `JobSeekId` (`JobSeekId`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `jobseeker_reg`
--

INSERT INTO `jobseeker_reg` (`JobSeekId`, `JobSeekerName`, `Address`, `City`, `Email`, `Mobile`, `Qualification`, `Gender`, `BirthDate`, `Resume`, `Status`, `UserName`, `Password`, `Question`, `Answer`) VALUES
(3, 'Jalpa Prajapati', 'Near Dena Bank', 'Mehsana', 'jalpa@gmail.com', 9898989898, 'M.C.A', 'Female', '2013-09-10', 'Marksheet.pdf', 'Confirm', 'jalpa', 'jalpa', 'What is Your Pet Name?', 'jalpa'),
(4, 'Krunal Prajapati', 'Patan', 'Patan', 'krunal@gmail.com', 8989898989, 'M.B.A', 'Male', '2013-09-16', 'Marksheet.pdf', 'Confirm', 'krunal', 'krunal', '', ''),
(5, 'Gopal Patel', 'Patan', 'Patan', 'gopal@gmail.com', 9898989898, 'MA', 'Male', '2013-10-15', 'admin.jpg', 'Confirm', 'gopal', 'gopal', '', ''),
(6, 'Mehul Mistry', 'Swastik SOciety', 'Baroda', 'mehul@gmail.com', 8989898998, 'BE', 'Male', '2013-10-09', '470X310_1.jpg', 'Confirm', 'mehul', 'mehul', 'What is Your Pet Name?', 'mehu');

-- --------------------------------------------------------

--
-- Table structure for table `job_master`
--

CREATE TABLE IF NOT EXISTS `job_master` (
  `JobId` int(11) NOT NULL AUTO_INCREMENT,
  `CompanyName` varchar(20) NOT NULL,
  `JobTitle` varchar(50) NOT NULL,
  `Vacancy` int(11) NOT NULL,
  `MinQualification` varchar(50) NOT NULL,
  `Description` varchar(200) NOT NULL,
  PRIMARY KEY (`JobId`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `job_master`
--

INSERT INTO `job_master` (`JobId`, `CompanyName`, `JobTitle`, `Vacancy`, `MinQualification`, `Description`) VALUES
(1, 'Wipro Infotech', 'Software Professional Required', 2, 'M.C.A', 'ASP.NET'),
(2, 'Wipro Infotech', 'Marketing Executive Required', 5, 'M.B.A', 'Freshers Are Invited'),
(3, 'TCS Private Limited', 'Software Trainee Required', 1, 'B.Sc.I.T', 'Starting Salary 5000'),
(4, 'Wipro Infotech', 'Cleaners Required', 3, 'S.S.C', 'N');

-- --------------------------------------------------------

--
-- Table structure for table `news_master`
--

CREATE TABLE IF NOT EXISTS `news_master` (
  `NewsId` int(11) NOT NULL AUTO_INCREMENT,
  `News` varchar(200) NOT NULL,
  `NewsDate` date NOT NULL,
  PRIMARY KEY (`NewsId`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `news_master`
--

INSERT INTO `news_master` (`NewsId`, `News`, `NewsDate`) VALUES
(1, 'Register and Get JOB', '2013-09-24'),
(2, 'New Vacancies will be updated after diwali', '2013-10-31');

-- --------------------------------------------------------

--
-- Table structure for table `user_master`
--

CREATE TABLE IF NOT EXISTS `user_master` (
  `UserId` int(11) NOT NULL AUTO_INCREMENT,
  `UserName` varchar(20) NOT NULL,
  `Password` varchar(20) NOT NULL,
  PRIMARY KEY (`UserId`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Dumping data for table `user_master`
--

INSERT INTO `user_master` (`UserId`, `UserName`, `Password`) VALUES
(6, 'admin', 'admin'),
(10, 'xyz', 'xyz');

-- --------------------------------------------------------

--
-- Table structure for table `walkin_master`
--

CREATE TABLE IF NOT EXISTS `walkin_master` (
  `WalkInId` int(11) NOT NULL AUTO_INCREMENT,
  `CompanyName` varchar(20) NOT NULL,
  `JobTitle` varchar(50) NOT NULL,
  `Vacancy` int(11) NOT NULL,
  `MinQualification` varchar(50) NOT NULL,
  `Description` varchar(100) NOT NULL,
  `InterviewDate` date NOT NULL,
  `InterviewTime` time NOT NULL,
  PRIMARY KEY (`WalkInId`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `walkin_master`
--

INSERT INTO `walkin_master` (`WalkInId`, `CompanyName`, `JobTitle`, `Vacancy`, `MinQualification`, `Description`, `InterviewDate`, `InterviewTime`) VALUES
(1, 'Wipro Infotech', 'Freshers Required', 5, 'B.C.A', 'Hardworking Person are Required.', '2013-09-25', '09:00:00'),
(2, 'TCS Private Limited', 'Marketive Representative Invited', 2, 'Pharmacist', 'Ready TO work in North Gujarat', '2013-10-07', '09:00:00');
