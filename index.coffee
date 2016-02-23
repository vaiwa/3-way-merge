_ = require 'lodash'


module.exports = ->

	isNull = (a) -> _.isNull a
	isUndf = (a) -> _.isUndefined a
	isEmpt = (a) -> isNull(a) or isUndf(a)
	isDelete = (fO, fA, fB) -> (not fO and (fA or fB)) or (fA and fB)
	isSimple = (a) -> not _.isObject(a)
	getIds = (a) -> _.map a, 'id'
	isMatch = (a, b) -> if isSimple(a) or isSimple(b) then (a is b) else _.isMatch a, b
	elemIn = (elem, a) -> if _.isObject elem then _.findIndex(a, (el) -> isMatch elem, el) isnt -1 else elem in a
	isArrayOfObjects = (a) -> _.findIndex(a, _.isPlainObject) isnt -1
	isArrayOfObjectsWithIds = (a) -> _.findIndex(a, (i) -> _.isPlainObject(i) and i.id?) isnt -1


	mergeArrayOfObjects = (o, a, b) ->
		result = []
		for i in [0.._.max [o.length, a.length, b.length]]
			res = merge o[i], a[i], b[i]
			break unless res
			result.push res
		result


	mergeArrayOfObjectsWithIds = (o, a, b) ->
		oI = _.keyBy o, 'id'
		aI = _.keyBy a, 'id'
		bI = _.keyBy b, 'id'

		result = []
		for id in _.union getIds(o), getIds(a), getIds(b)
			continue if isEmpt id # ignore objects without ids
			res = merge oI[id], aI[id], bI[id]
			result.push res unless isEmpt res
		result


	mergeArrayOfSimples = (o, a, b) ->
		doubleCheck = []
		result = []
		for elem in _.union o, a, b
			continue if isEmpt elem # skip empty elems
			continue if _.isObject(elem) and elemIn elem, doubleCheck # skip for duplicate elems
			doubleCheck.push elem
			result.push elem unless elemIn(elem, o) and (not elemIn(elem, a) or not elemIn(elem, b))
		result


	mergeArray = (o, a, b) ->
		o = [] unless _.isArray o
		a = [] unless _.isArray a
		b = [] unless _.isArray b

		objs = _.union o, a, b
		if isArrayOfObjectsWithIds objs
			mergeArrayOfObjectsWithIds o, a, b
		else if isArrayOfObjects objs
			mergeArrayOfObjects o, a, b
		else
			mergeArrayOfSimples o, a, b


	mergeObjects = (o, a, b) ->
		o = {} unless _.isPlainObject o
		a = {} unless _.isPlainObject a
		b = {} unless _.isPlainObject b

		oKeys = _.keys o
		aKeys = _.keys a
		bKeys = _.keys b

		result = {}
		for key in _.union aKeys, bKeys
			continue if key in oKeys and ((key not in aKeys) or (key not in bKeys)) # DEL KEY
			result[key] = merge o[key], a[key], b[key] # SET KEY
		result


	mergeSimple = (o, a, b) ->
		return undefined if isDelete isUndf(o), isUndf(a), isUndf(b) # DELETE
		return null if isDelete isNull(o), isNull(a), isNull(b) # DELETE
		if isEmpt o # ADD
			return b if b?
			a
		else # CHANGE
			return b unless isMatch b, o
			a


	###
	Function for 3-way merge
	@param {Object} o (original)
	@param {Object} a (current)
	@param {Object} b (new)
	@return {Object} Merged result
	###
	merge: (o, a, b) ->
		if isSimple(b) or isSimple(a)
			mergeSimple o, a, b
		else if _.isArray(b) or _.isArray(a)
			mergeArray o, a, b
		else
			mergeObjects o, a, b
