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

INSERT INTO init_code VALUES (21, 'cpp', 'head', 
'int uniqueNumber(std::vector<int> arr){
}', ''); 
INSERT INTO init_code VALUES (21, 'java', 'head', 
'int uniqueNumber(int[] arr) {
}', ''); 
INSERT INTO init_code VALUES (21, 'js', 'head', 
'function uniqueNumber(arr){
}', ''); 
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

INSERT INTO init_code VALUES (22, 'cpp', 'head', 
'int checkNumber(string s)
{
}', ''); 
INSERT INTO init_code VALUES (22, 'java', 'head', 
'int checkNumber(String s) {
}', ''); 
INSERT INTO init_code VALUES (22, 'js', 'head', 
'function checkNumber(s){
}', ''); 
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

INSERT INTO init_code VALUES (23, 'cpp', 'head', 
'string upperCase(string string)
{
}', ''); 
INSERT INTO init_code VALUES (23, 'java', 'head', 
'String upperCase(String string) {
}', ''); 
INSERT INTO init_code VALUES (23, 'js', 'head', 
'function upperCase(string){
}', ''); 
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

INSERT INTO init_code VALUES (24, 'cpp', 'head', 
'int checkMax(string str)
{
}', ''); 
INSERT INTO init_code VALUES (24, 'java', 'head', 
'int checkMax(String str) {
}', ''); 
INSERT INTO init_code VALUES (24, 'js', 'head', 
'function checkMax(str){
}', ''); 
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
































































































-- VERSION 0
-- DROP DATABASE IF EXISTS code-learn-db;
-- CREATE DATABASE code-learn-db

CREATE TABLE problem (
	question_id integer primary key,
	question_title varchar(500), 
	descriptions varchar(1000), 
	init_cpp varchar(1000), 
	init_py varchar(1000), 
	init_java varchar(1000), 
	init_js varchar(1000), 
	testcase_input_1 varchar(10), 
	testcase_output_1 varchar(1000), 
	testcase_input_2 varchar(10), 
	testcase_output_2 varchar(1000)
);

INSERT INTO problem
VALUES (11, "Closest Perfect Square", 
"You are given a positive integer 'N'. You are required to print the perfect square number closest to the 'N' and the number of steps required to reach that number.
For Example:
N = 21
The perfect square closest to 21 is 25, and the distance is 4. 
Input Format:
The first line contains a single integer 'T' denoting the number of test cases to be run. Then the test cases follow.

The first line of each test case contains a positive integer 'N' denoting the given number.
Output Format:
For each test case, You have to return a list of two integers such that the first number denotes the closest perfect square number, and the second number denotes its distance from 'N'.

Output for each test case will be printed in a separate line.
Note
You are not required to print anything; it has already been taken care of. Just implement the function.
Constraints:
1 <= T <= 50
1 <= N <= 10^9

Time Limit: 1 sec.
Sample Input 1:
2
21
5
Sample Output 1:
25 4
4 1
Explanation For Sample Output 1:
For test case one-
25 is the perfect square nearest to 21 and at a distance of 4.

For test case two-
4 is the perfect square nearest to 5 and at a distance of 1.",

"vector<int> closestPerfectSquare(int n){
    // Write your code here.
}",

"def closestPerfectSquare(n):
    # Write your code here.
",

"public class Solution {
    public static int[] closestPerfectSquare(int n) {
        // Write your code here.
    }
}",

"public class Solution {
    public static int[] closestPerfectSquare(int n) {
        // Write your code here.
    }
}",

"2
21
5","25 4\n4 1",

"2
132
146", "121 11\n144 2");

INSERT INTO problem
VALUES (12, "Ninja And Alternating Largest", 
"Ninja is given a few numbers, and he is being asked to rearrange the numbers so that every second element is greater than its left and right element.
Suppose the given array is [1, 2, 3, 4, 5] then the rearranged array can be [1, 3, 2, 5, 4].
Input Format:
The first line of input contains a single integer T, representing the number of test cases.

The first line of each test case contains 'N', denoting the number of elements in the array.

The second line of each test case contains the array elements.
Output Format :
The first and only line of each test case in the output contains 1 if the array satisfies the conditions mentioned.
Note:
If the array returned is the rearranged array following all the conditions, then it will print 1 else it will print 0.
You are not required to print the expected output; it has already been taken care of. Just implement the function. 
Constraints:
1 <= T <= 10    
1 <= N <= 10^4
0 <= array[i] <= 10^5     

Time limit: 1 sec
Sample Input 1:
2
7
1 2 3 4 5 6 7
4
8 2 4 6
Sample Output 1:
1 
1
Explanation For Sample Output 1:
In the first test case,  [1, 3, 2, 5, 4, 7, 6] is one possible answer. The reason is every second element of the array is greater than its left and right element. So on returning this 1 is the output.

In the second test case,  [2, 8, 4, 6] is one possible answer. The reason is every second element of the array is greater than its left and right element. So on returning this 1 is the output.",

"vector <int> alternateNumbers(vector <int> arr) {

  // Write your code here

}",

"def alternateNumbers(arr):

    # Write your Code here.
    # Return an array of integers denoting the answer
    pass
",

"import java.util.ArrayList;

public class Solution {

	public static ArrayList<Integer> alternateNumbers(ArrayList<Integer> arr) {

		// Write your code here

	}
}",

"import java.util.ArrayList;

public class Solution {

	public static ArrayList<Integer> alternateNumbers(ArrayList<Integer> arr) {

		// Write your code here

	}
}",

"2
7
1 2 3 4 5 6 7
4
8 2 4 6","1\n1",

"2
6
9 7 1 2 9 6
3
3 2 1
", "1\n1");

INSERT INTO problem
VALUES (13, "Set Matrix Zeros", 
"Given an 'N' x 'M' integer matrix, if an element is 0, set its entire row and column to 0's, and return the matrix. In particular, your task is to modify it in such a way that if a cell has a value 0 (matrix[i][j] == 0), then all the cells of the ith row and jth column should be changed to 0.
You must do it in place.
For Example:
If the given grid is this:
[7, 19, 3]
[4, 21, 0]

Then the modified grid will be:
[7, 19, 0]
[0, 0,  0]
Input Format:
The first line of the input contains a single integer 'T' representing the no. of test cases.

The first line of each test case contains two space-separated integers 'N' and 'M', denoting the no. of the rows and columns of the matrix.

The next 'N' lines will contain 'M' space separated integers representing the elements of the matrix.
Output Format:
For each test case, print the modified grid.

Print output of each test case in a separate line.
Note:
You are not required to print anything; it has already been taken care of. Just implement the function and return the answer.
Constraints:
1 ≤ T ≤ 1000
1 ≤ m, n ≤ 1000
Σ(m * n) ≤ 2000000
-2^(31) ≤ matrix[i][j] ≤ 2^(31)-1, for all (1 ≤ i ≤ n and 1 ≤ j ≤ m).

Time Limit: 1 sec
Follow up:
Can we do better than O(m * n) space?
Using O(m + n) space is an improvement but we can still do better.
We can do it using constant memory. Can you do it?
Sample Input 1 :
2
2 3
7 19 3
4 21 0
3 3
1 2 3
4 0 6
7 8 9
Sample Output 1 :
7 19 0
0 0 0
1 0 3
0 0 0
7 0 9
Explanation For Sample Input 1 :
For First Case - Similar to the example explained above. 

For Second Case - 
Only the cell (2,2) has zero. So all the elements of the second row and second column are changed to zeros.",

"void setZeros(vector<vector<int>> &matrix)
{
	// Write your code here.
}",

"from typing import List

def setZeros(matrix: List[List[int]]) -> None:
	# Write your code here.
    pass",

"public class Solution {
    public static void setZeros(int matrix[][]) {
        // Write your code here..
    }

}",

"public class Solution {
    public static void setZeros(int matrix[][]) {
        // Write your code here..
    }

}",

