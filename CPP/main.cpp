//#include <iostream>
//#include <unordered_map>
//
//// exam july 2023 pb2
//// WC O(n^3)
//int main() {
//    int n = 8;
//
//    int a[] = {0, 12, 9, -3, 8, -9, 10, 12, 0};
//    std::unordered_map<int, int> sumPairs;
//    bool found = false;
//
//    // t can start from pos 4
//    for(int t = 4; t <= n; t++)
//        sumPairs[a[t]] = t;
//
//    for(int x = 1; x <= n - 3; x++){
//        for(int y = x + 1; y <= n - 2; y++){
//            for(int z = y + 1; z <= n - 1; z++){
//                long sum = a[x] + a[y] + a[z];
//
//                // the number needed to make the sum 0
//                long nrNeeded = - sum;
//
//                // sumPairs.end() points to something after the last elem of the list
//                // so if it is == to it => not found
//                if(sumPairs.contains(nrNeeded))
//                {
//                    auto &t = sumPairs[nrNeeded];
//                    // check that z < t
//                    if(z < t){
//                        std::cout << x << " " << y << " " << z << " " << t << std::endl;
//                        found = true;
//                        break;
//                    }
//                }
//            }
//
//            if(found) break;
//        }
//
//        if(found) break;
//    }
//
//    if(!found)
//        std::cout << -1 << std::endl;
//
//    return 0;
//}
