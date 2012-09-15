package.path ..= ';/home/echobravo/Projects/link/?.lua'
require 'moonscript'
require 'busted'

link = require 'link'

same_items = (t1, t2) ->
    table.sort t1, cmp
    table.sort t2, cmp

describe 'Select', ->
    describe 'Select k,v', ->
        it 'should select only even numbers', ->
            got = link.select
                from_: {1,2,3,4,5,6,7,8,9,10}
                where: 'v % 2 == 0'

            expected =
                [2]: 2,
                [4]: 4,
                [6]: 6,
                [8]: 8,
                [10]: 10

            assert.are.same got, expected
            nil

        it 'should select tables and strings', ->
            got = link.select
                from_: {1, 2, 'a', b: 'b', {}, c: {}}
                where: {
                    "type(v) == 'table'"
                    "type(v) == 'string'"
                }

            expected =
                [3]: 'a'
                b: 'b'
                [4]: {}
                c: {}

            assert.are.same got, expected
            nil

        it 'should select everything', ->
            t = {1,2,3,->,'a',{},}
            got = link.select
                from_: t

            assert.are.same got, t
            nil

        it 'should select nothing', ->
            t = {1,2,3,->,'a',{},}
            got = link.select
                from_: t
                where: -> false

            assert.are.same got, {}
            nil


    describe 'Select set', ->
        it 'should select set of odd values', ->
            got = link.select {link.set('v'),
                from_: {1,2,3,4,5}
                where: 'v % 2 ~= 0'
            }
            expected =
                [1]: true
                [3]: true
                [5]: true
            assert.are.same got, expected
            nil

        it 'should select set of keys of functions', ->
            got = link.select {link.set('k'),
                from_:
                    foo: -> true
                    bar: -> false
                    [3]: (v) -> v*2
                where: "type(v) == 'function'"
            }
            expected =
                foo: true
                bar: true
                [3]: true
            assert.are.same got, expected
            nil

--------------------------------------------

describe 'Delete', ->
        it 'should delete nothing', ->
            t = {1,2,3,4,5,6,7,8,9,10}
            t2 = link.select
                from_: t

            got = link.delete
                from_: t
                where: 'false'

            assert.are.same got, t2
            nil

        it 'should delete everything', ->
            t = {1,a:2,{},[{}]: ->}
            link.delete
                from_: t
                where: -> true

            assert.are.same t, {}
            nil
