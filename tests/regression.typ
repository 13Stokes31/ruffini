// Regression battery for ruffini.
// Compile-only check: `typst compile --root .. tests/regression.typ out.pdf`
// must succeed; each page is annotated with the expected result.
#import "../lib.typ": ruffini, ruffini-factor
#set page(width: auto, height: auto, margin: 1cm)
#set text(10pt)

// 1. canonical exact division: x^3 - 2x^2 + 1 ÷ (x - 2) → C = x^2, R = 1
#ruffini((1, -2, 0, 1), 2)
#pagebreak()

// 2. divide by (x + 1): x^4 - 3x^2 + 2 ÷ (x + 1) → root = -1, R = 0
#ruffini((1, 0, -3, 0, 2), -1)
#pagebreak()

// 3. nonzero remainder: x^2 + 1 ÷ (x - 3) → C = x + 3, R = 10
#ruffini((1, 0, 1), 3)
#pagebreak()

// 4. fractional root: 2x^2 - x - 1 ÷ (x - 1/2)... use root 0.5 → R = -1
#ruffini((2, -1, -1), 0.5)
#pagebreak()

// 5. options: no result line, no remainder box
#ruffini((1, -2, 0, 1), 2, show-result: false, highlight-remainder: false)
#pagebreak()

// 6. localization (Spanish)
#ruffini((1, -2, 0, 1), 2, lang: "es")
#pagebreak()

// 7. color override
#ruffini((1, -6, 11, -6), 1, color: rgb("#2b8a3e"))
#pagebreak()

// -- ruffini-factor ---------------------------------------------------------

// 8. full factorization: x^3 - 6x^2 + 11x - 6 = (x-1)(x-2)(x-3)
#ruffini-factor((1, -6, 11, -6), (1, 2, 3))
#pagebreak()

// 9. leading coefficient ≠ 1: 3x^3 + 2x^2 - 3x - 2 with roots 1, -1  → 3(...)
#ruffini-factor((3, 2, -3, -2), (1, -1))
#pagebreak()

// 10. partial factorization, irreducible quadratic remains: x^3-x^2-x-2 → (x-2)(x^2+x+1)
#ruffini-factor((1, -1, -1, -2), (2,))
#pagebreak()

// 11. inexact (a supplied value is not a root) → "not an exact division"
#ruffini-factor((1, -6, 11, -6), (1, 5))
#pagebreak()

// 12. factor + Spanish
#ruffini-factor((1, -6, 11, -6), (1, 2, 3), lang: "es")
#pagebreak()

// -- fractions & variable ---------------------------------------------------

// 13. fractional root as a string: 2x^2 - x - 1 ÷ (x + 1/2) → root "-1/2", R = 0
#ruffini((2, -1, -1), "-1/2")
#pagebreak()

// 14. fractional coefficients: (1/2)x^2 - (1/3) with a nonzero remainder
#ruffini(("1/2", 0, "-1/3"), 1)
#pagebreak()

// 15. factor with a fractional root: 2x^2 - x - 1 = 2(x + 1/2)(x - 1)
#ruffini-factor((2, -1, -1), ("-1/2", 1))
#pagebreak()

// 16. custom variable `t`: C(t) = t^2, R = 1
#ruffini((1, -2, 0, 1), 2, variable: "t")
#pagebreak()

// 17. factor with variable `z`
#ruffini-factor((1, -6, 11, -6), (1, 2, 3), variable: "z")
#pagebreak()

// 18. bare-number fraction recovered exactly: root 1/3 (Typst → 0.333…) → ⅓
#ruffini((1, 0, -3), 1/3)
#pagebreak()

// 19. unusual fraction passed as a string stays exact
#ruffini((1, 0, -3), "1/99991", highlight-remainder: false)
// NOTE: `#ruffini((1, 0, -3), 1/99991)` (bare) is EXPECTED to error, on purpose —
// the denominator is too large to recover from a float; use the string form.
#pagebreak()

// -- teaching trail ---------------------------------------------------------

// 20. trail: arrows for bring-down / ×root / column sums
#ruffini((1, -2, 0, 1), 2, trail: true)
#pagebreak()

// 21. trail on a longer polynomial, color + Spanish
#ruffini((1, -6, 11, -6), 1, trail: true, color: rgb("#2b8a3e"), lang: "es")
