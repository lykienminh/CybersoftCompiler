-- VERSION 2

--DROP DATABASE IF EXISTS db_cybersoft_compiler;
--CREATE DATABASE [db_cybersoft_compiler];

USE db_cybersoft_compiler;
DROP TABLE IF EXISTS init_code;
DROP TABLE IF EXISTS testcase;
DROP TABLE IF EXISTS problem;

CREATE TABLE problem (
	question_id INT PRIMARY KEY,
	question_title VARCHAR(500), 
	problem VARCHAR(1000),
	input_format VARCHAR(500),
	output_format VARCHAR(500),
	explanation VARCHAR(1000),
    constraint_input VARCHAR(500),
    constraint_output VARCHAR(500),
    constraint_time VARCHAR(500),
	sample_input VARCHAR(500),
	sample_output VARCHAR(500),
    _level VARCHAR(50)
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
INSERT INTO problem VALUES (21, 'Unique Number', 'Given an array of integers in which every numbers appears twice except for one, your taks is to find that unique element.', 'array.integer nums', 'Integer', 'For arr = [19, 17, 19, 68, 68], the output should be uniqueNumber(arr) = 17.', 'Guaranteed constraints:
1 ≤ nums.length < 104,
-109 ≤ nums[i] ≤ 109.', 'integer', '1 seconds' ,'[19, 17, 19, 68, 68]', '17', 'easy');

INSERT INTO problem VALUES (22, 'Check Number', 'Given a string s containing characters and numbers, check to see if s is represented as a decimal integer or not. Returns 1 if true, -1 if false.', 'String str', 'Integer', 'For s = "a123"  then checkNumber(s) = false.
Explanation: "a123" cannot be represented as a decimal integer.', 'str.Length ≤ 50', 'Return 1 if s is represented as a decimal integer, -1 otherwise.', '0.5s for C++, 3s for Java and C#, 4s for Python, Go and JavaScript.', '1365', '1', 'easy');

INSERT INTO problem VALUES (23, 'Upper Case', 'Given a string str containing the name of a function, each single word is space-separated. Return the function name according to the UpperCase rule - Every single word must be capitalized first.', 'String str', 'String', 'For str = "hello case" then upper_case(str) = "HelloCase"
For str = "camel case word" then upper_case(str) = "CamelCaseWord"', '0 < str.length ≤ 10^6', 'The function name follows the UpperCase principle', '0.5s for C++, 3s for Java and C#, 4s for  Python, Go and JavaScript.', 'test case', 'TestCase', 'easy');

INSERT INTO problem VALUES (24, 'Check Max', 'Given a string str. Find the character which has the greatest decimal value in str (in ASCII table) and return that decimal value.', 'String str', 'Integer', 'For s1 = "abc", the output should be checkMax(s1)= 99.
Because ''c'' has the greatest decimal value in s1 and the decimal value of ''c'' is 99.', '1 ≤ str.length ≤ 20000', 'The greatest decimal value.', '0.1s for C++, 0.6s for Java, C#, 0.8s for Python, Js, Go', 'abc', '99', 'easy');

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
