package com.devcalc;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class CalculatorServiceTest {

  private final CalculatorService calculator = new CalculatorService();

  @Test
  void testAdd() {
    assertEquals(15.0, calculator.add(10, 5));
  }

  @Test
  void testSubtract() {
    assertEquals(5.0, calculator.subtract(10, 5));
  }

  @Test
  void testMultiply() {
    assertEquals(50.0, calculator.multiply(10, 5));
  }

  @Test
  void testDivide() {
    assertEquals(2.0, calculator.divide(10, 5));
  }

  @Test
  void testDivideByZero() {
    assertThrows(IllegalArgumentException.class, () -> calculator.divide(10, 0));
  }
}
