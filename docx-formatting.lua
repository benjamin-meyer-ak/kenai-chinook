-- docx-formatting.lua
-- Applies to DOCX output only.
-- Inserts a page break before every level-2 heading.

function Header(el)
  if FORMAT:match("docx") and el.level == 2 then
    return {
      pandoc.RawBlock("openxml", "<w:p><w:r><w:br w:type=\"page\"/></w:r></w:p>"),
      el
    }
  end
end
