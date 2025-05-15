const router = require("express").Router();

const {teacherSignUp, teacherSignin ,getSubjByCourse ,getStudentsBySubject ,takeAttendance ,getAttendanceBySubject, updateAttendance} = require('../controller/teacher');


router.post('/registerTeacher', teacherSignin);
router.post('/loginTeacher', teacherSignUp);
router.get('/getSubjByYear', getSubjByCourse);
router.get('/getStudentsBySubject', getStudentsBySubject);
router.post('/takeAttendance', takeAttendance);
router.post('/updateAttendance', updateAttendance);
router.get('/getAttendanceBySubject', getAttendanceBySubject);

module.exports = router;