import { Router } from 'express';
import { register, login } from '../controllers/auth.controller';
import { check } from 'express-validator';

const router = Router();

router.post(
    '/register',
    [
        check('email', 'Please include a valid email').isEmail(),
        check('password', 'Password is required and must be 6 or more characters').isLength({ min: 6 }),
    ],
    register
);

router.post(
    '/login',
    [
        check('email', 'Please include a valid email').isEmail(),
        check('password', 'Password is required').exists(),
    ],
    login
);

export default router;
