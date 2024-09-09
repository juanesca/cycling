import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';

const users = new Map();

export interface User {
    email: string;
    password: string;
}

export const registerUser = async (email: string, password: string): Promise<User> => {
    const hashedPassword = await bcrypt.hash(password, 10);
    const newUser: User = { email, password: hashedPassword };
    users.set(email, newUser);
    return newUser;
};

export const loginUser = async (email: string, password: string): Promise<string | null> => {
    const user = users.get(email);
    if (!user) return null;

    const isPasswordCorrect = await bcrypt.compare(password, user.password);
    if (!isPasswordCorrect) return null;

    const token = jwt.sign({ email }, process.env.JWT_SECRET as string, { expiresIn: '1h' });
    return token;
};

export const generateToken = (email: string): string => {
    return jwt.sign({ email }, process.env.JWT_SECRET as string, { expiresIn: '1h' });
};
