package cl.iplacex.qa;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

class CalculatorTest {
    private final Calculator calculator = new Calculator();

    @Test
    void shouldAddTwoNumbers() {
        assertEquals(7, calculator.sum(3, 4));
    }

    @Test
    void shouldSubtractTwoNumbers() {
        assertEquals(5, calculator.subtract(9, 4));
    }
}
