-- VERSION 1
CREATE TABLE problem (
	question_id integer primary key,
	question_title varchar(500), 
	descriptions varchar(5000)
);

CREATE TABLE testcase (
	question_id integer,
	testcase_id integer,
	_input varchar(500),
	_output varchar(1000),
	PRIMARY KEY (question_id, testcase_id),
	FOREIGN KEY (question_id) REFERENCES problem(question_id)
);

CREATE TABLE init_code (
	question_id integer,
	_language varchar(50),
	base_code varchar(10000),
	_function varchar(1000), 
	_answer varchar(5000),
	PRIMARY KEY (question_id, _language),
	FOREIGN KEY (question_id) REFERENCES problem(question_id)
);

-- 21
INSERT INTO problem
VALUES (21, 'Unique Number', 
'Given an array of integers in which every numbers appears twice except for one, your taks is to find that unique element.

Expected : O(n) time, O(1) space

Example:

For arr = [19, 17, 19, 68, 68], the output should be uniqueNumber(arr) = 17.
Input/Output:

[Execution time limit] 1 seconds

[Input] array.integer nums

Guaranteed constraints:
1 ≤ nums.length < 104,
-109 ≤ nums[i] ≤ 109.

[Output] integer'); 

INSERT INTO testcase VALUES (21, 1, '[19, 17, 19, 68, 68]', '17'); 
INSERT INTO testcase VALUES (21, 2, '[34, 76, 76]', '34'); 
INSERT INTO testcase VALUES (21, 3, '[46, 46, 11, 11, 59, 59, 55, 55, 35]', '35'); 
INSERT INTO testcase VALUES (21, 4, '[19, 1, 41, 41, 94, 1, 94, 80, 19]', '80'); 
INSERT INTO testcase VALUES (21, 5, '[86, 51, 51, 72, 57, 57, 78, 78, 86]', '72'); 
INSERT INTO testcase VALUES (21, 6, '[45, 90, 45, 90, 26, 38, 49, 26, 38]', '49'); 

INSERT INTO init_code VALUES (21, 'cpp', 
'#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

__function__

int main() {
    cout << uniqueNumber(__test_case__);
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
INSERT INTO init_code VALUES (21, 'java', 
'import java.io.*;
import java.lang.*;
import java.util.*;

public class Solution {
    public static __function__
    public static void main(String[] args) {
        System.out.println(uniqueNumber(__test_case__));
    }
}', 
'int uniqueNumber(int[] arr) {
}', 
'public static int uniqueNumber(int[] arr) {
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
INSERT INTO init_code VALUES (21, 'js', 
'__function__
console.log(uniqueNumber(__test_case__))', 
'function uniqueNumber(arr) {
}', 
'function uniqueNumber(arr) {
    for (let i = 0; i < arr.length; i++) {
        if (arr.indexOf(arr[i]) == arr.lastIndexOf(arr[i])) return arr[i]
    }
}'); 
INSERT INTO init_code VALUES (21, 'py', 
'__function__
print(uniqueNumber(__test_case__))',
'def uniqueNumber(arr):', 
'def uniqueNumber(arr):
	for x in arr:
		if arr.count(x) == 1:
			return x
'); 

-- 22
INSERT INTO problem
VALUES (22, 'Check Number', 
'Given a string s containing characters and numbers, check to see if s is represented as a decimal integer or not. Returns 1 if true, -1 if false.

Example:

For s = "a123"  then checkNumber(s) = false.
Explanation: "a123" cannot be represented as a decimal integer.
Input/Output:

[Execution time] 0.5s for cpp, 3s for Java and C#, 4s for Python, Go and JavaScript.

[Input]  String s
s.Length ≤ 50

[Output] Integer
Return 1 if s is represented as a decimal integer, -1 otherwise.'); 

INSERT INTO testcase VALUES (22, 1, '1365', '1'); 
INSERT INTO testcase VALUES (22, 2, 'ab2', '-1'); 
INSERT INTO testcase VALUES (22, 3, '123412312441231312413134124', '1'); 

INSERT INTO init_code VALUES (22, 'cpp', 
'#include <iostream>

using namespace std;

__function__

int main() {
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
INSERT INTO init_code VALUES (22, 'java', 
'import java.io.*;
import java.lang.*;
import java.util.*;

public class Solution {
    public static __function__
    public static void main(String[] args) {
        System.out.println(checkNumber(__test_case__));
    }
}', 
'int checkNumber(String s) {
}', 
'int checkNumber(String s) {
    return s.matches("^[-\\d]+$") ?  1 : -1;
}'); 
INSERT INTO init_code VALUES (22, 'js', 
'__function__
console.log(checkNumber(__test_case__))
', 
'function checkNumber(s) {
}', 
'function checkNumber(s) {
    return !Number(s) ? -1 : 1
}'); 
INSERT INTO init_code VALUES (22, 'py', 
'__function__
print(checkNumber(__test_case__))',
'def checkNumber(s):', 
'def checkNumber(s):
	try:
    	float(s)
    	return 1
    except:
    	return -1
');

-- 23
INSERT INTO problem
VALUES (23, 'Upper Case', 
'Given a string str containing the name of a function, each single word is space-separated. Return the function name according to the UpperCase rule - Every single word must be capitalized first.

Example:

For str = "hello case" then upper_case(str) = "HelloCase".
For str = "camel case word" then upper_case(str) = "CamelCaseWord".
Input / Output:

[Execution time] 0.5s for cpp, 3s for Java and C#, 4s for  Python, Go and JavaScript.
[Input] String str
0 < str.length ≤ 10^6

[Output] String
The function name follows the UpperCase principle'); 

INSERT INTO testcase VALUES (23, 1, 'test case', 'TestCase'); 
INSERT INTO testcase VALUES (23, 2, 'camel case method', 'CamelCaseMethod'); 
INSERT INTO testcase VALUES (23, 3, 'say hello', 'SayHello');
INSERT INTO testcase VALUES (23, 4, ' camel case word', 'CamelCaseWord');
INSERT INTO testcase VALUES (23, 5, '', '');

INSERT INTO init_code VALUES (23, 'cpp', 
'#include <iostream>

using namespace std;

__function__

int main(){
    cout << upperCase(__test_case__);
    return 0;
}
', 
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
INSERT INTO init_code VALUES (23, 'java', 
'import java.io.*;
import java.lang.*;
import java.util.*;

public class Solution {
    public static __function__
	public static void main(String[] args) {
		System.out.println(upperCase(__test_case__));
	}
}
', 
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
INSERT INTO init_code VALUES (23, 'js', 
'__function__
console.log(upperCase(__test_case__));
', 
'function upperCase(string) {
}', 
'function upperCase(string) {
    return string
    .replace(/(?:^\w|[A-Z]|\b\w)/g, function (w) {
    return w[0].toUpperCase() + w.slice(1).toLowerCase();
    })
    .replace(/\s+/g, "");
}'); 
INSERT INTO init_code VALUES (23, 'py',
'__function__
print (upper_case(__test_case__))',
'def upper_case(string):', 
'def upper_case(string):
	return string.title().replace('' '', '''')
');

-- 24
INSERT INTO problem
VALUES (24, 'Check Max', 
'Given a string str. Find the character which has the greatest decimal value in str (in ASCII table) and return that decimal value.

Example: 

For s1 = "abc", the output should be checkMax(s1)= 99.
Because ''c'' has the greatest decimal value in s1 and the decimal value of ''c'' is 99.
Input/Output:

[Execution time limit] 0.1s for cpp, 0.6s for Java, C#, 0.8s for Python, Js, Go
[Input] string str
1 ≤ s1.length ≤ 20000
[Output]  integer
The greatest decimal value.'); 

INSERT INTO testcase VALUES (24, 1, 'abc', '99'); 
INSERT INTO testcase VALUES (24, 2, 'fdhfghfgh', '104'); 
INSERT INTO testcase VALUES (24, 3, 'slfjlJKHKJkk', '115'); 

INSERT INTO init_code VALUES (24, 'cpp', 
'#include <iostream>

using namespace std;

__function__

int main() {
    cout << checkMax(__test_case__);
    return 0;
}
', 
'int checkMax(string str) {
}', 
'int checkMax(string str) {
    char answer = str[0];
    for (int i = 1; i < str.size(); i++)
    if (str[i] > answer) answer = str[i];
    return answer;
}'); 
INSERT INTO init_code VALUES (24, 'java', 
'import java.io.*;
import java.lang.*;
import java.util.*;

public class Solution {
    public static __function__
	public static void main(String[] args) {
		System.out.println(checkMax(__test_case__));
	}
}
', 
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
INSERT INTO init_code VALUES (24, 'js', 
'__function__
console.log(checkMax(__test_case__))
', 
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
INSERT INTO init_code VALUES (24, 'py',
'__function__
print(checkMax(__test_case__))', 
'def checkMax(str):',
'def checkMax(str1):
	lst = list(str1)
	ascii = []
	for x in lst:
    	ascii.append(ord(x))
	return max(ascii)
');