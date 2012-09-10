LuaInk
======

1. About
-----

**LuaInk**, or **LInk**, is a library written in [MoonScript](http://moonscript.org) that brings [LINQ](http://en.wikipedia.org/wiki/Language_Integrated_Query)-like
functionality to [Lua](http://www.lua.org/) tables, and works by using load / loadstring tricks to evaluate conditions.

It was created as a proof of concept and thus has no considerations for safety
(sandboxing) or performance.

2. Usage
-----

**LInk** uses SQL-like statements to return either key-value pairs or sets of values.
For example, the following MoonScript code returns a table of all pairs
of 't' where the value is a function.

```moonscript
t =
    a: 2
    foo: -> true
    bar: {}
    [3]: (n) => self + n

link = require 'link'
funcs = link.select
    from_: t
    where: "type(v) == 'function'"
```

Of course, it works from Lua (either 5.1 or 5.2) as well:
```lua
t = {
    a = 2, 
    foo = function () return true end,
    bar = {}, 
    [3] = function (self, n) return self + n end,
}

link = require 'link'
funcs = link.select{
    from_ = t,
    where = "type(v) == 'function'"
}

```

**LInk** may also return a set of only the keys or values:

```moonscript
fibonacci = {1, 2, 3, 5, 8, 13, 21}

link = require 'link'
-- gets the positions of fibonacci numbers that are even or multiples of 7
even_indexes = link.select {link.set('k'),
    from_: fibonacci
    where: {
        "v % 2 == 0"
        "v % 7 == 0"
    }
}
```

3. Contributions and Roadmap
-----

Any bug reports or feature suggestions are welcome, and accompanying code is not
only appreciated, but also encouraged. **LInk** uses [busted](https://github.com/Olivine-Labs/busted) for its tests and
the only rule regaring contributions is that code must be tested.

The TODO list, in order of priority:
 * Create installation scripts;
 * Implement "delete" statement;
 * implement "update" statement;
 * Add documentation;
 * Implemente "print" statemante.

4. License and Author
-----

LuaInk was created by Elias Tandel Barrionovo and is distributed under the MIT license, the same license as Lua itself; see LICENSE.txt file for more info. 
