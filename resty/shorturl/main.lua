

local table_insert = table.insert
local table_concat = table.concat
local math_floor = math.floor
local ffi      = require "ffi"
local ffi_cast = ffi.cast
local C        = ffi.C
local tonumber = tonumber
local math_random = math.random
local ngx_now = ngx.now
local math_randomseed = math.randomseed

ffi.cdef[[
typedef unsigned char u_char;
uint32_t ngx_murmur_hash2(u_char *data, size_t len);
]];


local _M = {
    base_table = {
        '0','1','2','3','4','5','6','7','8','9',
        'a','b','c','d','e','f','g','h','i','j','k','l','m',
        'n','o','p','q','r','s','t','u','v','w','x','y','z',
        'A','B','C','D','E','F','G','H','I','J','K','L','M',
        'N','O','P','Q','R','S','T','U','V','W','X','Y','Z',
        '_'
    },
    random_table = {
        'e','Q','W','3','s','5','R','J','a','g',
        'M','T','7','n','O','X','8','f','2','o','z','w','G',
        'K','x','D','Z','F','b','u','N','L','S','l','Y','V',
        'I','t','4','q','6','A','y','1','i','B','C','c','P',
        '0','U','r','k','j','m','p','9','h','v','d','E','H',
        '_'
    },
    SCALE = 62,
}

function _M.mmh2(value)
    return C.ngx_murmur_hash2(ffi_cast('uint8_t *', value), #value)
end

function _M.from10to64(number)
    local result = {}
    local tmp = 0

    if number == 0 then
        table_insert(result, _M.random_table[number + 1])
    else

        for i = 1, _M.SCALE do
            if number > 0 then
                tmp = number % _M.SCALE
                table_insert(result, _M.random_table[tmp + 1])
                number = math_floor(number / _M.SCALE)
            else
                break
            end
        end

    end

    return table_concat(result, "")

end

function _M.short(s)
    local n = 0
    local tmp = _M.mmh2(s)

    n = tonumber(tmp)

    return _M.from10to64(n)

end

return _M





