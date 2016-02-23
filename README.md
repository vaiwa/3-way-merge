[![Build Status](https://travis-ci.org/vaiwa/3-way-merge.svg?branch=master)](https://travis-ci.org/vaiwa/3-way-merge)
[![Dependency Status](https://david-dm.org/vaiwa/3-way-merge.svg)](https://david-dm.org/vaiwa/3-way-merge)
[![npm version](https://badge.fury.io/js/3-way-merge.svg)](http://badge.fury.io/js/3-way-merge)


# merge(o, a, b) -> c

3-way merging of JavaScript objects

Takes 3 versions of the same object -- where version 2 and 3 are both derived from version 1 --
and generates a 4th version, effectively merging version 2 and 3 together.

When a **conflict** is detected (changes made in both version 2 and 3):
  - 1. delete has biggest priority
  - 2. changes from version 3 are used.


## Prototype

    merge(Object original, Object current, Object new) -> Object

- `original`: Ancestor version (original) from which both `versionA` and `versionB` are derived

- `current`: Version A of `original`

- `new`: Version B of `original`

## Example:

    // The original version which both A and B are derived from
    original = {
        aliases: {
            abc: "Abc"
        },
        deleted: 7890,
        key: "string",
        list: [
            "abc",
            "def"
        ],
        value: 1234
    }

    // Version A
    current = {
        aliases: {
            "abc": "Abcdef",
            "def": "Def"
        },
        list: [
            "abc",
            "cat",
            "def",
            "xyz"
        ],
        value: 123456
    }

    // Version B
    B = {
        aliases: {
            abc: "Abc",
            aab: "Aab"
        },
        list: [
            "abc",
            "zzz"
        ],
        value: 1234
    }

    // --> Merged result
    {
        aliases: {
            abc: "Abcdef",
            aab: "Aab",
            def: "Def"
        },
        list: [
            "abc",
            "cat",
            "xyz",
            "zzz"
        ],
        value: 123456
    }

look into tests for more examples

## Requirements

- `Array.isArray(object) -> Boolean` to be implemented (which it is already in modern JavaScript environments)

## Edge cases
### Merging arrays
- Array of simple elements (no object in array) are merged by its values
- Array of objects with attribute `id` are merged base on their id
- Array of objects without attribute `id` are merged base on their index






