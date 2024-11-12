package com.example.calculator;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import static org.junit.Assert.assertEquals;

@SpringBootTest
class CalculatorApplicationTest {

	@Test
	void testSum() {
		assertEquals(5, CalculatorService.sum(2,3));
	}

}
