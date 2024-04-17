import express from "express";
import { getComment, deleteComment, addComment, getCommentsByTripId } from "../controllers/comments.js";

const router = express.Router()

router.get("/",getComment)
router.delete('/:id/:id',deleteComment)
router.post("/:id", addComment);
router.get("/:id", getCommentsByTripId);


export default router