
CREATE TABLE `student` (
  `id` int(11) NOT NULL,
  `roll` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `contact` varchar(255) NOT NULL,
  `course_id` int(11) NOT NULL,
  PRIMARY KEY(`roll`),
  foreign key(`course_id`) references `course`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `student` (`id`, `roll`, `name`, `email`, `contact`, `password` ,`course_id`) VALUES
(1 , `23c4124` , `Divyansh bhargava` , `23bcs124@ietdavv.edu.in` , `6262116490` , `$2a$10$FHzdnCILsa5I8ND4SAPj6eko2DVSmHnTmHrWE.l5sN7OjCljwfKpS` , 11),
(),
();

CREATE TABLE `studentPassword` (
  `id` int(11) NOT NULL,
  `roll` varchar(11) NOT NULL
  `password` varchar(255) NOT NULL,
  PRIMARY KEY(`id`),
  FOREIGN KEY(`roll`) REFERENCES `student`(`roll`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `teacher` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `branch` enum('CSE','ECE','EEE','ME','CE','HSS','CHEM','PHY') NOT NULL,
  `contact` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `teacherPassword` (
  `id` int(11) NOT NULL,
  `teacher_id` varchar(11) NOT NULL
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


CREATE TABLE `course` (
  `id` int(11) NOT NULL,
  `name` enum('btech','mtech') NOT NULL,
  `branch` enum('CSE','ECE','EEE','ME','CE','HSS','CHEM','PHY') NOT NULL,
  `year` int(11) NOT NULL,
  `semester` int(11) NOT NULL,
  PRIMARY KEY(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `attendance` (
  `id` int(11) NOT NULL,
  `roll` varchar(255) NOT NULL,
  `subject_id` varchar(255) NOT NULL,
  `teacher_id` int(11) NOT NULL,
  `date` date NOT NULL DEFAULT (CURRENT_DATE),
  `status` varchar(255) NOT NULL,
  PRIMARY KEY(`id`),
  foreign key(`subject_id`) references `subject`(`code`),
  foreign key(`roll`) references `student`(`roll`),
  foreign key(`teacher_id`) references `teacher`(`id`),
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `attendance` (`id`, `roll`, `year`, `semester`, `subject`, `date`, `status`) VALUES
(35, 'B200032CS', 2, 3, 'CS12010', '2022-10-09', 'present'),

INSERT INTO `student` (`id`, `roll`, `name`, `email`, `contact`, `course`, `year`, `branch`, `semester`, `password`) VALUES