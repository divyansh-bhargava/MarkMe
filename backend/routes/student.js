const router = require("express").Router();

const {studentSignUP , studentSignIn , getSubjects , getattendance } = require("../controller/student")

router.post('/registerStudent', studentSignUP);
router.post('/loginStudent', studentSignIn);
router.get('/getSubjects', getSubjects);
router.get('/getattendance', getattendance);

module.exports=router;