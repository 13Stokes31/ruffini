// =============================================================================
//  ruffini · Synthetic division (Ruffini's rule) tableaux for Typst
//
//  Two public functions:
//    · ruffini(coefficients, root)          — one division P(x) ÷ (x - a),
//        rendered as the classic THREE-row tableau (coefficients · products ·
//        results), remainder boxed, with an optional "quotient / remainder" line.
//    · ruffini-factor(coefficients, roots)  — the stacked tableau that applies
//        several roots in turn (each quotient feeds the next division), with an
//        optional factorization line.
//
//  Unlike a sign/variation table, this actually COMPUTES: you pass the
//  coefficients and the root, and it does the arithmetic AND draws it.
//
//  No dependencies (native `table`). Public API in English; the few rendered
//  words are localizable via `lang` ("en" default, "es").
//
//  Divisor convention: `root` is the number `a` in the divisor `(x - a)`.
//  To divide by (x + 3), pass `root: -3`.
// =============================================================================

#let _blue = rgb("#2e5fa3")

// Format a number: integers as integers, otherwise rounded to 2 decimals.
#let _fmt-num(v) = {
  let r = calc.round(v, digits: 2)
  if calc.abs(r) < 1e-9 { r = 0 }
  if calc.round(r) == r { str(calc.round(r)) } else { str(r) }
}

// A number as math content (proper minus sign, no trailing ".0").
#let _mnum(v) = eval(_fmt-num(v), mode: "math")

// A polynomial (coefficients highest-degree first) as math content.
// Powers are always braced (`x^(10)`) so degrees ≥ 10 render correctly.
#let _poly(coeffs, var: "x") = {
  let deg = coeffs.len() - 1
  let terms = ()
  for (i, c) in coeffs.enumerate() {
    if c == 0 { continue }
    let p = deg - i
    let mag = calc.abs(c)
    let coef = if p == 0 { _fmt-num(mag) } else if mag == 1 { "" } else { _fmt-num(mag) }
    let power = if p == 0 { "" } else if p == 1 { var } else { var + "^(" + str(p) + ")" }
    terms.push((neg: c < 0, body: coef + power))
  }
  if terms.len() == 0 { return $0$ }
  let s = ""
  for (j, t) in terms.enumerate() {
    if j == 0 { s = (if t.neg { "-" } else { "" }) + t.body } else {
      s = s + (if t.neg { " - " } else { " + " }) + t.body
    }
  }
  eval(s, mode: "math")
}

// A monic linear factor "(x - r)" as a math string (used to build factorizations).
#let _linfac(r) = {
  if r == 0 { "x" } else if r < 0 { "(x + " + _fmt-num(calc.abs(r)) + ")" } else { "(x - " + _fmt-num(r) + ")" }
}

// Pad a row of cells to `width` with empty cells.
#let _pad(row, width) = {
  let r = row
  while r.len() < width { r.push([]) }
  r
}

// One synthetic division of `coeffs` by `(x - a)`.
// Returns (products, results): `results` is the quotient's coefficients followed
// by the remainder; `products.at(i)` sits under `coeffs.at(i + 1)`.
#let _divide(coeffs, a) = {
  let results = (coeffs.at(0),)
  let products = ()
  for i in range(1, coeffs.len()) {
    let p = a * results.at(i - 1)
    products.push(p)
    results.push(coeffs.at(i) + p)
  }
  (products, results)
}

// Rendered strings, keyed by `lang`. Add a language by copying a block.
#let _i18n = (
  en: (quotient: "Quotient:", remainder: "Remainder:", factorization: "Factorization:", not-exact: "not an exact division (nonzero remainder)."),
  es: (quotient: "Cociente:", remainder: "Resto:", factorization: "Factorización:", not-exact: "no es una división exacta (resto no nulo)."),
)

