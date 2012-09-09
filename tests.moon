package.path ..= ';/home/echobravo/Projects/link/?.lua'
require 'moonscript'
require 'busted'

link = require 'link'

describe 'Select', ->
        describe 'Select k,v', ->
            it 'should return only even numbers', ->
                got = link.select {
                    from_: {1,2,3,4,5,6,7,8,9,10}
                    where: 'v % 2 == 0'
                }
                expected = {
                    [2]: 2,
                    [4]: 4,
                    [6]: 6,
                    [8]: 8,
                    [10]: 10
                }
                assert.are.same got, expected
                nil

            it 'should return tables and strings', ->
                got = link.select {
                    from_: {1, 2, 'a', b: 'b', {}, c: {}}
                    where: {
                        "type(v) == 'table'"
                        "type(v) == 'string'"
                    }
                }
                expected = {
                    [3]: 'a',
                    b: 'b',
                    [4]: {},
                    c: {}
                }
                assert.are.same got, expected
                nil
