# Stoat

**An opinionated programming language focused on dynamic, redundancy-free evaluation primarily designed to act as a versatile, easy-to-use configuration language.**

## "Hello World!" demo

Here is a simple "Hello World!" demo in Stoat.

`Main.sto`
```
{
  _main
    #__MAIN__():
      v::str  hello world;
      PRINTLN(v);   
}
```

## As a configuration Language

`Textures.sto`
```
{
  assets/textures/Player.png
    Dim::rect_sz  32,32;
    CacheDim::rect_sz  32,32;
  assets/textures/Flower_Pot[__INDEX__].png
    Dim::rect_sz 16,16;
    CacheDim::rect_sz 16,16;
}
```

## Legals

The specification is licensed under [The Unlicense](./LICENSE).

All implementations are licensed, respectively, and their licenses can be found in their respective folders.
