semirings
==========

Haskellers are usually familiar with monoids and semigroups. A monoid has an appending operation `<>` or `mappend` and an identity element `mempty`. A semigroup has an append `<>`, but does not require an `mempty` element.

A Semiring has two appending operations, 'plus' and 'times', and two respective identity elements, 'zero' and 'one'.

More formally, A semiring <i>R</i> is a set equipped with two binary relations 'plus' and 'times', such that:

- (R, plus) is a commutative monoid with identity element zero:
  - (a `plus` b) `plus` c = a `plus` (b `plus` c)
  - zero `plus` a = a `plus` zero = a
  - a `plus` b = b `plus` a
- (R, times) is a monoid with identity element one:
  - (a `times` b) `times` c = a `times` (b `times` c)
  - one `times a = a `times` one = a
- Multiplication (application of 'times') left and right distributes over Addition (application of 'plus')
  - a `times` (b `plus` c) = (a `times` b) + (a `times` c)
  - (a `plus` b) `times` c = (a `times` c) + (b `times` c)
- Multiplication by 'zero' annihilates R:
  - zero `times` a = a `times` zero = zero
