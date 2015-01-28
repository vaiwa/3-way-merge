expect = require('chai').expect

merge = require '../'


describe 'Merge on Simple', ->

	describe 'string', ->

		it 'no change', ->
			o = 'string'
			a = 'string'
			b = 'string'
			expected = 'string'
			expect(expected).to.eql merge o, a, b


		it 'change in B', ->
			o = 'string'
			a = 'string'
			b = 'b'
			expected = 'b'
			expect(expected).to.eql merge o, a, b


		it 'change in A', ->
			o = 'string'
			a = 'a'
			b = 'string'
			expected = 'a'
			expect(expected).to.eql merge o, a, b


		it 'change in A and B', ->
			o = 'string'
			a = 'a'
			b = 'b'
			expected = 'b'
			expect(expected).to.eql merge o, a, b


		describe 'not so simple', ->

			describe 'array', ->

				it 'change in A', ->
					o = 'string'
					a = [42]
					b = 'string'
					expected = [42]
					expect(expected).to.eql merge o, a, b

				it 'change in B', ->
					o = 'string'
					a = 'string'
					b = [42]
					expected = [42]
					expect(expected).to.eql merge o, a, b


			describe 'object', ->

				it 'change in A', ->
					o = 'string'
					a = a: 'a'
					b = 'string'
					expected = a: 'a'
					expect(expected).to.eql merge o, a, b

				it 'change in B', ->
					o = 'string'
					a = 'string'
					b = b: 'b'
					expected = b: 'b'
					expect(expected).to.eql merge o, a, b

	describe 'number', ->

		it 'no change', ->
			o = 42
			a = 42
			b = 42
			expected = 42
			expect(expected).to.eql merge o, a, b


		it 'change in B', ->
			o = 42
			a = 42
			b = 2
			expected = 2
			expect(expected).to.eql merge o, a, b


		it 'change in A', ->
			o = 42
			a = 1
			b = 42
			expected = 1
			expect(expected).to.eql merge o, a, b


		it 'change in A and B', ->
			o = 42
			a = 1
			b = 2
			expected = 2
			expect(expected).to.eql merge o, a, b


		describe 'not so simple', ->

			describe 'array', ->

				it 'change in A', ->
					o = 42
					a = [42]
					b = 42
					expected = [42]
					expect(expected).to.eql merge o, a, b

				it 'change in B', ->
					o = 42
					a = 42
					b = [42]
					expected = [42]
					expect(expected).to.eql merge o, a, b


			describe 'object', ->

				it 'change in A', ->
					o = 42
					a = a: 'a'
					b = 42
					expected = a: 'a'
					expect(expected).to.eql merge o, a, b

				it 'change in B', ->
					o = 42
					a = 42
					b = b: 'b'
					expected = b: 'b'
					expect(expected).to.eql merge o, a, b




