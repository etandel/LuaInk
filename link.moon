cond_header = 'args = {...} k,v = args[1], args[2] return '
select = (args) ->
    import from_, where, meta from args
    cond = ''
    if type(where) == 'string'
        cond = assert loadstring cond_header..where
    else
        cond = assert loadstring cond_header..table.concat where

    return {k,v for k,v in pairs from_ when cond(k, v)}
        
return {:select}