"2
2 3
7 19 3
4 21 0
3 3
1 2 3
4 0 6
7 8 9",

"7 19 0
0 0 0
1 0 3
0 0 0
7 0 9",

"2
4 2
1 0
2 7
3 0
4 8
3 3
0 2 3
1 0 3
1 2 0", 

"0 0
2 0
0 0
4 0
0 0 0
0 0 0
0 0 0");

INSERT INTO problem
VALUES (14, "Maximum Consecutive Ones", 
"You are given an array 'ARR' of length 'N' consisting of only '0's and '1's. Your task is to determine the maximum length of the consecutive number of 1's.
For Example:
ARR = [0, 1, 1, 0, 0, 1, 1, 1], here you can see the maximum length of consecutive 1's is 3. Hence the answer is 3.
Input Format:
The first input line contains a single integer 'T',  representing the number of test cases.

The first line of each test case contains a single integer 'N', representing the array's length.

The second line of each test case contains N space-separated integers representing the elements of the array.
Output Format:
For each test case, print a single integer representing the maximum length of consecutive 1's in the array.

Output for each test case will be printed on a separate line.
Constraints:
1 ≤ T ≤ 10
1 ≤ N ≤ 1000
ARR[i] = {0, 1}

Time Limit: 1 sec
Note :
You do not need to print anything. It has already been taken care of. Just implement the given function. 
Sample Input 1:
2
8
0 1 1 0 0 1 1 1
4
0 1 1 0
Sample Output 1:
3
2
Explanation For Sample Output 1:
For the first test case, 'ARR' = [0, 1, 1, 0, 0, 1, 1, 1], here you can see the maximum length of consecutive 1's is 3 when we select ARR[5], ARR[6] and ARR[7]. Hence the answer is 3.

For the second test, 'ARR' = [0, 1, 1, 0], here you can see the maximum length of consecutive 1's is 2 when we select ARR[1] and ARR[2]. Hence the answer is 2.",

"int consecutiveOnes(vector<int>& arr){
    //Write your code here.
}",

"from typing import List


def consecutiveOnes(arr: List[int]) -> int:
    # Write your code here.
    pass
",

"public class Solution {
	public static int consecutiveOnes(int n, int[] arr) {
		// Write your code here.
	}
}",

"public class Solution {
	public static int consecutiveOnes(int n, int[] arr) {
		// Write your code here.
	}
}",

"2
8
0 1 1 0 0 1 1 1
4
0 1 1 0","3\n2",

"2
6
1 1 1 1 0 0
4
1 1 1 1", "4\n4");