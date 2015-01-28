expect = require('chai').expect

merge = require '../'


types = [null, undefined]


testFor = (type) ->

	describe "Merge on #{type}", ->

		it "#{type}", ->
			o = type
			a = type
			b = type
			expected = type
			expect(expected).to.eql merge o, a, b


		describe 'booleans', ->

			it 'change to true in A', ->
				o = type
				a = true
				b = type
				expected = true
				expect(expected).to.eql merge o, a, b


			it 'change to true in B', ->
				o = type
				a = type
				b = true
				expected = true
				expect(expected).to.eql merge o, a, b


			it 'change to false in A', ->
				o = type
				a = false
				b = type
				expected = false
				expect(expected).to.eql merge o, a, b


			it 'change to false in B', ->
				o = type
				a = type
				b = false
				expected = false
				expect(expected).to.eql merge o, a, b


		describe 'string', ->

			it 'add in B', ->
				o = type
				a = type
				b = 'string'
				expected = 'string'
				expect(expected).to.eql merge o, a, b


			it 'add in A', ->
				o = type
				a = 'string'
				b = type
				expected = 'string'
				expect(expected).to.eql merge o, a, b


			it 'add in A and B', ->
				o = type
				a = 'a'
				b = 'b'
				expected = 'b'
				expect(expected).to.eql merge o, a, b


			it 'delete in B', ->
				o = 'string'
				a = 'string'
				b = type
				expected = type
				expect(expected).to.eql merge o, a, b


			it 'delete in A', ->
				o = 'string'
				a = type
				b = 'string'
				expected = type


			it 'delete in A and B', ->
				o = 'string'
				a = type
				b = type
				expected = type
				expect(expected).to.eql merge o, a, b


		describe 'number', ->

			it 'add in B', ->
				o = type
				a = type
				b = 2
				expected = 2
				expect(expected).to.eql merge o, a, b


			it 'add in A', ->
				o = type
				a = 1
				b = type
				expected = 1
				expect(expected).to.eql merge o, a, b


			it 'add in A and B', ->
				o = type
				a = 1
				b = 2
				expected = 2
				expect(expected).to.eql merge o, a, b


			it 'delete in B', ->
				o = 42
				a = 42
				b = type
				expected = type
				expect(expected).to.eql merge o, a, b


			it 'delete in A', ->
				o = 42
				a = type
				b = 42
				expected = type


			it 'delete in A and B', ->
				o = 42
				a = type
				b = type
				expected = type
				expect(expected).to.eql merge o, a, b


		describe 'not so simple', ->

			describe 'array', ->

				it 'add in A', ->
					o = type
					a = [42]
					b = type
					expected = [42]
					expect(expected).to.eql merge o, a, b

				it 'add in B', ->
					o = type
					a = type
					b = [42]
					expected = [42]
					expect(expected).to.eql merge o, a, b


				it 'change in A delete in B', ->
					o = ''
					a = []
					b = type
					expected = type
					expect(expected).to.eql merge o, a, b


				it 'change in B delete in A', ->
					o = ''
					a = type
					b = []
					expected = type
					expect(expected).to.eql merge o, a, b


			describe 'object', ->

				it 'add in A', ->
					o = type
					a = a: 'a'
					b = type
					expected = a: 'a'
					expect(expected).to.eql merge o, a, b

				it 'add in B', ->
					o = type
					a = type
					b = b: 'b'
					expected = b: 'b'
					expect(expected).to.eql merge o, a, b


				it 'change in A delete in B', ->
					o = ''
					a = {}
					b = type
					expected = type
					expect(expected).to.eql merge o, a, b


				it 'change in B delete in A', ->
					o = ''
					a = type
					b = {}
					expected = type
					expect(expected).to.eql merge o, a, b



testFor type for type in types

