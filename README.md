# DITA Community CSS PDF Transform

Experimental Open Toolkit plugin that uses HTML + CSS for pagination using any CSS pagination engine (Antenna House, Prince, Vivliostyle, etc.).

## Processing Approach

This transform generates a single-chunk HTML result from the input map, augmented as needed to support paged layout (mostly generating elements to fill running heads and feet).

The base transform type is HTML5 as the input to the CSS pagination process is HTML5, not the DITA XML in some pre-digested form. 

This approach of using HTML5 simplifies the CSS styling requirements and satisfies the limitations of CSS processors that only accept HTML as input. This also allows sharing of CSS between Web and print deliverables.

## Transtype Details

Transtype name: dc-css-pdf

### Options

- page.size: Specifies the page size, e.g. "a4", "us-letter", "6x9". 
- doc.style: The overall document style, e.g. "generic", "large-type", etc.

The page.size and doc.style values are combined to construct the name of the top-level CSS file.

- pdf.formatter: The PDF formatter to target, one of:
  - ah: Antenna House Formatter
  - prince: Prince
  - vivliostyle: Vivliostyle renderer
  - pdfreactor: PDF Reactor engine
  - browser: No specific formatter (open generated HTML in browser)
