import jwt from "jsonwebtoken";
import { db } from "../connect.js";

export const getReservations = (req,res) => {
    const { id } = req.params;

    const q =  "select t.id as tripId, u.id as userId, u.username, t.titleTrip, t.tripDate from reservations r join trips t on t.id = r.tripId join users u on u.id = r.userId WHERE u.id= ? and t.tripDate < NOW()";

    db.query(q,[req.params.id],(err,data)=>{
      if(err) return res.json(err);

      return res.status(200).json(data);
    });
}


export const addReservation = (req, res) => {

    const token = req.cookies.access_token
    if(!token) return res.status(401).json("Not authentificated!")

    jwt.verify(token,"secretkey", (err, userInfo)=>{
      if(err) return res.status(403).json("Token nije ispravan!")
      if (userInfo.isAdmin) return res.status(403).json("Don't have permission for this operation!");


    const { userId, tripId, date } = req.body;
  
    
    const q = "INSERT INTO reservations(`userId`, `tripId`, `date`) VALUES (?)";
    
    const values = [userId, tripId, date];
  
  
      db.query(q,[values],(err,data)=>{
        if(err) return res.status(500).json(err)

        return res.json("Reservation created!");
    })
    })
    
  };


export const deleteReservation = (req,res) => {

      const tripId = req.params.id
      const userInfo = req.params.userId
      
      const q = "DELETE FROM reservations WHERE `id` = ?";

       db.query(q,[tripId, userInfo], (err, data) =>{
           if(err) return res.status(403).json("Don't have permission for this operation!")
      
          return res.json("Reservation deleted!")
       })
}