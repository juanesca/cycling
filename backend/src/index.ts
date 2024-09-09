import express, {Request, Response} from 'express';
import * as process from "node:process";
import dotenv from 'dotenv';
import authRoutes from "./routes/auth.routes";

const app = express();

dotenv.config();


app.use(express.json());

const port = process.env.PORT || 3000;

app.use('/api/auth', authRoutes);

app.listen(port, () => {
    console.log('Hi');
})