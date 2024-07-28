import { Router } from "express"
import { deleteReport, generateReport, getReports } from "../controllers/report_controller.js"

const router = Router()

router.get("/reports", getReports)

router.post("/reports", generateReport)

router.delete("/reports/:id", deleteReport)

export default router