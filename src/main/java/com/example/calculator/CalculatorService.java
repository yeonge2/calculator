package com.example.calculator;

import org.springframework.stereotype.Service;

@Service
public class CalculatorService {

    public static int sum(int a, int b) {
        return a + b;
    }
}

