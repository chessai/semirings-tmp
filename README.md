semirings
==========

Haskellers are usually familiar with monoids and semigroups. A monoid has an appending operation `<>` or `mappend` and an identity element `mempty`. A semigroup has an append `<>`, but does not require an `mempty` element.

A Semiring has two appending operations, 'plus' and 'times', and two respective identity elements, 'zero' and 'one'.

More formally, A semiring <i>R</i> is a set equipped with two binary relations + and *, such that:

- (R, +) is a commutative monoid with identity element 0:
  - (a + b) + c = a + (b + c)
  - 0 + a = a + 0 = a
  - a + b = b + a
- (R, *) is a monoid with identity element 1:
  - (a * b) * c = a * (b * c)
  - 1 * a = a * 1 = a
- Multiplication left and right distributes over addition
  - a * (b + c) = (a * b) + (a * c)
  - (a + b) * c = (a * c) + (b * c)
- Multiplication by '0' annihilates R:
  - 0 * a = a * 0 = 0
