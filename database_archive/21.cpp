#include <iostream>
#include <vector>
#include <algorithm>
#include <sstream>
#include <iterator>

using namespace std;

vector<int> handleArrayInput(string input) {
    // remove [] from input format array
    // [1, 2, 3, 4, 5] => 1, 2, 3, 4, 5
    // input = input.substr(1, input.size() - 2);

    vector<int> result;

    stringstream text_stream(input);
    string item;
    while (std::getline(text_stream, item, ',')) {
        result.push_back(stoi(item));
    }

    return result;
}

int uniqueNumber(vector<int> arr) {
    sort(arr.begin(), arr.end());

    for (int i = 0; i < arr.size() - 1; i++) {
        if (arr[i] == arr[i+1]) {
            i++;
        }
        else return arr[i];
    }
    
    return arr[arr.size() - 1];
}

int main(int argc, char** argv) {
    string param = "19, 17, 19, 17, 70";

    cout << uniqueNumber(handleArrayInput(param));

    return 0;
}