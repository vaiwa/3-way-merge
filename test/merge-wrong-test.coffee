expect = require('chai').expect

merge = require '../'


describe 'Merge on Wrong inputs', ->

	describe 'on arrays', ->

		it 'merge duplicities', ->
			o = []
			a = [1, 2, 1]
			b = []
			expected = [1, 2] # not [1, 2, 1]
			expect(expected).to.eql merge o, a, b


		it 'wrong order', ->
			o = [1, 2, 3]
			a = [3, 2, 1]
			b = [2, 3, 1]
			expected = [1, 2, 3]
			expect(expected).to.eql merge o, a, b


		it 'object and remove null and undefined', ->
			o = []
			a = [{}, null, undefined]
			b = []
			expected = [{}]
			expect(expected).to.eql merge o, a, b


		it 'number and remove null and undefined', ->
			o = []
			a = [1, null, undefined]
			b = []
			expected = [1]
			expect(expected).to.eql merge o, a, b


		it 'object with id and without', ->
			o = [{id: 'o'}]
			a = [{id: 'o'}, {id: 'a'}, {a: 'a'}, {A: 'A'}]
			b = [{id: 'o'}, {id: 'b'}, {b: 'b'}, {B: 'B'}]
			expected = [{id: 'o'}, {id: 'a'}, {id: 'b'}] # ignoring objects without ids
			expect(expected).to.eql merge o, a, b


		it 'object without and with id ', ->
			o = [{o: 'o'}]
			a = [{o: 'o'}, {id: 'a'}]
			b = [{o: 'o'}, {id: 'b'}]
			expected = [{id: 'a'}, {id: 'b'}] # ignoring objects without ids
			expect(expected).to.eql merge o, a, b


		it 'objects and simple elems', ->
			o = []
			a = [{a: 'a'}, null, undefined, 'a', 1, [{b: 'b'}]]
			b = []
			expected = [{a: 'a'}]
			expect(expected).to.eql merge o, a, b


		it 'objects with id and simple elems', ->
			o = []
			a = [{id: 'a'}, null, undefined, 'a', 1, [{b: 'b'}]]
			b = []
			expected = [{id: 'a'}]
			expect(expected).to.eql merge o, a, b


		it 'simple elems with array in arrays', ->
			o = []
			a = [null, undefined, 'a', 1, ['42']]
			b = []
			expected = ['a', 1, ['42']]
			expect(expected).to.eql merge o, a, b


		it 'array of arrays - change in A and B - is delete and add!!!', ->
			o = [[1]]
			a = [[2]]
			b = [[3]]
			expected = [[2], [3]]
			expect(expected).to.eql merge o, a, b




