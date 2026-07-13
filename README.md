# ruffini

Typeset **synthetic division (Ruffini's rule)** in [Typst](https://typst.app) — the
classic three-row division box and the stacked factorization staircase.

Unlike a sign or variation table, this **computes**: you pass the coefficients and
the root, and it does the arithmetic *and* draws it — the products row, the running
sums, the boxed remainder. No more hand-building tables and quietly dropping the
middle row. No dependencies (native `table`).

<p align="center">
  <img src="https://raw.githubusercontent.com/13Stokes31/ruffini/main/gallery/g1.png" width="45%" alt="Single division, three-row tableau">
  <img src="https://raw.githubusercontent.com/13Stokes31/ruffini/main/gallery/g2.png" width="45%" alt="Full factorization staircase">
</p>
<p align="center">
  <img src="https://raw.githubusercontent.com/13Stokes31/ruffini/main/gallery/g3.png" width="45%" alt="Leading coefficient not one">
  <img src="https://raw.githubusercontent.com/13Stokes31/ruffini/main/gallery/g4.png" width="45%" alt="Spanish labels">
</p>

## Usage

```typ
#import "@preview/ruffini:0.1.0": ruffini, ruffini-factor

// Divide x³ − 2x² + 1 by (x − 2):
#ruffini((1, -2, 0, 1), 2)
// → three-row tableau; Quotient: C(x) = x²   Remainder: R = 1

// Factor x³ − 6x² + 11x − 6 using its roots 1, 2, 3:
#ruffini-factor((1, -6, 11, -6), (1, 2, 3))
// → stacked staircase; Factorization: P(x) = (x − 1)(x − 2)(x − 3)
```

**Coefficients** go highest degree first and **must include zeros** for missing
terms: `x³ − 2x² + 1` → `(1, -2, 0, 1)`.

**Divisor convention:** `root` is the `a` in `(x − a)`. To divide by `(x + 3)`,
pass `root: -3`.

**Exact fractions.** Arithmetic is exact (rational), not floating-point. Pass any
non-integer value **as a string** so it stays exact and renders as a fraction —
`"1/3"`, `"-3/4"`, both for `root` and inside `coefficients`. (Writing `1/3`
directly would be evaluated to `0.333…` by Typst before the package sees it.)

```typ
#ruffini((2, -1, -1), "-1/2")   // divide by (x + 1/2); shows −1/2 as a fraction
```

**Variable.** The rendered labels use `x` by default; pass `variable: "t"` (or any
letter) to write `C(t)`, `P(z)`, `(t − 2)`, …

## `ruffini(coefficients, root, ...)`

One division `P(x) ÷ (x − root)`, rendered as the three-row tableau
(coefficients · products · results) with the remainder boxed.

| Parameter             | Default      | Meaning |
|-----------------------|--------------|---------|
| `coefficients`        | *(required)* | Array, highest degree first, zeros included. Ints or string fractions (`"1/2"`). |
| `root`                | *(required)* | The `a` in `(x − a)`. Int, or a string fraction like `"1/3"`. |
| `lang`                | `"en"`       | Language of the rendered words: `"en"` or `"es"`. |
| `variable`            | `"x"`        | The polynomial's variable in the rendered labels. |
| `color`               | blue         | Accent color of the L-rule and the remainder box. |
| `show-result`         | `true`       | Append the *Quotient / Remainder* line. |
| `highlight-remainder` | `true`       | Draw the box around the remainder cell. |

## `ruffini-factor(coefficients, roots, ...)`

Applies several `roots` in turn — each quotient becomes the next dividend — and
draws the stacked staircase. If every division is exact, it appends the
factorization; otherwise it says so.

| Parameter     | Default      | Meaning |
|---------------|--------------|---------|
| `coefficients`| *(required)* | Array, highest degree first, zeros included. |
| `roots`       | *(required)* | The successive values `a` to divide by, in order. Ints or string fractions. |
| `lang`        | `"en"`       | `"en"` or `"es"`. |
| `variable`    | `"x"`        | The polynomial's variable in the rendered labels. |
| `color`       | blue         | Accent color of the rules. |
| `show-result` | `true`       | Append the *Factorization* line. |
| `highlight-remainder` | `true` | Box each division's remainder cell. |

The factorization keeps the leading coefficient correct and, when an irreducible
factor of degree ≥ 2 remains, shows it in parentheses — e.g.
`P(x) = (x − 1)(x + 1)(3x + 2)` or `P(x) = (x − 2)(x² + x + 1)`.

## What it handles

| Case | Behavior |
|---|---|
| Exact division | Remainder `0`, boxed; quotient shown. |
| **Nonzero remainder** | Boxed remainder; `R = …` in the result line. |
| Missing terms | Handled via the explicit zero coefficients you pass. |
| **Fractional root / coefficients** | Exact rational arithmetic; rendered as fractions (pass them as strings). |
| Leading coefficient ≠ 1 | Preserved through the staircase and in the factorization. |
| **Irreducible quotient** | `ruffini-factor` stops and shows `(…)` for the remaining factor. |
| Supplied value is not a root | `ruffini-factor` reports "not an exact division". |

## Localization

Rendered words default to English. Pass `lang: "es"` for Spanish
(Cociente / Resto / Factorización). Adding a language is copying one block in the
`_i18n` dictionary in `lib.typ` and translating four words — contributions welcome.

## Compatibility

- Typst `>= 0.14.0`
- No dependencies.

## Known limitations

See [`ROADMAP.md`](ROADMAP.md). In short: it does not *find* the roots for you
(you supply them — that is a root-finding problem, not a layout one), and it
divides only by linear binomials `(x − a)`, which is what Ruffini's rule is for.

## License

[MIT](LICENSE).
