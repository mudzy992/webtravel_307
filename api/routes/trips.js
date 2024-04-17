import express from "express";
import { addTrips, deleteTrips, getTrip, getTrips, searchTrips, updateTrips } from "../controllers/trips.js";

const router = express.Router()

router.get("/search/",searchTrips)
router.delete("/:id",deleteTrips)
router.put("/:id",updateTrips)
router.get("/:id",getTrip)
router.get("/",getTrips)
router.post("/",addTrips)

export default router