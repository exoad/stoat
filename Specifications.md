# Stoat Language Specifications

**Version:** 1.0
**Date:** February 2025

## Hello World Example

```
{
   __main__
        #HelloWorld:
            Stream::void _;
}
{
    mymodel
        #AdditionFunction(a,b):
            ::int   a + b;
        #SubtractionFunction(a,b):
            ::int   a - b;
        #FactorialFunction(n):
            Condition::bool    n == 1 or n == 0
            IF(Condition == TRUE)
                ::int   1
            ELIF(Condition == FALSE)
                ::int   n * FactorialFunction(n-1)
        #Swap(a,b):
            Temp::int   a
            @a::int b
            @b::int Temp
}
{
    assets/textures/Player{__INDEX__}.png
        Dim::size   32,32;
        CacheDim::size  32,32;
}
```