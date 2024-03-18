repeat wait() until Library and Utility

Utility:Notify({
    Title = "GameShark",
    Description = "User Interface \n{\n    Static: <b>Paragraph</b>\n}\nloaded.",
    Time = 10,
})

return function(self, cfg)
    cfg = cfg or {}

    Utility:Default(cfg, {
        Title = "Test Paragraph!",
        Description = "Hi this is a paragraph. 1. Hi\n2. Bye",
    })

    local Paragraph = {}

    local ParagraphBackground = Library:New("Frame", {
        Name = "ParagraphBackground",
        Parent = self.Section,
        Theme = "ItemBackground",
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Size = UDim2.new(1, 0, 0, 34),    
        AutomaticSize = Enum.AutomaticSize.Y,   
    })
    
    Library:New("UICorner", ParagraphBackground)

    Library:New("UIListLayout", {
        Parent = ParagraphBackground,
        SortOrder = Enum.SortOrder.LayoutOrder,
    })

    local TitleText = Library:New("TextLabel", {
        Name = "TitleText",
        Parent = ParagraphBackground,
        BackgroundTransparency = 1.000,
        Font = Enum.Font.GothamBold,
        Text = cfg.Title,
        Theme = "Text",
        TextSize = 12.000,
        TextWrapped = true,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        TextXAlignment = Enum.TextXAlignment.Left,
    })

    Library:New("UIPadding", {
        Parent = TitleText,
        PaddingBottom = UDim.new(0, 5),
        PaddingLeft = UDim.new(0, 10),
        PaddingRight = UDim.new(0, 10),
        PaddingTop = UDim.new(0, 10),
    })

    local DescriptionText = Library:New("TextLabel", {
        Name = "DescriptionText",
        Parent = ParagraphBackground,
        BackgroundTransparency = 1.000,
        Size = UDim2.new(1, 0, 0, 0),
        Font = Enum.Font.Gotham,
        Text = cfg.Description,
        Theme = "Text",
        TextSize = 12.000,
        TextWrapped = true,
        AutomaticSize = Enum.AutomaticSize.Y,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
    })

    Library:New("UIPadding", {
        Parent = DescriptionText,
        PaddingLeft = UDim.new(0, 10),
        PaddingBottom = UDim.new(0, 10),
    })

    function Paragraph:ChangeTitle(text)
        TitleText.Text = text
    end

    function Paragraph:ChangeDescription(text)
        DescriptionText.Text = text
    end

    return Paragraph
end