expect = require('chai').expect

merge = require '../'


describe 'Merge on Objects', ->

	it 'empty no change', ->
		o = {}
		a = {}
		b = {}
		expected = {}
		expect(expected).to.eql merge o, a, b


	describe 'simple', ->

		it 'not empty no change', ->
			o = key: 'value'
			a = key: 'value'
			b = key: 'value'
			expected = key: 'value'
			expect(expected).to.eql merge o, a, b


		it 'add key in B', ->
			o = key: 'value'
			a = key: 'value'
			b = key: 'value', added: 'value'
			expected = key: 'value', added: 'value'
			expect(expected).to.eql merge o, a, b


		it 'add key in A', ->
			o = key: 'value'
			a = key: 'value', added: 'value'
			b = key: 'value'
			expected = key: 'value', added: 'value'
			expect(expected).to.eql merge o, a, b


		it 'add key in A and B', ->
			o = key: 'value'
			a = key: 'value', a: 'a'
			b = key: 'value', b: 'b'
			expected = key: 'value', a: 'a', b: 'b'
			expect(expected).to.eql merge o, a, b


		it 'change key in B', ->
			o = key: 'value'
			a = key: 'value'
			b = key: 'change'
			expected = key: 'change'
			expect(expected).to.eql merge o, a, b


		it 'change key in A', ->
			o = key: 'value'
			a = key: 'change'
			b = key: 'value'
			expected = key: 'change'
			expect(expected).to.eql merge o, a, b


		it 'change key in A and B', ->
			o = key: 'value'
			a = key: 'changeA'
			b = key: 'changeB'
			expected = key: 'changeB'
			expect(expected).to.eql merge o, a, b


		it 'delete key in B', ->
			o = key: 'value'
			a = key: 'value'
			b = {}
			expected = {}
			expect(expected).to.eql merge o, a, b


		it 'delete key in A', ->
			o = key: 'value'
			a = {}
			b = key: 'value'
			expected = {}
			expect(expected).to.eql merge o, a, b


		it 'delete key in A and B', ->
			o = key: 'value'
			a = {}
			b = {}
			expected = {}
			expect(expected).to.eql merge o, a, b


		it 'change key in A and delete it in B', ->
			o = key: 'value'
			a = key: 'change'
			b = {}
			expected = {}
			expect(expected).to.eql merge o, a, b


		it 'change key in B and delete it in A', ->
			o = key: 'value'
			a = {}
			b = key: 'change'
			expected = {}
			expect(expected).to.eql merge o, a, b


		describe 'boolean interaction', ->

			it 'change object to false in A', ->
				o = key1: key2: 'value'
				a = key1: false
				b = key1: key2: 'value'
				expected = key1: false
				expect(expected).to.eql merge o, a, b


			it 'change object to false in B', ->
				o = key1: key2: 'value'
				a = key1: key2: 'value'
				b = key1: false
				expected = key1: false
				expect(expected).to.eql merge o, a, b


			it 'change object to false in A', ->
				o = key: 'value'
				a = false
				b = key: 'value'
				expected = false
				expect(expected).to.eql merge o, a, b


			it 'change object to false in B', ->
				o = key: 'value'
				a = key: 'value'
				b = false
				expected = false
				expect(expected).to.eql merge o, a, b


	describe 'nested', ->

		it 'existing nested objects', ->
			o = key1:
				subkey1: 'value1'
			a = key1:
				subkey1: 'changed'
				subkey2: 'value2'
			b = key1:
				subkey1: 'value1'
				subkey3: 'value3'
			expected = key1:
				subkey1: 'changed'
				subkey2: 'value2'
				subkey3: 'value3'
			expect(expected).to.eql merge o, a, b


		it 'replace simple key with nested object', ->
			o = {}
			a =
				key1: 'value1'
				key2: 'value2'
			b = key1:
				subkey1: 'value1'
				subkey2: 'value2'
			expected =
				key1:
					subkey1: 'value1'
					subkey2: 'value2'
				key2: 'value2'
			expect(expected).to.eql merge o, a, b


		it 'replace nested object with simple key', ->
			o = {}
			a =
				key1:
					subkey1: 'value1'
					subkey2: 'value2'
				key2: 'value2'
			b = key1: 'value1'
			expected =
				key1: 'value1'
				key2: 'value2'
			expect(expected).to.eql merge o, a, b


		it 'change with simple key in A and with nested object in B', ->
			o = key1: 'value1'
			a =
				key1: 'change'
				key2: 'value2'
			b = key1:
				subkey1: 'value1'
				subkey2: 'value2'
			expected =
				key1:
					subkey1: 'value1'
					subkey2: 'value2'
				key2: 'value2'
			expect(expected).to.eql merge o, a, b


		it 'change with simple key in B and with nested object in A', ->
			o = key1: 'value1'
			a =
				key1:
					subkey1: 'value1'
					subkey2: 'value2'
				key2: 'value2'
			b = key1: 'change'
			expected =
				key1: 'change'
				key2: 'value2'
			expect(expected).to.eql merge o, a, b


		it 'add nested object', ->
			o = {}
			a = a: {}
			b = b: c: {}
			expected =
				a: {}
				b: c: {}
			expect(expected).to.eql merge o, a, b


		it 'replace object with simple key', ->
			o =
				key1:
					subkey1: 'value1'
					subkey2: 'value2'
				key2: 'value2'
			a =
				key1: 'value1'
				key2: 'value2'
			b = key1: 'value1'
			expected =
				key1: 'value1'
			expect(expected).to.eql merge o, a, b


		it 'on array properties', ->
			o = {}
			a = key1: ['one', 'two']
			b =
				key1: ['one', 'three']
				key2: ['four']
			expected =
				key1: ['one', 'two', 'three']
				key2: ['four']
			expect(expected).to.eql merge o, a, b


		it 'null values in object', ->
			o = key1: null
			a = key1: key2: null
			b = key1: null
			expected = key1: key2: null
			expect(expected).to.eql merge o, a, b





