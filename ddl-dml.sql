-- VERSION 3

--DROP DATABASE IF EXISTS db_cybersoft_compiler;
--CREATE DATABASE [db_cybersoft_compiler];

USE db_cybersoft_compiler;
DROP TABLE IF EXISTS init_code;
DROP TABLE IF EXISTS testcase;
DROP TABLE IF EXISTS problem;

CREATE TABLE problem (
	question_id INT PRIMARY KEY,
	input_format VARCHAR(500),
	output_format VARCHAR(500),
	sample_input VARCHAR(500),
	sample_output VARCHAR(500),
    _level VARCHAR(50)
);

CREATE TABLE problem_detail (
	question_id INT,
    locale VARCHAR(10),
	question_title VARCHAR(500), 
	problem VARCHAR(1000),
	explanation VARCHAR(1000),
    constraint_input VARCHAR(500),
    constraint_output VARCHAR(500),
    constraint_time VARCHAR(500),
    PRIMARY KEY (question_id, locale),
	FOREIGN KEY (question_id) REFERENCES problem(question_id)
);

CREATE TABLE testcase (
	question_id INT,
	testcase_id INT,
	_input VARCHAR(500),
	_output VARCHAR(1000),
	PRIMARY KEY (question_id, testcase_id),
	FOREIGN KEY (question_id) REFERENCES problem(question_id)
);

CREATE TABLE init_code (
	question_id INT,
	_language VARCHAR(50),
    tle INT,
	base_code VARCHAR(8000),
	_function VARCHAR(1000), 
	_answer VARCHAR(5000),
	PRIMARY KEY (question_id, _language),
	FOREIGN KEY (question_id) REFERENCES problem(question_id)
);

-- INSERT problem
INSERT INTO problem VALUES (21, 'array.integer nums', 'Integer','[19, 17, 19, 68, 68]', '17', 'easy');

INSERT INTO problem VALUES (22, 'String str', 'Integer', '1365', '1', 'easy');

INSERT INTO problem VALUES (23, 'String str', 'String', 'test case', 'TestCase', 'easy');

INSERT INTO problem VALUES (24, 'String str', 'Integer', 'abc', '99', 'easy');

INSERT INTO problem VALUES (72, 'Void', 'Object', '', '{
key1: 1, 
key2: 2, 
akey: "abc", 
bkey: "mno"
}', 'easy');

