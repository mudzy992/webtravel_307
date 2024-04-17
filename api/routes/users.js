import express from "express";
import { deleteUser, getUser, updateUser, updateUserPassword, getUsers } from "../controllers/user.js";

const router = express.Router()

router.get("/:id",getUser)
router.get("/", getUsers);
router.delete("/:id",deleteUser)
router.post("/:id",updateUser);
router.put("/password-change/:id",updateUserPassword);

export default router