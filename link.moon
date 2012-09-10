cond_header = 'args = {...} k,v = args[1], args[2] return '

set = (s) -> 'l'..s

updaters =
    ['*']: (acc, k,v) -> acc[k] = v
    [set 'v']: (acc, k, v) -> acc[v] = true

select = (args) ->
    import from_, where, meta from args
    selector = args[1] or '*'

    cond = ''
    if type(where) == 'string'
        cond = assert loadstring cond_header..where
    else
        cond = assert loadstring cond_header..table.concat where, ' or '

    append = updaters[selector]
    acc = {}
    for k,v in pairs from_
        if cond k, v
            append acc, k, v
    return acc

--    return {k,v for k,v in pairs from_ when cond(k, v)}
        
return {:select, :set}
