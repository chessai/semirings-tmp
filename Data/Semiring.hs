{-# OPTIONS_GHC -Wall #-}

module Data.Semiring 
  ( Semiring(..)
  , (+++)
  , (***)
  ) where

import           Control.Applicative (Applicative(..), Const(..))
import           Data.Bool (Bool(..), (||), (&&))
import           Data.Int (Int, Int8, Int16, Int32, Int64)
--import           Data.Ord (Ordering)
import           Data.Maybe
import           Data.Monoid
import           Data.Word (Word, Word8, Word16, Word32, Word64)
import qualified Prelude as P
import           Prelude (Double, Float)
import           Prelude (IO)

(+++), (***) :: Semiring a => a -> a -> a
(+++) = plus
(***) = times

class Semiring a where
  {-# MINIMAL plus, zero, times, one #-}
  plus  :: a -> a -> a -- ^ Associative Additive Operation
  zero  :: a           -- ^ Additive Unit
  times :: a -> a -> a -- ^ Associative Multiplicative Operation
  one   :: a           -- ^ Multiplicative Unit

instance Semiring b => Semiring (a -> b) where
  plus f g x  = f x `plus` g x
  zero        = \_ -> zero
  times f g x = f x `times` g x
  one         = \_ -> one

instance Semiring () where
  plus _ _  = ()
  zero      = ()
  times _ _ = ()
  one       = ()

instance Semiring a => Semiring [a] where
  zero = []
  one  = [one]

  [] `plus` y = y
  x `plus` [] = x
  (x:xs) `plus` (y:ys) = (x `plus` y):(xs `plus` ys)

  [] `times` _ = []
  _  `times` [] = []
  (a:p) `times` (b:q) = (a `times` b):(P.map (a `times`) q `plus` P.map (`times` b) p `plus` (zero:(p `times` q)))

instance (Semiring a, Semiring b) => Semiring (a,b) where
  zero = (zero,zero)
  one = (one,one)
  (a1,b1) `plus` (a2,b2) =
    (a1 `plus` a2, b1 `plus` b2)
  (a1,b1) `times` (a2,b2) =
    (a1 `times` a2, b1 `times` b2)

instance (Semiring a, Semiring b, Semiring c) => Semiring (a,b,c) where
  zero = (zero, zero, zero)
  one = (one,one,one)
  (a1,b1,c1) `plus` (a2,b2,c2) =
    (a1 `plus` a2, b1 `plus` b2, c1 `plus` c2)
  (a1,b1,c1) `times` (a2,b2,c2) =
    (a1 `times` a2, b1 `times` b2, c1 `times` c2)

instance (Semiring a, Semiring b, Semiring c, Semiring d) => Semiring (a,b,c,d) where
  zero = (zero, zero, zero, zero)
  one = (one, one, one, one)
  (a1,b1,c1,d1) `plus` (a2,b2,c2,d2) =
    (a1 `plus` a2, b1 `plus` b2, c1 `plus` c2, d1 `plus` d2)
  (a1,b1,c1,d1) `times` (a2,b2,c2,d2) =
    (a1 `times` a2, b1 `times` b2, c1 `times` c2, d1 `times` d2)

instance (Semiring a, Semiring b, Semiring c, Semiring d, Semiring e) => Semiring (a,b,c,d,e) where
  zero = (zero, zero, zero, zero, zero)
  one = (one, one, one, one, one)
  (a1,b1,c1,d1,e1) `plus` (a2,b2,c2,d2,e2) =
    (a1 `plus` a2, b1 `plus` b2, c1 `plus` c2, d1 `plus` d2, e1 `plus` e2)
  (a1,b1,c1,d1,e1) `times` (a2,b2,c2,d2,e2) =
    (a1 `times` a2, b1 `times` b2, c1 `times` c2, d1 `times` d2, e1 `times` e2)

instance (Semiring a, Semiring b, Semiring c, Semiring d, Semiring e, Semiring f) => Semiring (a,b,c,d,e,f) where
  zero = (zero, zero, zero, zero, zero, zero)
  one  = (one, one, one, one, one, one)
  (a1,b1,c1,d1,e1,f1) `plus` (a2,b2,c2,d2,e2,f2) =
    (a1 `plus` a2, b1 `plus` b2, c1 `plus` c2, d1 `plus` d2, e1 `plus` e2, f1 `plus` f2)
  (a1,b1,c1,d1,e1,f1) `times` (a2,b2,c2,d2,e2,f2) =
    (a1 `times` a2, b1 `times` b2, c1 `times` c2, d1 `times` d2, e1 `times` e2, f1 `times` f2)
 
instance (Semiring a, Semiring b, Semiring c, Semiring d, Semiring e, Semiring f, Semiring g) => Semiring (a,b,c,d,e,f,g) where
  zero = (zero, zero, zero, zero, zero, zero, zero)
  one  = (one, one, one, one, one, one, one)
  (a1,b1,c1,d1,e1,f1,g1) `plus` (a2,b2,c2,d2,e2,f2,g2) =
    (a1 `plus` a2, b1 `plus` b2, c1 `plus` c2, d1 `plus` d2, e1 `plus` e2, f1 `plus` f2, g1 `plus` g2)
  (a1,b1,c1,d1,e1,f1,g1) `times` (a2,b2,c2,d2,e2,f2,g2) =
    (a1 `times` a2, b1 `times` b2, c1 `times` c2, d1 `times` d2, e1 `times` e2, f1 `times` f2, g1 `times` g2)
    
instance (Semiring a, Semiring b, Semiring c, Semiring d, Semiring e, Semiring f, Semiring g, Semiring h) => Semiring (a,b,c,d,e,f,g,h) where
  zero = (zero, zero, zero, zero, zero, zero, zero, zero)
  one  = (one, one, one, one, one, one, one, one)
  (a1,b1,c1,d1,e1,f1,g1,h1) `plus` (a2,b2,c2,d2,e2,f2,g2,h2) =
    (a1 `plus` a2, b1 `plus` b2, c1 `plus` c2, d1 `plus` d2, e1 `plus` e2, f1 `plus` f2, g1 `plus` g2, h1 `plus` h2)
  (a1,b1,c1,d1,e1,f1,g1,h1) `times` (a2,b2,c2,d2,e2,f2,g2,h2) =
    (a1 `times` a2, b1 `times` b2, c1 `times` c2, d1 `times` d2, e1 `times` e2, f1 `times` f2, g1 `times` g2,h1 `times` h2)

instance (Semiring a, Semiring b, Semiring c, Semiring d, Semiring e, Semiring f, Semiring g, Semiring h, Semiring i) => Semiring (a,b,c,d,e,f,g,h,i) where
  zero = (zero, zero, zero, zero, zero, zero, zero, zero, zero)
  one  = (one, one, one, one, one, one, one, one, one)
  (a1,b1,c1,d1,e1,f1,g1,h1,i1) `plus` (a2,b2,c2,d2,e2,f2,g2,h2,i2) =
    (a1 `plus` a2, b1 `plus` b2, c1 `plus` c2, d1 `plus` d2, e1 `plus` e2, f1 `plus` f2, g1 `plus` g2, h1 `plus` h2, i1 `plus` i2)
  (a1,b1,c1,d1,e1,f1,g1,h1,i1) `times` (a2,b2,c2,d2,e2,f2,g2,h2,i2) =
    (a1 `times` a2, b1 `times` b2, c1 `times` c2, d1 `times` d2, e1 `times` e2, f1 `times` f2, g1 `times` g2,h1 `times` h2, i1 `times` i2)

instance (Semiring a, Semiring b, Semiring c, Semiring d, Semiring e, Semiring f, Semiring g, Semiring h, Semiring i, Semiring j) => Semiring (a,b,c,d,e,f,g,h,i,j) where
  zero = (zero, zero, zero, zero, zero, zero, zero, zero, zero, zero)
  one  = (one, one, one, one, one, one, one, one, one, one)
  (a1,b1,c1,d1,e1,f1,g1,h1,i1,j1) `plus` (a2,b2,c2,d2,e2,f2,g2,h2,i2,j2) =
    (a1 `plus` a2, b1 `plus` b2, c1 `plus` c2, d1 `plus` d2, e1 `plus` e2, f1 `plus` f2, g1 `plus` g2, h1 `plus` h2, i1 `plus` i2, j1 `plus` j2)
  (a1,b1,c1,d1,e1,f1,g1,h1,i1,j1) `times` (a2,b2,c2,d2,e2,f2,g2,h2,i2,j2) =
    (a1 `times` a2, b1 `times` b2, c1 `times` c2, d1 `times` d2, e1 `times` e2, f1 `times` f2, g1 `times` g2,h1 `times` h2, i1 `times` i2, j1 `times` j2)

instance Semiring Bool where
  plus  = (||)
  zero  = False
  times = (&&)
  one   = True

instance Semiring Int where
  plus  = (P.+)
  zero  = 0
  times = (P.*)
  one   = 1

instance Semiring Int8 where
  plus  = (P.+)
  zero  = 0
  times = (P.*)
  one   = 1

instance Semiring Int16 where
  plus  = (P.+)
  zero  = 0
  times = (P.*)
  one   = 1

instance Semiring Int32 where
  plus  = (P.+)
  zero  = 0
  times = (P.*)
  one   = 1

instance Semiring Int64 where
  plus  = (P.+)
  zero  = 0
  times = (P.*)
  one   = 1

instance Semiring Double where
  plus  = (P.+)
  zero  = 0
  times = (P.*)
  one   = 1

instance Semiring Float where
  plus  = (P.+)
  zero  = 0
  times = (P.*)
  one   = 1

instance Semiring Word where
  plus  = (P.+)
  zero  = 0
  times = (P.*)
  one   = 1

instance Semiring Word8 where
  plus  = (P.+)
  zero  = 0
  times = (P.*)
  one   = 1

instance Semiring Word16 where
  plus  = (P.+)
  zero  = 0
  times = (P.*)
  one   = 1

instance Semiring Word32 where
  plus  = (P.+)
  zero  = 0
  times = (P.*)
  one   = 1

instance Semiring Word64 where
  plus  = (P.+)
  zero  = 0
  times = (P.*)
  one   = 1

instance Semiring a => Semiring (Maybe a) where
  zero = Just zero
  one  = Just one
  Nothing `plus` m = m
  m `plus` Nothing = m
  Just m1 `plus` Just m2 = Just (m1 `plus` m2)
  Nothing `times` _ = Nothing
  _ `times` Nothing = Nothing
  Just m1 `times` Just m2 = Just (m1 `times` m2)

instance Semiring a => Semiring (IO a) where
  zero  = pure zero
  one   = pure one
  plus  = liftA2 plus
  times = liftA2 times

instance Semiring a => Semiring (Dual a) where
  zero = Dual zero
  Dual x `plus` Dual y = Dual (y `plus` x)
  one = Dual one
  Dual x `times` Dual y = Dual (y `times` x)

instance Semiring a => Semiring (Endo a) where
  zero = Endo (\_ -> zero)
  plus (Endo f) (Endo g) = Endo (f `plus` g)
  one = Endo (\_ -> one)
  times (Endo f) (Endo g) = Endo (f `times` g)

--instance Semiring All where
--instance Semiring Any where
--instance Semiring a => Semiring (Sum a) where
--instance Semiring a => Semiring (Product a) where

--instance Semiring a => Semiring (First a) where
--instance Semiring a => Semiring (Last  a) where

instance (Applicative f, Semiring a) => Semiring (Alt f a) where
  zero  = Alt (pure zero)
  one   = Alt (pure one)
  plus  = liftA2 plus
  times = liftA2 times

instance Semiring a => Semiring (Const a b) where
  zero = Const zero
  one  = Const one
  plus  (Const x) (Const y) = Const (x `plus`  y)
  times (Const x) (Const y) = Const (x `times` y)
