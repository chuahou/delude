######
delude
######

|License: MIT|

*Simple Prelude replacement for toy programs*

A simple ``Prelude`` replacement, aiming to bring unsafe partial
functions out of scope, and bring in replacements work as suitable
replacements, such as ``readMaybe`` instead of ``read``, and
``head``/``tail`` that return ``Maybe`` values.

Haddock documentation can be found
`on GitHub pages <https://chuahou.dev/delude/Delude.html>`_.

Why another ``Prelude`` replacement?
====================================

As a beginner learning Haskell, I do not know enough to evaluate and
choose an existing ``Prelude`` replacement. Instead, I am writing this
in the meantime to get more familiar with what problems I have with the
``Prelude``, so I may better choose an existing, tested replacement in
the future.

This is meant for use in toy programs and so on, and should definitely
**not** be used in any real development.

Should I use this?
==================

**No.**

Benchmarks
==========

Benchmark results using ``criterion`` can be found in text in
`bench.txt <bench.txt>`_, and online on
`chuahou.dev <https://chuahou.dev/delude/bench.html>`_.

A short commentary:

* *Terrible* performance deprovements in ``foldr1``, ``foldl1``,
  ``maximum``, ``minimum``, presumably due to propagation of ``Maybe``.
* Negligible performance change for ``foldr1'``, ``foldl1'``,
  ``maximum'``, ``minimum'`` as they don't do anything extra.
* *Great* performance improvements for ``sum`` and ``product`` using
  strict ``foldl'`` in place of ``foldMap``.
* Some small performance degradation for ``head`` and ``tail``,
  as there is some ``Maybe`` overhead, probably.
* Larger performance degradation for ``last``, as it needs to traverse
  the list.
* Sizable performance degradation for ``init`` due to a large number of
  ``fmap``-ed conses.
* Lastly, a sizable performance degradation for ``(!?)``, since it's
  just naïve recursion.

.. |License: MIT| image:: https://img.shields.io/badge/License-MIT-yellow.svg
	:target: https://opensource.org/licenses/MIT
