-- If Lua 5.2, use load instead of loadstring
loadstring = loadstring or load

set = (s) -> 's'..s

updaters =
    ['*']: (acc, k,v) -> acc[k] = v
    [set 'v']: (acc, k, v) -> acc[v] = true
    [set 'k']: (acc, k, v) -> acc[k] = true

cond_header = 'args = {...} k,v = args[1], args[2] return '

create_condition = (where) ->
    return switch type where
        when 'nil'
            (k,v) -> return true
        when 'function'
            where
        when 'string'
            assert loadstring cond_header..where
        when 'table'
            assert loadstring cond_header..table.concat where, ' or '

select = (args) ->
    import from_, where, meta from args
    selector = args[1] or '*'

    cond = create_condition where
    append = updaters[selector]
    acc = {}
    for k,v in pairs from_
        if cond k, v
            append acc, k, v
    return acc

return {:select, :set}
