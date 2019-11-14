#include<utility>
#include<iostream>
#include<vector>
#include <random>

#include "../src/Tree/BTree.hpp"

// using namespace ANNA;

void testA()
{
    BTree<int, double, 50> TT;
    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_int_distribution<int> dis(1, 10000);
    for(int i = 1; i<=800; ++i) {
        int ss = dis(gen);
        TT.Insert(std::make_pair(ss * i, ss * i));
    }
    /*
    std::ostream_iterator<double> ooo(std::cout, ", ");
    std::copy(TT.begin(), TT.end(), ooo);
    std::cout << std::endl;
    std::cout << TT.Depth() << std::endl;
    */
    return;
}

int main()
{
    testA();
    return 0;
}
