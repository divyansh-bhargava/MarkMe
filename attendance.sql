
CREATE TABLE `student` (
  `id` int(11) NOT NULL,
  `roll` varchar(10) NOT NULL,
  `name` varchar(32) NOT NULL,
  `email` varchar(32) NOT NULL,
  `contact` varchar(10) NOT NULL,
  `course_id` int(11) NOT NULL,
  PRIMARY KEY(`roll`),
  foreign key(`course_id`) references `course`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `student` (`id`, `roll`, `name`, `email`, `contact`, `course_id`) VALUES
(1, '23cs101', 'Aarav Sharma', '23cs101@xyz.edu.in', '9876543210', 1),
(2, '23ec102', 'Isha Verma', '23ec102@xyz.edu.in', '9123456780', 2),
(3, '22me103', 'Rahul Mehta', '22me103@xyz.edu.in', '9988776655', 3),
(4, '21ce104', 'Sneha Patel', '21ce104@xyz.edu.in', '9871234560', 4),
(5, '23ei105', 'Karan Singh', '23ei105@xyz.edu.in', '9845671230', 5),
(6, '23cs106', 'Priya Nair', '23cs106@xyz.edu.in', '9812345678', 1),
(7, '22ec107', 'Rohan Das', '22ec107@xyz.edu.in', '9770011223', 2),
(8, '21me108', 'Ananya Roy', '21me108@xyz.edu.in', '9765432100', 3),
(9, '20ce109', 'Deepak Kumar', '20ce109@xyz.edu.in', '9876012345', 4),
(10, '23ei110', 'Meera Joshi', '23ei110@xyz.edu.in', '9988123456', 5),
(11, '23cs111', 'Vikram Chauhan', '23cs111@xyz.edu.in', '9823456789', 1),
(12, '22ec112', 'Neha Sinha', '22ec112@xyz.edu.in', '9753124680', 2),
(13, '21me113', 'Amitabh Desai', '21me113@xyz.edu.in', '9965321789', 3),
(14, '20ce114', 'Tanya Bhatia', '20ce114@xyz.edu.in', '9998887776', 4),
(15, '23ei115', 'Siddharth Rao', '23ei115@xyz.edu.in', '9811122233', 5),
(16, '23cs116', 'Pooja Kaul', '23cs116@xyz.edu.in', '9801234567', 1),
(17, '22ec117', 'Arjun Malhotra', '22ec117@xyz.edu.in', '9876543001', 2),
(18, '21me118', 'Ritika Gupta', '21me118@xyz.edu.in', '9867543210', 3),
(19, '20ce119', 'Nikhil Bansal', '20ce119@xyz.edu.in', '9844001122', 4),
(20, '23ei120', 'Divya Kapoor', '23ei120@xyz.edu.in', '9900112233', 5);


CREATE TABLE `studentPassword` (
  `id` int(11) NOT NULL,
  `roll` varchar(11) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY(`id`),
  FOREIGN KEY(`roll`) REFERENCES `student`(`roll`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `teacher` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `Department` enum('CSE','ECE', 'EIE','ME' , 'CE') NOT NULL,
  `contact` varchar(255) NOT NULL,
  PRIMARY KEY(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


INSERT INTO `teacher` (`id`, `name`, `email`, `Department`, `contact`) VALUES
(1, 'Dr. Aarti Sharma', 'aarti.sharma@xyz.edu.in', 'CSE', '9871112233'),
(2, 'Dr. Rajeev Verma', 'rajeev.verma@xyz.edu.in', 'ECE', '9872223344'),
(3, 'Dr. Neelam Rathi', 'neelam.rathi@xyz.edu.in', 'EIE', '9873334455'),
(4, 'Dr. Anil Mehra', 'anil.mehra@xyz.edu.in', 'ME', '9874445566'),
(5, 'Dr. Sunita Das', 'sunita.das@xyz.edu.in', 'CE', '9875556677'),
(6, 'Prof. Karan Kapoor', 'karan.kapoor@xyz.edu.in', 'CSE', '9876667788'),
(7, 'Prof. Meena Bhatt', 'meena.bhatt@xyz.edu.in', 'ECE', '9877778899'),
(8, 'Dr. Suresh Iyer', 'suresh.iyer@xyz.edu.in', 'ME', '9878889900'),
(9, 'Prof. Ritu Jain', 'ritu.jain@xyz.edu.in', 'CE', '9879990011'),
(10, 'Dr. Naveen Joshi', 'naveen.joshi@xyz.edu.in', 'EIE', '9880001122'),
(11, 'Prof. Priya Sinha', 'priya.sinha@xyz.edu.in', 'CSE', '9881112233'),
(12, 'Dr. Harish Rao', 'harish.rao@xyz.edu.in', 'ECE', '9882223344'),
(13, 'Prof. Alok Mittal', 'alok.mittal@xyz.edu.in', 'ME', '9883334455'),
(14, 'Dr. Kavita Desai', 'kavita.desai@xyz.edu.in', 'CSE', '9884445566'),
(15, 'Prof. Rohit Nair', 'rohit.nair@xyz.edu.in', 'EIE', '9885556677');



CREATE TABLE `teacherPassword` (
  `id` int(11) NOT NULL,
  `teacher_id` varchar(11) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY(`id`),
  FOREIGN KEY(`teacher_id`) REFERENCES `teacher`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `subjects` (
  `id` int(11) NOT NULL,
  `code` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `teacher_id` varchar(255) NOT NULL,
  PRIMARY KEY(`code`),
  foreign key(`course_id`) references `course`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


INSERT INTO `subjects` (`id`, `code`, `name`, `teacher_id`) VALUES
(1, 'CSE101', 'Introduction to Programming', 1),
(2, 'CSE102', 'Data Structures', 6),
(3, 'CSE201', 'Operating Systems', 11),
(4, 'CSE301', 'Database Management Systems', 14),
(5, 'ECE201', 'Digital Electronics', 2),
(6, 'ECE202', 'Analog Circuits', 7),
(7, 'ECE301', 'Communication Systems', 12),
(8, 'ECE401', 'Microprocessors', 2),
(9, 'ME301', 'Thermodynamics', 4),
(10, 'ME302', 'Fluid Mechanics', 8),
(11, 'ME401', 'Machine Design', 13),
(12, 'ME501', 'Heat Transfer', 4),
(13, 'CE401', 'Structural Analysis', 5),
(14, 'CE402', 'Geotechnical Engineering', 9),
(15, 'CE501', 'Transportation Engineering', 5),
(16, 'CE601', 'Environmental Engineering', 9),
(17, 'EIE501', 'Instrumentation Systems', 3),
(18, 'EIE502', 'Control Systems', 10),
(19, 'EIE601', 'Process Control', 15),
(20, 'EIE701', 'Biomedical Instrumentation', 15);



CREATE TABLE `course` (
  `id` int(11) NOT NULL,
  `name` enum('btech','mtech') NOT NULL,
  `branch` enum('CSE','ECE', 'EIE','ME' , 'CE') NOT NULL,
  `year` int(11) NOT NULL,
  `semester` int(11) NOT NULL,
  PRIMARY KEY(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


INSERT INTO `course` (`id`, `name`, `branch`, `year`, `semester`) VALUES
(1, 'btech', 'CSE', 1, 1),
(2, 'btech', 'ECE', 2, 3),
(3, 'btech', 'ME', 3, 5),
(4, 'btech', 'CE', 4, 7),
(5, 'btech', 'EIE', 2, 4),
(6, 'mtech', 'CSE', 1, 1),
(7, 'mtech', 'ECE', 1, 2),
(8, 'mtech', 'ME', 2, 3),
(9, 'mtech', 'CE', 2, 4),
(10, 'mtech', 'EIE', 1, 1);



CREATE TABLE `attendance` (
  `id` int(11) NOT NULL,
  `roll` varchar(255) NOT NULL,
  `subject_id` varchar(255) NOT NULL,
  `teacher_id` int(11) NOT NULL,
  `date` date NOT NULL DEFAULT (CURRENT_DATE),
  `status` varchar(255) NOT NULL,
  PRIMARY KEY(`id`),
  FOREIGN KEY (`subject_id`) REFERENCES `subjects`(`code`),
  FOREIGN KEY (`roll`) REFERENCES `student`(`roll`),
  FOREIGN KEY (`teacher_id`) REFERENCES `teacher`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `otp_table`(
  `id` int(11) NOT NULL,
  'email' varchar(16) NOT NULL,
  'otp' int(6) NOT NULL,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `expires_at` DATETIME NOT NULL,
  PRIMARY KEY(`id`),
);



INSERT INTO `attendance` (`id`, `roll`, `subject_id`, `teacher_id`, `date`, `status`) VALUES
(1, '22me103', 'ECE301', 12, '2025-04-22', 'Present'),
(2, '21me118', 'CSE102', 6, '2025-05-11', 'Present'),
(3, '23ei105', 'CSE201', 11, '2025-05-01', 'Present'),
(4, '23ei120', 'CE501', 5, '2025-05-07', 'Present'),
(5, '23ei120', 'EIE502', 10, '2025-05-10', 'Present'),
(6, '21me108', 'CE401', 5, '2025-04-15', 'Present'),
(7, '21me108', 'ECE401', 2, '2025-04-25', 'Present'),
(8, '20ce119', 'ECE301', 12, '2025-04-15', 'Present'),
(9, '20ce109', 'ECE401', 2, '2025-05-04', 'Present'),
(10, '20ce119', 'CE402', 9, '2025-04-26', 'Absent'),
(11, '22ec112', 'CSE301', 14, '2025-05-15', 'Present'),
(12, '23ei105', 'CE601', 9, '2025-05-11', 'Absent'),
(13, '22ec112', 'CSE102', 6, '2025-05-06', 'Present'),
(14, '22ec117', 'ECE301', 12, '2025-04-18', 'Present'),
(15, '21ce104', 'EIE701', 15, '2025-04-16', 'Absent'),
(16, '23ei115', 'ME401', 13, '2025-05-01', 'Present'),
(17, '23ei110', 'EIE601', 15, '2025-04-20', 'Absent'),
(18, '20ce119', 'EIE502', 10, '2025-05-14', 'Present'),
(19, '23ei110', 'ME501', 4, '2025-04-29', 'Absent'),
(20, '21me108', 'CE501', 5, '2025-04-25', 'Present'),
(21, '23cs111', 'ME401', 13, '2025-05-08', 'Absent'),
(22, '21me118', 'CSE301', 14, '2025-05-06', 'Present'),
(23, '23ei110', 'ECE301', 12, '2025-04-19', 'Present'),
(24, '21me118', 'EIE601', 15, '2025-04-21', 'Present'),
(25, '23cs116', 'CSE101', 1, '2025-04-28', 'Present'),
(26, '23ei115', 'CSE101', 1, '2025-05-14', 'Present'),
(27, '21ce104', 'EIE502', 10, '2025-05-04', 'Present'),
(28, '21me113', 'ECE202', 7, '2025-04-19', 'Present'),
(29, '23cs106', 'CE401', 5, '2025-04-24', 'Present'),
(30, '21me108', 'CSE101', 1, '2025-05-12', 'Present'),
(31, '20ce109', 'ME302', 8, '2025-05-03', 'Present'),
(32, '23cs116', 'CSE301', 14, '2025-04-20', 'Present'),
(33, '21me108', 'ECE401', 2, '2025-05-09', 'Present'),
(34, '23ei120', 'CE402', 9, '2025-05-08', 'Absent'),
(35, '22me103', 'CSE301', 14, '2025-05-15', 'Present'),
(36, '23cs101', 'CSE201', 11, '2025-04-17', 'Present'),
(37, '23ei110', 'CSE101', 1, '2025-05-12', 'Present'),
(38, '23ei110', 'ME401', 13, '2025-05-10', 'Present'),
(39, '23ei105', 'ME501', 4, '2025-04-21', 'Absent'),
(40, '22me103', 'EIE701', 15, '2025-05-01', 'Present'),
(41, '21ce104', 'CSE101', 1, '2025-05-12', 'Present'),
(42, '20ce109', 'CSE301', 14, '2025-04-18', 'Absent'),
(43, '22me103', 'EIE601', 15, '2025-04-27', 'Present'),
(44, '23cs106', 'ME401', 13, '2025-05-06', 'Absent'),
(45, '23cs116', 'CSE101', 1, '2025-04-24', 'Present'),
(46, '23ei120', 'CSE102', 6, '2025-05-03', 'Absent'),
(47, '22me103', 'CSE201', 11, '2025-05-13', 'Present'),
(48, '22ec117', 'ME302', 8, '2025-04-28', 'Present'),
(49, '21ce104', 'CE401', 5, '2025-04-18', 'Present'),
(50, '21me113', 'CSE301', 14, '2025-05-14', 'Present'),
(51, '23cs101', 'ECE301', 12, '2025-05-13', 'Present'),
(52, '22ec112', 'CSE102', 6, '2025-04-26', 'Present'),
(53, '20ce109', 'ECE301', 12, '2025-04-30', 'Present'),
(54, '23cs106', 'ME302', 8, '2025-04-21', 'Present'),
(55, '21me113', 'CSE201', 11, '2025-04-20', 'Absent'),
(56, '23cs116', 'ME401', 13, '2025-04-28', 'Present'),
(57, '21ce104', 'ME501', 4, '2025-04-29', 'Present'),
(58, '21ce104', 'EIE502', 10, '2025-05-11', 'Present'),
(59, '22me103', 'ECE202', 7, '2025-04-27', 'Present'),
(60, '21ce104', 'EIE601', 15, '2025-05-09', 'Absent'),
(61, '21me118', 'ME401', 13, '2025-04-19', 'Present'),
(62, '20ce109', 'CSE101', 1, '2025-04-24', 'Present'),
(63, '23ei105', 'CE402', 9, '2025-04-30', 'Present'),
(64, '23ei120', 'CSE201', 11, '2025-05-06', 'Absent'),
(65, '23cs106', 'CSE101', 1, '2025-05-13', 'Present'),
(66, '23cs111', 'EIE601', 15, '2025-05-15', 'Present'),
(67, '22ec117', 'ECE301', 12, '2025-04-20', 'Present'),
(68, '23ei120', 'ECE401', 2, '2025-04-22', 'Present'),
(69, '23ei110', 'CSE301', 14, '2025-04-26', 'Present'),
(70, '21me108', 'ME302', 8, '2025-05-10', 'Present'),
(71, '22ec117', 'CSE102', 6, '2025-04-28', 'Absent'),
(72, '23cs101', 'CSE101', 1, '2025-04-18', 'Present'),
(73, '23ei110', 'CSE102', 6, '2025-05-07', 'Present'),
(74, '21me113', 'EIE601', 15, '2025-04-21', 'Present'),
(75, '23cs106', 'ME501', 4, '2025-05-05', 'Absent'),
(76, '21me113', 'ME302', 8, '2025-05-09', 'Present'),
(77, '23ei110', 'ME401', 13, '2025-04-22', 'Present'),
(78, '21me108', 'CSE101', 1, '2025-04-26', 'Present'),
(79, '21ce104', 'ECE202', 7, '2025-05-11', 'Absent'),
(80, '23cs101', 'ECE301', 12, '2025-05-13', 'Present');

