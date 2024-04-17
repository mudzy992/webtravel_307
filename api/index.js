import Express  from "express";
import authRoutes from "./routes/auth.js"
import userRoutes from "./routes/users.js"
import tripsRoutes from "./routes/trips.js"
import reservationsRoutes from "./routes/reservations.js"
import commentsRoutes from "./routes/comments.js"
import cors from "cors"
import cookieParser from "cookie-parser";


const app = Express()

//middlewares
app.use((req, res, next)=>{
    res.header("Access-Control-Allow-Credentials", true)
    next()
})
app.use(Express.json())
app.use(cors({
    origin: "http://localhost:3000",
}
))
app.use(cookieParser())

app.use("/api/users", userRoutes)
app.use("/api/trips", tripsRoutes)
app.use("/api/comments", commentsRoutes)
app.use("/api/reservations", reservationsRoutes)
app.use("/api/auth", authRoutes)

app.listen(8800, ()=>{
    console.log("API working!!!")
})