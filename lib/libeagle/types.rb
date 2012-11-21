module LibEagle
  module Types
    def Types.Bool
      /^(no|yes)$/i
    end

    def Types.GridUnit
    	/^(mic|mm|mil|inch)$/i
    end

    def Types.GridStyle
    	/^(lines|dots)$/i
    end

    def Types.WireStyle
    	/^(continuous|longdash|shortdash|dashdot)$/i
    end

    def Types.WireCap
    	/^(flat|round)$/i
    end

    def Types.PadShape
    	/^(square|round|octagon|long|offset)$/i
    end

    def Types.ViaShape
    	/^(square|round|octagon)$/i
    end

    def Types.TextFont
    	/^(vector|proportional|fixed)$/i
    end

    def Types.AttributeDisplay
    	/^(off|value|name|both)$/i
    end

    def Types.PolygonPour
    	/^(solid|hatch|cutout)$/i
    end

    def Types.PinVisible
    	/^(off|pad|pin|both)$/i
    end

    def Types.PinLength
    	/^(point|short|middle|long)$/i
    end

    def Types.PinDirection
    	/^(nc|in|out|io|oc|pwr|pas|hiz|sup)$/i
    end

    def Types.PinFunction
    	/^(none|dot|clk|dotclk)$/i
    end

    def Types.GateAddLevel
    	/^(must|can|next|request|always)$/i
    end

    def Types.ContactRoute
    	/^(all|any)$/i
    end

    def Types.DimensionType
    	/^(parallel|horizontal|vertical|radius|diameter|leader)$/i
    end

    def Types.Severity
    	/^(info|warning|error)$/i
    end

    def Types.Align
    	/^(bottom-left|bottom-center|bottom-right|center-left|center|center-right|top-left|top-center|top-right)$/i
    end

    def Types.VerticalText
    	/^(up|down)$/i
    end
  end
end