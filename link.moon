cond_header = 'args = {...} k,v = args[1], args[2] return '

list = (s) -> 'l'..s

updaters =
    ['*']: (acc, k,v) -> acc[k] = v
    [list 'v']: (acc, k, v) -> acc[#acc+1] = v

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
        
return {:select, :list}