/// Ruffini's rule: divide `P(x)` (given by its `coefficients`, highest degree
/// first, INCLUDING zeros for missing terms) by the binomial `(x - root)`.
///
/// Renders the classic three-row tableau and, by default, a line with the
/// quotient and remainder.
///
/// - coefficients (array): P(x)'s coefficients, highest degree first. Include
///   zeros for missing terms, e.g. `x^3 - 2x^2 + 1` → `(1, -2, 0, 1)`.
/// - root (number): the `a` in the divisor `(x - a)`. For `(x + 3)`, pass `-3`.
/// - lang (str): language of the rendered words, `"en"` (default) or `"es"`.
/// - color (color): accent color for the rule and the remainder box.
/// - show-result (bool): append the "quotient / remainder" line (default `true`).
/// - highlight-remainder (bool): box the remainder cell (default `true`).
#let ruffini(
  coefficients,
  root,
  lang: "en",
  color: _blue,
  show-result: true,
  highlight-remainder: true,
) = {
  assert(type(coefficients) == array and coefficients.len() >= 2,
    message: "ruffini: `coefficients` must be an array of at least two numbers (highest degree first).")
  let S = _i18n.at(lang, default: _i18n.en)
  let width = coefficients.len() + 1

  let (products, results) = _divide(coefficients, root)
  let quotient = results.slice(0, -1)
  let remainder = results.at(-1)

  // three rows -------------------------------------------------------------
  let row-coeffs = _pad(([],) + coefficients.map(_mnum), width)
  let row-prod = _pad((_mnum(root), []) + products.map(_mnum), width)
  let row-res = ([],) + results.enumerate().map(((i, b)) => {
    let m = _mnum(b)
    if highlight-remainder and i == results.len() - 1 {
      table.cell(stroke: 0.7pt + color, m) // remainder cell, boxed by the table itself
    } else { m }
  })
  row-res = _pad(row-res, width)

  align(center, table(
    columns: width,
    align: center + horizon,
    inset: 6pt,
    stroke: none,
    ..row-coeffs,
    ..row-prod,
    ..row-res,
    table.vline(x: 1, stroke: 0.7pt + color),
    table.hline(y: 2, start: 0, stroke: 0.7pt + color), // runs under the root too
  ))

  if show-result {
    align(center, block(above: 8pt, [
      #S.quotient $C(x) = #_poly(quotient)$ \
      #S.remainder $R = #_mnum(remainder)$
    ]))
  }
}

/// Extended Ruffini: apply several `roots` in turn, each division acting on the
/// previous quotient. Renders the stacked staircase tableau and, if every
/// division is exact, a factorization line.
///
/// - coefficients (array): P(x)'s coefficients, highest degree first (with zeros).
/// - roots (array): the successive values `a` to divide by, in order.
/// - lang (str): `"en"` (default) or `"es"`.
/// - color (color): accent color for the rules.
/// - show-result (bool): append the factorization line (default `true`).
#let ruffini-factor(
  coefficients,
  roots,
  lang: "en",
  color: _blue,
  show-result: true,
) = {
  assert(type(coefficients) == array and coefficients.len() >= 2,
    message: "ruffini-factor: `coefficients` must be an array of at least two numbers.")
  assert(type(roots) == array and roots.len() >= 1,
    message: "ruffini-factor: `roots` must be a non-empty array.")
  let S = _i18n.at(lang, default: _i18n.en)
  let width = coefficients.len() + 1

  let cells = _pad(([],) + coefficients.map(_mnum), width)
  let hlines = ()
  let row = 1 // next row index to be written

  let current = coefficients
  let remainders = ()
  for r in roots {
    let L = current.len()
    let (products, results) = _divide(current, r)
    cells += _pad((_mnum(r), []) + products.map(_mnum), width) // product row
    row += 1
    cells += _pad(([],) + results.map(_mnum), width) // result row
    hlines.push(table.hline(y: row, start: 0, end: L + 1, stroke: 0.7pt + color)) // under the root too
    row += 1
    remainders.push(results.at(-1))
    current = results.slice(0, -1)
    if current.len() == 0 { break }
  }

  align(center, table(
    columns: width,
    align: center + horizon,
    inset: 6pt,
    stroke: none,
    ..cells,
    table.vline(x: 1, stroke: 0.7pt + color),
    ..hlines,
  ))

  if show-result {
    let exact = remainders.all(v => calc.abs(v) < 1e-9)
    let line = if not exact {
      [#S.factorization #S.not-exact]
    } else {
      // Monic factors (x - r) for each root applied; the final quotient `current`
      // carries P's leading coefficient (division by monic binomials preserves it).
      let factors = roots.slice(0, remainders.len()).map(_linfac).join("")
      if current.len() == 1 {
        // fully factored into linear factors; `current` is the leading constant
        let lead = current.at(0)
        let head = if lead == 1 { "" } else { _fmt-num(lead) + " " }
        [#S.factorization $ P(x) = #eval(head + factors, mode: "math") $]
      } else {
        // an irreducible-here quotient remains
        [#S.factorization $ P(x) = #eval(factors, mode: "math") (#_poly(current)) $]
      }
    }
    align(center, block(above: 8pt, line))
  }
}
