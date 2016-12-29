function onViewOpen(view)
	if view.Buf:FileType() == "rust" then
		SetLocalOption("tabstospaces", "on", view)
		SetLocalOption("tabsize", "4", view)
	end
end

function rustfmt()
	CurView():Save(false)

	local p = io.popen("rustfmt " .. CurView().Buf.Path)
	p:read("*a")
	p:close()

	CurView():ReOpen()
end

function onSave(view)
	if CurView().Buf:FileType() == "rust" then
		rustfmt()
	end
end
