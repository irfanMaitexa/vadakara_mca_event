const express = require("express");
const userRoute = express.Router();
const BookEvent = require('../model/bookEventModel');




userRoute.post('/book_event', async (req, res) => {
    try {
        
        const { category, date, address, squarefeet, budget ,loginId,peoplecount} = req.body;


        const newBookEvent =  BookEvent({
            category,
            date,
            address,
            squarefeet,
            budget,
            loginId,
            peoplecount
            
        });
        await newBookEvent.save();
        res.status(201).json({ message: 'BookEvent created successfully', data: newBookEvent });
    } catch (err) {
        console.error('Error creating BookEvent:', err);
        res.status(500).json({ message: 'Failed to create BookEvent' });
    }
});



module.exports =  userRoute;