-- INSERT problem_detail
INSERT INTO problem_detail VALUES (21, 'en', 'Unique Number', 'Given an array of integers in which every numbers appears twice except for one, your taks is to find that unique element.','For arr = [19, 17, 19, 68, 68], the output should be uniqueNumber(arr) = 17.','1 ≤ nums.length < 104
-109 ≤ nums[i] ≤ 109', 'Return an integer.', '1 second');
INSERT INTO problem_detail VALUES (21, 'vi', 'Số duy nhất', 'Cho một mảng gồm nhiều các số nguyên, trong đó tất cả các số đều xuất hiện 2 lần trừ 1 số duy nhất xuất hiện 1 lần. Nhiệm vụ của bạn là tìm số duy nhất xuất hiện 1 lần đó"', 'Với dữ liệu arr = [19, 17, 19, 68, 68], kết quả phải là uniqueNumber (arr) = 17.', '1 ≤ nums.length <104
-109 ≤ num [i] ≤ 109', 'Trả về một số nguyên.', '1 giây');
INSERT INTO problem_detail VALUES (22, 'en', 'Check Number', 'Given a string s containing characters and numbers, check to see if s is represented as a decimal integer or not. Returns 1 if true, -1 if false.', 'For s = "a123" then checkNumber(s) = false.
Explanation: "a123" cannot be represented as a decimal integer.', 'str.Length ≤ 50', 'Return 1 if s is represented as a decimal integer, -1 otherwise.', '0.5 seconds for C++
3 seconds for Java
4 seconds for Python and JavaScript');
INSERT INTO problem_detail VALUES (22, 'vi', 'Kiểm tra số nguyên', 'Cho một chuỗi s gồm các ký tự và số, kiểm tra xem chuỗi s có phải là một chuỗi số nguyên hay không. Trả về 1 nếu true và -1 nếu false', 'Cho chuỗi s = "a123", kết quả trả về là checkNumber(s) = false.
Giải thích: "a123" không thể đại diện cho số nguyên nào do nó có ký tự ''a'' trong đó', 'str.Length ≤ 50', 'Trả về 1 nếu s được biểu thị dưới dạng số nguyên -1 nếu không.', '0,5 giây cho C++
3 giây cho Java
4 giây cho Python và JavaScript');
INSERT INTO problem_detail VALUES (23, 'en', 'Upper Case', 'Given a string str containing the name of a function, each single word is space-separated. Return the function name according to the UpperCase rule - Every single word must be capitalized first.', 'For str = "hello case" then upper_case(str) = "HelloCase"
For str = "camel case word" then upper_case(str) = "CamelCaseWord"', '0 < str.length ≤ 10^6', 'The function name follows the UpperCase principle.', '0.5 seconds for C++
3 seconds for Java
4 seconds for  Python and JavaScript');
INSERT INTO problem_detail VALUES (23, 'vi', 'Upper Case - In hoa đầu từ', 'Cho một chuỗi str chứa tên của một hàm, mỗi từ được phân tách bằng dấu cách. Trả về tên hàm theo quy tắc UpperCase - mỗi ký tự đầu tiên của mỗi từ phải in hoa.', 'Đối với chuỗi str = "hello case" kết quả là upper_case(str) = "HelloCase"
Đối với chuỗi str = "camel case word" kết quả là upper_case(str) = "CamelCaseWord"', '0 <str.length ≤ 10 ^ 6', 'Chuỗi được viết theo nguyên tắc in hoa đầu từ UpperCase.', '0,5 giây cho C++
3 giây cho Java
4 giây cho Python và JavaScript');
INSERT INTO problem_detail VALUES (24, 'en', 'Check Max', 'Given a string str. Find the character which has the greatest decimal value in str (in ASCII table) and return that decimal value.', 'For s1 = "abc", the output should be checkMax(s1)= 99.
Because ''c'' has the greatest decimal value in s1 and the decimal value of ''c'' is 99.', '1 ≤ str.length ≤ 20000', 'Return the greatest decimal value.', '0.1 seconds for C++
0.6 seconds for Java
0.8 seconds for Python and JavaScript');
INSERT INTO problem_detail VALUES (24, 'vi', 'Tìm phần tử lớn nhất', 'Cho một chuỗi str. Tìm ký tự có giá trị thập phân lớn nhất (trong bảng ASCII) trong chuỗi str đó và trả về giá trị thập phân đó.', 'Đối với s1 = "abc", đầu ra phải là checkMax (s1) = 99.
Bởi vì ''c'' có giá trị thập phân lớn nhất trong chuỗi s1 và giá trị thập phân của ''c'' (trong bảng ASCII) là 99.', '1 ≤ str.length ≤ 20000', 'Trả về giá trị thập phân lớn nhất (trong bảng ASCII).', '0,1 giây cho C++
0,6 giây cho Java
0,8 giây cho Python và JavaScript');
INSERT INTO problem_detail VALUES (72, 'en', 'Object', 'Create object with key: key1, key2, akey, bkey. And data is 1, 2, "abc", "mno"', 'Return object example {
key1: 1,
key2: 2,
akey: "abc",
bkey: "mno"
}', '', 'Return object with any order of key', '');
INSERT INTO problem_detail VALUES (72, 'vi', 'Object', 'Khởi tạo 1 object với key: key1, key2, akey, bkey. Và có giá trị lần lượt là 1, 2, "abc", "mno"', 'Ví dụ trả về 1 Object như sau {
key1: 1,
key2: 2,
akey: "abc", 
bkey: "mno"
}', '', 'Trả về object với thứ tự của key bất kỳ', '');

-- INSERT testcase
INSERT INTO testcase VALUES (21, 1, '[19, 17, 19, 68, 68]', '17'); 
INSERT INTO testcase VALUES (21, 2, '[34, 76, 76]', '34'); 
INSERT INTO testcase VALUES (21, 3, '[46, 46, 11, 11, 59, 59, 55, 55, 35]', '35'); 
INSERT INTO testcase VALUES (21, 4, '[19, 1, 41, 41, 94, 1, 94, 80, 19]', '80'); 
INSERT INTO testcase VALUES (21, 5, '[86, 51, 51, 72, 57, 57, 78, 78, 86]', '72'); 
INSERT INTO testcase VALUES (21, 6, '[45, 90, 45, 90, 26, 38, 49, 26, 38]', '49'); 

INSERT INTO testcase VALUES (22, 1, '1365', '1'); 
INSERT INTO testcase VALUES (22, 2, 'ab2', '-1'); 
INSERT INTO testcase VALUES (22, 3, '123412312441231312413134124', '1'); 

INSERT INTO testcase VALUES (23, 1, 'test case', 'TestCase'); 
INSERT INTO testcase VALUES (23, 2, 'camel case method', 'CamelCaseMethod'); 
INSERT INTO testcase VALUES (23, 3, 'say hello', 'SayHello');
INSERT INTO testcase VALUES (23, 4, ' camel case word', 'CamelCaseWord');
INSERT INTO testcase VALUES (23, 5, '', '');

INSERT INTO testcase VALUES (24, 1, 'abc', '99'); 
INSERT INTO testcase VALUES (24, 2, 'fdhfghfgh', '104'); 
INSERT INTO testcase VALUES (24, 3, 'slfjlJKHKJkk', '115');

INSERT INTO testcase VALUES (72, 1, '', '{
"key1": 1, 
"key2": 2, 
"akey": "abc", 
"bkey": "mno"
}');
INSERT INTO testcase VALUES (72, 2, '', '{"key1": 1, 
"bkey": "mno",
"key2": 2, 
"akey": "abc"}');
INSERT INTO testcase VALUES (72, 3, '', '{
"bkey": "mno",
"akey": "abc",
"key2": 2,
"key1": 1
}');

-- INSERT init_code
--QUESTION 21
INSERT INTO init_code VALUES (21, 'cpp', 1000,  
'#include <iostream>
#include <vector>
#include <algorithm>
#include <sstream>
#include <iterator>

using namespace std;

vector<int> handleArrayInput(string input) {
    vector<int> result;

    stringstream text_stream(input);
    string item;
    while (std::getline(text_stream, item, '','')) {
        result.push_back(stoi(item));
    }

    return result;
}

__function__

int main(int argc, char** argv) {
    string param = __test_case__;

    cout << uniqueNumber(handleArrayInput(param));

    return 0;
}', 
'int uniqueNumber(vector<int> arr) {
}', 
'int uniqueNumber(vector<int> arr) {
    sort(arr.begin(), arr.end());
    for (int i = 0; i < arr.size() - 1; i++) {
        if (arr[i] == arr[i+1]) {
            i++;
        }
        else return arr[i];
    }
}'); 
INSERT INTO init_code VALUES (21, 'java', 1000, 
'import java.io.*;
import java.lang.*;
import java.util.*;

public class Solution {
    public static __function__
    public static void main(String[] args) {
        int[] param = {__test_case__};
        System.out.println(uniqueNumber(param));
    }
}', 
'int uniqueNumber(int[] arr) {
}', 
'int uniqueNumber(int[] arr) {
	Arrays.sort(arr);
	int result = 0;
	for(int i = 0; i < arr.length; i += 2) {
		if (arr[i] != arr[i + 1]) {
			result = arr[i];
			break;
		}
	}
	return result;
}'); 
INSERT INTO init_code VALUES (21, 'js', 1000, 
'__function__
console.log(uniqueNumber([__test_case__]))', 
'function uniqueNumber(arr) {
}', 
'function uniqueNumber(arr) {
    for (let i = 0; i < arr.length; i++) {
        if (arr.indexOf(arr[i]) == arr.lastIndexOf(arr[i])) return arr[i]
    }
}'); 
INSERT INTO init_code VALUES (21, 'py', 1000, 
'__function__
print(uniqueNumber([__test_case__]))',
'def uniqueNumber(arr):', 
'def uniqueNumber(arr):
	for x in arr:
		if arr.count(x) == 1:
			return x'); 
--QUESTION 22
INSERT INTO init_code VALUES (22, 'cpp', 500, 
'#include <iostream>

using namespace std;

__function__

int main(int argc, char** argv) {
    cout << checkNumber(__test_case__);
    return 0;
}', 
'int checkNumber(string s) {
}', 
'int checkNumber(string s) {
    if (s == "") return -1;
    if (s[0] == ''-'') {
        for (int i = 1; i < s.size(); i++) {
            if (!isdigit(s[i])) return -1;
        }
        return 1;
    }
    else {
        for (char c : s) {
            if (!isdigit(c)) return -1;
        }
        return 1;
    }
}'); 
INSERT INTO init_code VALUES (22, 'java', 3000, 
'import java.io.*;
import java.lang.*;
import java.util.*;

public class Solution {
    public static __function__
    public static void main(String[] args) {
        System.out.println(checkNumber("__test_case__"));
    }
}', 
'int checkNumber(String s) {
}', 
'int checkNumber(String s) {
    return s.matches("^[-\\d]+$") ?  1 : -1;
}'); 
INSERT INTO init_code VALUES (22, 'js', 4000, 
'__function__
console.log(checkNumber("__test_case__"))', 
'function checkNumber(s) {
}', 
'function checkNumber(s) {
    return !Number(s) ? -1 : 1
}'); 
INSERT INTO init_code VALUES (22, 'py', 4000, 
'__function__
print(checkNumber("__test_case__"))',
'def checkNumber(s):', 
'def checkNumber(s):
    try:
    	float(s)
    	return 1
    except:
        return -1');
--QUESTION 23
INSERT INTO init_code VALUES (23, 'cpp', 500, 
'#include <iostream>

using namespace std;

__function__

int main(int argc, char** argv){
    cout << upperCase(__test_case__);
    return 0;
}', 
'string upperCase(string string) {
}', 
'string upperCase(string strings) {
    string str = "";
    if(islower(strings[0])) str += toupper(strings[0]);
    for(int i = 1; i < strings.length(); i++){
        if(strings[i] == '' '') continue;
        else if(strings[i-1] == '' '' && islower(strings[i]))
        	str += toupper(strings[i]);
        else str += strings[i];
    }
    return str;
}'); 
INSERT INTO init_code VALUES (23, 'java', 3000, 
'import java.io.*;
import java.lang.*;
import java.util.*;

public class Solution {
    public static __function__
	public static void main(String[] args) {
		System.out.println(upperCase("__test_case__"));
	}
}', 
'String upperCase(String string) {
}', 
'String upperCase(String string) {
	string = string.trim();
	if(string.isEmpty()) return string;
	String[] arr = string.split(" ");
	String result = "";
	for(int i = 0; i < arr.length; i++) {
		arr[i] = arr[i].substring(0,1).toUpperCase() + arr[i].substring(1).toLowerCase();
		result += arr[i];
	}
	return result;
}'); 
INSERT INTO init_code VALUES (23, 'js', 4000, 
'__function__
console.log(upperCase("__test_case__"));', 
'function upperCase(string) {
}', 
'function upperCase(string) {
    return string
    .replace(/(?:^\w|[A-Z]|\b\w)/g, function (w) {
    return w[0].toUpperCase() + w.slice(1).toLowerCase();
    })
    .replace(/\s+/g, "");
}'); 
INSERT INTO init_code VALUES (23, 'py', 4000, 
'__function__
print (upper_case("__test_case__"))',
'def upper_case(string):', 
'def upper_case(string):
	return string.title().replace('' '', '''')');
--QUESTION 24
INSERT INTO init_code VALUES (24, 'cpp', 100, 
'#include <iostream>

using namespace std;

__function__

int main(int argc, char** argv) {
    cout << checkMax(__test_case__);
    return 0;
}', 
'int checkMax(string str) {
}', 
'int checkMax(string str) {
    char answer = str[0];
    for (int i = 1; i < str.size(); i++)
    if (str[i] > answer) answer = str[i];
    return answer;
}'); 
INSERT INTO init_code VALUES (24, 'java', 600, 
'import java.io.*;
import java.lang.*;
import java.util.*;

public class Solution {
    public static __function__
	public static void main(String[] args) {
		System.out.println(checkMax("__test_case__"));
	}
}', 
'int checkMax(String str) {
}', 
'int checkMax(String str) {
	char max = str.charAt(0);
	for (int i = 1; i < str.length(); i++) {
		if (str.charAt(i) > max) {
			max = str.charAt(i);
		}
	}
	return (int)max;
}'); 
INSERT INTO init_code VALUES (24, 'js', 800, 
'__function__
console.log(checkMax("__test_case__"))', 
'function checkMax(str) {
}', 
'function checkMax(str) {
    let max = str.charCodeAt(0);
    for (let i = 1; i < str.length; i++) {
        if (str.charCodeAt(i) > max) {
            max = str.charCodeAt(i);
        }
    }
    return max;
}'); 
INSERT INTO init_code VALUES (24, 'py', 800, 
'__function__
print(checkMax("__test_case__"))', 
'def checkMax(str):',
'def checkMax(str1):
	lst = list(str1)
	ascii = []
	for x in lst:
    	ascii.append(ord(x))
	return max(ascii)');
--QUESTION 71
INSERT INTO init_code VALUES (72, 'js', 800, 
'__function__    
console.log(JSON.stringify(createObject()))', 
'function createObject () {
}', 
'function createObject () {
    const object = {
        "key1": 1, 
        "key2": 2, 
        "akey": "abc",
        "bkey": "mno"
    }
    return object
}');