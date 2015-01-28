expect = require('chai').expect

merge = require '../'


describe 'Merge on Arrays', ->

	describe 'of simple', ->

		describe 'strings', ->

			it 'empty no change', ->
				o = []
				a = []
				b = []
				expected = []
				expect(expected).to.eql merge o, a, b

			it 'not empty no change', ->
				o = ['one']
				a = ['one']
				b = ['one']
				expected = ['one']
				expect(expected).to.eql merge o, a, b


			it 'add in B', ->
				o = []
				a = []
				b = ['one', 'two']
				expected = ['one', 'two']
				expect(expected).to.eql merge o, a, b


			it 'add in A', ->
				o = []
				a = ['one', 'two']
				b = []
				expected = ['one', 'two']
				expect(expected).to.eql merge o, a, b


			it 'add in A and B', ->
				o = []
				a = ['one']
				b = ['two']
				expected = ['one', 'two']
				expect(expected).to.eql merge o, a, b


			it 'remove in B', ->
				o = ['one', 'two']
				a = ['one', 'two']
				b = []
				expected = []
				expect(expected).to.eql merge o, a, b


			it 'remove in A', ->
				o = ['one', 'two']
				a = []
				b = ['one', 'two']
				expected = []
				expect(expected).to.eql merge o, a, b


			it 'remove in A and B', ->
				o = ['one', 'two']
				a = ['one']
				b = ['two']
				expected = []
				expect(expected).to.eql merge o, a, b


			it 'add in A, remove in B', ->
				o = ['one', 'two']
				a = ['one', 'two', 'three']
				b = ['one']
				expected = ['one', 'three']
				expect(expected).to.eql merge o, a, b


			it 'add in B, remove in A', ->
				o = ['one', 'two']
				a = ['one']
				b = ['one', 'two', 'three']
				expected = ['one', 'three']
				expect(expected).to.eql merge o, a, b


			it 'add and remove in A and B', ->
				o = ['one', 'two']
				a = ['one', 'three'] # remove two add three
				b = ['two', 'four'] # remove one add four
				expected = ['three', 'four']
				expect(expected).to.eql merge o, a, b


		describe 'numbers', ->

			it 'empty no change', ->
				o = []
				a = []
				b = []
				expected = []
				expect(expected).to.eql merge o, a, b

			it 'not empty no change', ->
				o = [1]
				a = [1]
				b = [1]
				expected = [1]
				expect(expected).to.eql merge o, a, b


			it 'add in B', ->
				o = []
				a = []
				b = [1, 2]
				expected = [1, 2]
				expect(expected).to.eql merge o, a, b


			it 'add in A', ->
				o = []
				a = [1, 2]
				b = []
				expected = [1, 2]
				expect(expected).to.eql merge o, a, b


			it 'add in A and B', ->
				o = []
				a = [1]
				b = [2]
				expected = [1, 2]
				expect(expected).to.eql merge o, a, b


			it 'remove in B', ->
				o = [1, 2]
				a = [1, 2]
				b = []
				expected = []
				expect(expected).to.eql merge o, a, b


			it 'remove in A', ->
				o = [1, 2]
				a = []
				b = [1, 2]
				expected = []
				expect(expected).to.eql merge o, a, b


			it 'remove in A and B', ->
				o = [1, 2]
				a = [1]
				b = [2]
				expected = []
				expect(expected).to.eql merge o, a, b


			it 'add in A, remove in B', ->
				o = [1, 2]
				a = [1, 2, 3]
				b = [1]
				expected = [1, 3]
				expect(expected).to.eql merge o, a, b


			it 'add in B, remove in A', ->
				o = [1, 2]
				a = [1]
				b = [1, 2, 3]
				expected = [1, 3]
				expect(expected).to.eql merge o, a, b


			it 'add and remove in A and B', ->
				o = [1, 2]
				a = [1, 3] # remove two add three
				b = [2, 4] # remove one add four
				expected = [3, 4]
				expect(expected).to.eql merge o, a, b


	describe 'of objects', ->

		describe 'regular', ->

			it 'add in A and add in B', ->
				o = []
				a = [{key: 'a'}]
				b = [{key: 'b'}]
				expected = [{key: 'b'}]
				expect(expected).to.eql merge o, a, b


			it 'add in A and add in B couse merge', ->
				o = []
				a = [{a: 'a'}]
				b = [{b: 'b'}]
				expected = [{a: 'a', b: 'b'}]
				expect(expected).to.eql merge o, a, b


			it 'delete in B', ->
				o = [{key: 'value'}]
				a = [{key: 'value'}]
				b = [{}]
				expected = [{}]
				expect(expected).to.eql merge o, a, b


			it 'delete in A', ->
				o = [{key: 'value'}]
				a = [{}]
				b = [{key: 'value'}]
				expected = [{}]
				expect(expected).to.eql merge o, a, b


			it 'delete in B and change in A', ->
				o = [{key: 'value'}]
				a = [{key: 'change'}]
				b = [{}]
				expected = [{}]
				expect(expected).to.eql merge o, a, b


			it 'delete in A and change in B', ->
				o = [{key: 'value'}]
				a = [{}]
				b = [{key: 'change'}]
				expected = [{}]
				expect(expected).to.eql merge o, a, b


			it 'simple', ->
				o = {}
				a = [{key1: ['one', 'two'] }, {key3: ['four'] }]
				b = [{key1: ['one', 'three'], key2: ['one'] }, {key3: ['five'] }]
				expected = [{key1: ['one', 'two', 'three'], key2: ['one'] }, {key3: ['four', 'five'] }]
				expect(expected).to.eql merge o, a, b


			it 'nested', ->
				o = [{key1: {subkey: 'two'} }]
				a = [{key1: {subkey: 'one' } }]
				b = [{key1: {subkey: 'two' } }, {key2: {subkey: 'three'} }]
				expected = [{key1: {subkey: 'one' } }, {key2: {subkey: 'three'} }]
				expect(expected).to.eql merge o, a, b


		describe 'with ids', ->

			it 'add in A and in B', ->
				o = []
				a = [{id: 'a', key: 'a'}]
				b = [{id: 'b', key: 'b'}]
				expected = [{id: 'a', key: 'a'}, {id: 'b', key: 'b'}]
				expect(expected).to.eql merge o, a, b


			it 'delete in B', ->
				o = [{id: 'o', key: 'o'}]
				a = [{id: 'o', key: 'o'}]
				b = []
				expected = []
				expect(expected).to.eql merge o, a, b


			it 'delete in A', ->
				o = [{id: 'o', key: 'o'}]
				a = []
				b = [{id: 'o', key: 'o'}]
				expected = []
				expect(expected).to.eql merge o, a, b


			it 'delete in A and in B', ->
				o = [{id: 'a', key: 'a'}, {id: 'b', key: 'b'}]
				a = [{id: 'a', key: 'a'}]
				b = [{id: 'b', key: 'b'}]
				expected = []
				expect(expected).to.eql merge o, a, b


			it 'change same key in A and in B', ->
				o = [{id: 'o', key: 'o'}]
				a = [{id: 'o', key: 'a'}]
				b = [{id: 'o', key: 'b'}]
				expected = [{id: 'o', key: 'b'}]
				expect(expected).to.eql merge o, a, b


			it 'change in A and in B', ->
				o = [{id: 'o'}]
				a = [{id: 'o', a: 'a'}]
				b = [{id: 'o', b: 'b'}]
				expected = [{id: 'o', a: 'a', b: 'b'}]
				expect(expected).to.eql merge o, a, b


	describe 'of arrays', ->

		it 'no change one elem', ->
			o = [[1]]
			a = [[1]]
			b = [[1]]
			expected = [[1]]
			expect(expected).to.eql merge o, a, b


		it 'no change two elems', ->
			o = [[1], [2]]
			a = [[1], [2]]
			b = [[1], [2]]
			expected = [[1], [2]]
			expect(expected).to.eql merge o, a, b


		it 'add in B', ->
			o = [[1]]
			a = [[1]]
			b = [[1], [2]]
			expected = [[1], [2]]
			expect(expected).to.eql merge o, a, b


		it 'add in A', ->
			o = [[1]]
			a = [[1], [2]]
			b = [[1]]
			expected = [[1], [2]]
			expect(expected).to.eql merge o, a, b


		it 'add in A and B', ->
			o = [[1]]
			a = [[1], [2]]
			b = [[1], [3]]
			expected = [[1], [2], [3]]
			expect(expected).to.eql merge o, a, b


		it 'delete in B', ->
			o = [[1], [2]]
			a = [[1], [2]]
			b = [[1]]
			expected = [[1]]
			expect(expected).to.eql merge o, a, b


		it 'delete in A', ->
			o = [[1], [2]]
			a = [[1]]
			b = [[1], [2]]
			expected = [[1]]
			expect(expected).to.eql merge o, a, b


		it 'delete in A and B', ->
			o = [[1], [2]]
			a = [[1]]
			b = [[2]]
			expected = []
			expect(expected).to.eql merge o, a, b


		it 'change in B - is delete and add!!!', ->
			o = [[1]]
			a = [[1]]
			b = [[2]]
			expected = [[2]]
			expect(expected).to.eql merge o, a, b


		it 'change in A - is delete and add!!!', ->
			o = [[1]]
			a = [[2]]
			b = [[1]]
			expected = [[2]]
			expect(expected).to.eql merge o, a, b


		it 'change in A and B - is delete and add!!!', ->
			o = [[1]]
			a = [[2]]
			b = [[3]]
			expected = [[2], [3]]
			expect(expected).to.eql merge o, a, b





