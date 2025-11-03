// unit_tests.cpp
#include "../math_operations.h"
#include <gtest/gtest.h>

// Тест для додавання двох позитивних чисел
TEST(AdditionTests, PositiveNumbers) {
    EXPECT_EQ(add(3, 5), 8);
}

// Тест для додавання від'ємних чисел
TEST(AdditionTests, NegativeNumbers) {
    EXPECT_EQ(add(-3, -5), -8);
}

// Тест для додавання нуля
TEST(AdditionTests, AddingZero) {
    EXPECT_EQ(add(0, 5), 5);
    EXPECT_EQ(add(5, 0), 5);
}

// Тест для додавання великого числа
TEST(AdditionTests, LargeNumbers) {
    EXPECT_EQ(add(1000000, 2000000), 3000000);
}

// Основна функція для запуску тестів
int main(int argc, char **argv) {
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}