const db = require("../config/database.js")


exports.getSubjects = async (req, res) => {

    console.log("Inside Controller - get subjects")

    const { course_id } = req.body

    const quer = `SELECT * FROM subjects WHERE  course_id = ?`;

     db.query(quer, course_id , async (err, response) => {
        
        if (response) {
            return res.status(200).json({ 
                success: true,
                message : "subject fetched successfully",
                data : response 
            })
        }
        else {
            return res.status(203).json({
                success: false,
                message : "subject not fetched",
                data : err
            })
        }
    })
}


exports.getattendance = async (req, res) => {

    console.log("Inside Controller - get attendance")

    const { roll , subject } = req.body

    const quer = `SELECT * FROM attendance WHERE roll= ? AND  subject_id = ? ORDER BY date DESC `;

    db.query(quer, [roll , subject] ,async (err, response) => {

        console.log("Response : ", response)

        if (response) {
            return res.status(200).json({ 
                success: true,
                message : "attendance fetched successfully",
                data : response 
            })
        }
        else {
            return res.status(203).json({
                success: false,
                message : "attendance not fetched",
                data : err
            })
        }
    })
}