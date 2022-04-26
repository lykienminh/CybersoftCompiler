function object_equals(x, y) {
    if (x === y) return true;
    // if both x and y are null or undefined and exactly the same

    if ( !(x instanceof Object) || !(y instanceof Object) ) return false;
    // if they are not strictly equal, they both need to be Objects

    if (x.constructor !== y.constructor) return false;
    // they must have the exact same prototype chain, the closest we can do is
    // test there constructor.

    for (var p in x) {
        if ( !x.hasOwnProperty(p) ) continue;
        // other properties were tested using x.constructor === y.constructor
    
        if ( !y.hasOwnProperty(p) ) return false;
        // allows to compare x[ p ] and y[ p ] when set to undefined
    
        if ( x[p] === y[p] ) continue;
        // if they have the same strict value or identity then they are equal
    
        if ( typeof(x[p]) !== "object" ) return false;
        // Numbers, Strings, Functions, Booleans must be strictly equal
    
        if ( !object_equals(x[p],  y[p]) ) return false;
        // Objects and Arrays must be tested recursively
    }

    for (p in y)
        if ( y.hasOwnProperty(p) && !x.hasOwnProperty(p) )
            return false;
            // allows x[ p ] to be set to undefined
            
    return true;
}
actualOutput = '{"key1": 1, "akey": "abc", "bkey": "mno", "key2": 2}'

expectedOutput = '{"bkey": "mno", "akey": "abc", "key2": 2, "key1": 1}'

const actualOutput_json = JSON.parse(actualOutput)

const expectedOutput_json = JSON.parse(expectedOutput)

console.log(object_equals(actualOutput_json, expectedOutput_json));