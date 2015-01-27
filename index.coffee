_ = require 'lodash'


mergeArrayOfObjects = (o, a, b) ->
	result = []
	for k of a
		unless a[k] not in b and a[k] in o
			result.push a[k]
	for k of b
		if not k of a
			result.push b[k]
		else if typeof a[k] is 'object' and typeof b[k] is 'object'
			ov = if k of o and typeof o[k] is 'object' then o[k] else {}
			result[k] = merge ov, a[k], b[k]
		else if b[k] not in a
			result.push b[k]
	result


mergeArrayOfNonObjects = (o, a, b) ->
	result = []
	for elem in _.union o, a, b
		result.push elem unless elem in o and ((elem not in a) or (elem not in b))
	result


mergeArray = (o, a, b) ->
	a = [] if not Array.isArray a
	o = [] if not Array.isArray o

	if _.isObject _.first _.union o, a, b
		mergeArrayOfObjects o, a, b
	else
		mergeArrayOfNonObjects o, a, b


mergeObjects = (o, a, b) ->
	a = {} if Array.isArray a

	result = {}
	result[k] = b[k] for k of b
	for k of a
		if not k of result
			result[k] = a[k]
		else if a[k] isnt result[k]
			if typeof a[k] is 'object' and typeof b?[k] is 'object'
				ov = if o? and k of o and typeof o[k] is 'object' then o[k] else {}
				result[k] = merge ov, a[k], b[k]
			else if b?[k] is o?[k]
				result[k] = a[k]
	result


###
Function for 3-way merge

@param {Object} o (original)
@param {Object} a (current)
@param {Object} b (new)
@return {Object} Merged result
###
merge = (o, a, b) ->
	throw new Error 'Merge missing original document' if typeof o is 'undefined'
	throw new Error 'Merge missing current document' if typeof a is 'undefined'
	throw new Error 'Merge missing new document' if typeof b is 'undefined'

	if Array.isArray b
		mergeArray o, a, b
	else
		mergeObjects o, a, b


module.exports = merge

