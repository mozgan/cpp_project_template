#ifndef _TEST_H_
#define _TEST_H_

#include <gtest/gtest.h>

#include <iostream>

class FooTest : public testing::Test {
 public:
  FooTest() { std::cout << "FooTest : c-tor" << std::endl; }
  ~FooTest() override { std::cout << "FooTest : d-tor" << std::endl; }

  void SetUp() override { std::cout << "FooTest : SetUp" << std::endl; }
  void TearDown() override { std::cout << "FooTest : TearDown" << std::endl; }

 protected:
 private:
};

#endif