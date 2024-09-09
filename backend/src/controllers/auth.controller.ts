import { Request, Response } from 'express';
import { registerUser, loginUser } from '../services/auth.services';
import { validationResult } from 'express-validator';

export const register = async (req: Request, res: Response) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) return res.status(400).json({ errors: errors.array() });

    const { email, password } = req.body;
    try {
        const user = await registerUser(email, password);
        return res.status(201).json({ message: 'User registered', user });
    } catch (error) {
        return res.status(500).json({ message: 'Error registering user' });
    }
};

export const login = async (req: Request, res: Response) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) return res.status(400).json({ errors: errors.array() });

    const { email, password } = req.body;
    try {
        const token = await loginUser(email, password);
        if (!token) return res.status(400).json({ message: 'Invalid credentials' });
        return res.json({ token });
    } catch (error) {
        return res.status(500).json({ message: 'Error logging in' });
    }
};
