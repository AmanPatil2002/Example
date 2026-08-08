const express = require('express');
require('dotenv').config();
const cors = require('cors');
const path = require('path');

const app = express()
const authRoutes = require("./routes/authRoutes");
const questionRoutes = require("./routes/questionRoutes");
const profileRoutes = require("./routes/profileRoutes");
const reviewRoutes = require("./routes/reviewRoutes");
const storyRoutes = require('./routes/storiesRoutes');
const contactRoutes = require('./routes/contactRoutes');
const queryRoutes = require('./routes/queryRoutes');

const PORT = process.env.PORT || 5000;

app.use(cors())
app.use(express.json())
app.use(express.urlencoded({ extended: true }));


app.use('/uploads', express.static(path.join(__dirname, 'uploads')));


app.use('/auth', authRoutes)
app.use('/questions',questionRoutes)
app.use('/contact',contactRoutes)
app.use('/profile',profileRoutes)
app.use('/api',reviewRoutes)
app.use('/success',storyRoutes)
app.use('/api/query',queryRoutes)


const fs = require('fs');

const uploadsDir = path.join(__dirname, 'uploads');
if (!fs.existsSync(uploadsDir)) {
  fs.mkdirSync(uploadsDir, { recursive: true });
}

app.listen(PORT , ()=>{
    console.log(`Server is running on ${PORT}`)
})
