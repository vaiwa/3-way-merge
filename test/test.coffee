expect = require('chai').expect

merge = require '../'


describe 'Merge', ->

	describe 'on Arrays', ->

		describe 'of strings', ->

			it 'empty no change', ->
				o = []
				a = []
				b = []
				expected = []

				expect(expected).to.eql merge(o, a, b)

			it 'not empty no change', ->
				o = ['one']
				a = ['one']
				b = ['one']
				expected = ['one']

				expect(expected).to.eql merge(o, a, b)


			it 'add in B', ->
				o = []
				a = []
				b = ['one', 'two']
				expected = ['one', 'two']

				expect(expected).to.eql merge(o, a, b)


			it 'add in A', ->
				o = []
				a = ['one', 'two']
				b = []
				expected = ['one', 'two']

				expect(expected).to.eql merge(o, a, b)


			it 'add in A and B', ->
				o = []
				a = ['one']
				b = ['two']
				expected = ['one', 'two']

				expect(expected).to.eql merge(o, a, b)


			it 'remove in B', ->
				o = ['one', 'two']
				a = ['one', 'two']
				b = []
				expected = []

				expect(expected).to.eql merge(o, a, b)


			it 'remove in A', ->
				o = ['one', 'two']
				a = []
				b = ['one', 'two']
				expected = []

				expect(expected).to.eql merge(o, a, b)


			it 'remove in A and B', ->
				o = ['one', 'two']
				a = ['one']
				b = ['two']
				expected = []

				expect(expected).to.eql merge(o, a, b)


			it 'add in A, remove in B', ->
				o = ['one', 'two']
				a = ['one', 'two', 'three']
				b = ['one']
				expected = ['one', 'three']

				expect(expected).to.eql merge(o, a, b)


			it 'add in B, remove in A', ->
				o = ['one', 'two']
				a = ['one']
				b = ['one', 'two', 'three']
				expected = ['one', 'three']

				expect(expected).to.eql merge(o, a, b)


			it 'add and remove in A and B', ->
				o = ['one', 'two']
				a = ['one', 'three'] # remove two add three
				b = ['two', 'four'] # remove one add four
				expected = ['three', 'four']

				expect(expected).to.eql merge(o, a, b)


		describe 'of objects', ->

			it 'simple', ->
				o = {}
				a = [
					{ key1: ['one', 'two'] }
					{ key3: ['four'] }
				]
				b = [
					{ key1: ['one', 'three'], key2: ['one'] }
					{ key3: ['five'] }
				]
				expected = [
					{ key1: ['one', 'two', 'three'], key2: ['one'] }
					{ key3: ['four', 'five'] }
				]

				expect(expected).to.eql merge(o, a, b)

			it 'nested', ->
				o = [
					{ key1: { subkey: 'two'} }
				]
				a = [
					{ key1: { subkey: 'one' } }
				]
				b = [
					{ key1: { subkey: 'two' } }
					{ key2: { subkey: 'three'} }
				]
				expected = [
					{ key1: { subkey: 'one' } }
					{ key2: { subkey: 'three'} }
				]

				expect(expected).to.eql merge(o, a, b)


	describe 'on Objects', ->

		it 'add keys that do not exist elsewhere', ->
			o = {}
			a = {}
			b =
				key1: 'value1'
				key2: 'value2'
			expected =
				key1: 'value1'
				key2: 'value2'

			expect(expected).to.eql merge(o, a, b)


		it 'existing simple keys', ->
			o =
				key1: 'value1'
			a =
				key1: 'changed'
				key2: 'value2'
			b =
				key1: 'value1'
				key3: 'value3'
			expected =
				key1: 'changed'
				key2: 'value2'
				key3: 'value3'

			expect(expected).to.eql merge(o, a, b)


		it 'existing nested objects', ->
			o =
				key1:
					subkey1: 'value1'
			a =
				key1:
					subkey1: 'changed'
					subkey2: 'value2'
			b =
				key1:
					subkey1: 'value1'
					subkey3: 'value3'
			expected =
				key1:
					subkey1: 'changed'
					subkey2: 'value2'
					subkey3: 'value3'

			expect(expected).to.eql merge(o, a, b)


		it 'replace simple key with nested object', ->
			o = {}
			a =
				key1: 'value1'
				key2: 'value2'
			b =
				key1:
					subkey1: 'value1'
					subkey2: 'value2'
			expected =
				key1:
					subkey1: 'value1'
					subkey2: 'value2'
				key2: 'value2'

			expect(expected).to.eql merge(o, a, b)


		it 'add nested object', ->
			o = {}
			a =
				a: {}
			b =
				b:
					c: {}
			expected =
				a: {}
				b:
					c: {}

			expect(expected).to.eql merge(o, a, b)


		it 'replace object with simple key', ->
			o =
				key1:
					subkey1: 'value1'
					subkey2: 'value2'
				key2: 'value2'
			a =
				key1: 'value1'
				key2: 'value2'
			b =
				key1: 'value1'

			expected =
				key1: 'value1'

			expect(expected).to.eql merge(o, a, b)


		it 'on array properties', ->
			o = {}
			a =
				key1: ['one', 'two']
			b =
				key1: ['one', 'three']
				key2: ['four']
			expected =
				key1: ['one', 'two', 'three']
				key2: ['four']

			expect(expected).to.eql merge(o, a, b)


		it 'null values in object', ->
			o = key1: null
			a = key1: key2: null
			b = key1: null
			expected = key1: key2: null

			expect(expected).to.eql merge(o, a, b)


