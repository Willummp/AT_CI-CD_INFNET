package com.devcalc;

import io.javalin.Javalin;
import io.javalin.http.Context;

public class DevCalcApp {

    private static final CalculatorService calculator = new CalculatorService();

    public static void main(String[] args) {
        Javalin app = Javalin.create().start(7070);

        app.get("/add", ctx -> {
            double a = Double.parseDouble(ctx.queryParam("a"));
            double b = Double.parseDouble(ctx.queryParam("b"));
            ctx.result(String.valueOf(calculator.add(a, b)));
        });

        app.get("/subtract", ctx -> {
            double a = Double.parseDouble(ctx.queryParam("a"));
            double b = Double.parseDouble(ctx.queryParam("b"));
            ctx.result(String.valueOf(calculator.subtract(a, b)));
        });

        app.get("/multiply", ctx -> {
            double a = Double.parseDouble(ctx.queryParam("a"));
            double b = Double.parseDouble(ctx.queryParam("b"));
            ctx.result(String.valueOf(calculator.multiply(a, b)));
        });

        app.get("/divide", ctx -> {
            double a = Double.parseDouble(ctx.queryParam("a"));
            double b = Double.parseDouble(ctx.queryParam("b"));
            try {
                ctx.result(String.valueOf(calculator.divide(a, b)));
            } catch (IllegalArgumentException e) {
                ctx.status(400).result(e.getMessage());
            }
        });
    }
}
