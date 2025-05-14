const db = require('../config/database')

exports.getSubjByCourse = async (req, res) => {

    console.log("Inside Controller - subject ")

    const { teacher_id } = req.body;

    const quer = `SELECT * FROM subjects WHERE  teacher_id= ? `;


    db.query(quer, teacher_id, async (err, response) => {

        if (response) {
            return res.status(200).json({
                success: true,
                message: "subject fetched successfully",
                data: response
            })
        }
        else {
            return res.status(203).json({
                success: false,
                message: "subject not fetched",
                data: err
            })
        }
    })
}

exports.getStudentsBySubject = async (req, res) => {

    console.log("Inside Controller - get students by subject")

    const { course_id } = req.body;

    const quer = `SELECT * FROM student WHERE  course_id = ? ORDER BY roll ASC`;

    db.query(quer, course_id, async (err, response) => {

        console.log("Response : ", response);
        if (response) {
            return res.status(200).json({
                success: true,
                message: "student fetched successfully",
                data: response
            })
        }
        else {
            return res.status(203).json({
                success: false,
                message: "student not fetched",
                data: err
            })
        }
    })
}


exports.getAttendance = async (req, res) => {

    console.log("Inside Controller - get attendance by subject")

    const { student_id } = req.body;

    const quer = `SELECT roll , name , id , date , status  FROM student , attendance WHERE subject_id = ? AND student.roll = attendance.roll ORDER BY date DESC`;

    db.query(quer, student_id, async (err, response) => {

        console.log("Response : ", response);

        if (response) {
            return res.status(200).json({
                success: true,
                message: "attendance fetched successfully",
                data: response
            })
        }
        else {
            return res.status(203).json({
                success: false,
                message: "attendance not fetched",
                data: err
            })
        }
    })
}


exports.takeAttendance = async (req, res) => {

    console.log("Inside Controller - take attendance by subject")

    const { attendance, subject_id, teacher_id, date } = req.body;

    const quer = `SELECT * FROM attendance WHERE subject_id = ? AND roll = ? AND date = ? `;

    db.query(quer, [subject_id, attendance[0].roll, date], async (err, response) => {

        console.log("Response : ", response);

        if (response) {
            return res.status(200).json({
                success: true,
                message: "attendance already take for this date ",
                data: response
            })
        }
        else {

            const quer = `INSERT INTO attendance (roll , subject_id , teacher_id , date , status) VALUES ?`;

            const values = attendance.map((item) => [item.roll, subject_id, teacher_id, date, item.status]);

            db.query(quer, [values], async (err, response) => {
                if (response) {
                    return res.status(200).json({
                        success: true,
                        message: "attendance taken successfully",
                        data: response
                    })
                }
                else {
                    return res.status(203).json({
                        success: false,
                        message: "attendance not taken",
                        data: err
                    })
                }
            })


        }
    })
}


exports.updateAttendance = async (req, res) => {

    console.log("Inside Controller - update attendance")

    const { id, status } = req.body;


    var quer = `UPDATE attendance SET status=? WHERE id= ?`;

    db.query(quer, [status, id], async (err, response) => {

        console.log("Response : ", response);
        
        if (response) {
            return res.status(200).json({
                success: true,
                message: "attendance taken successfully",
                data: response
            })
        }
        else {
            return res.status(203).json({
                success: false,
                message: "attendance not taken",
                data: err
            })
        }
    })
}


