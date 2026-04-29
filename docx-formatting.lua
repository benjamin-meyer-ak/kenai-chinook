-- docx-formatting.lua
-- Applies to DOCX output only.
-- 1. Inserts a page break before every level-2 heading.
-- 2. Renders date above author name in the title block.
--    (Pandoc's DOCX template always places author before date, so we prepend
--    the date to the author list and clear the date field.)

function Header(el)
  if FORMAT:match("docx") and el.level == 2 then
    return {
      pandoc.RawBlock("openxml", "<w:p><w:r><w:br w:type=\"page\"/></w:r></w:p>"),
      el
    }
  end
end

function Meta(meta)
  if FORMAT:match("docx") and meta.date ~= nil then
    local authors = {}
    if meta.author ~= nil then
      if meta.author.t == "MetaList" then
        for _, a in ipairs(meta.author) do
          table.insert(authors, a)
        end
      else
        table.insert(authors, meta.author)
      end
    end
    -- Date first, then author(s)
    local new_list = { meta.date }
    for _, a in ipairs(authors) do
      table.insert(new_list, a)
    end
    meta.author = pandoc.MetaList(new_list)
    meta.date = pandoc.MetaInlines({})
    return meta
  end
end
