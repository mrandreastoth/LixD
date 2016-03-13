module gui.picker.tilerimg;

// this is used in the editor's terrain browser.

import std.conv;
import std.string;
import std.typecons;

import graphic.textout;
import gui;
import gui.picker.tiler;
import level.level;
import tile.tilelib;
import tile.platonic;

class ImageTiler : Tiler {
public:
    enum buttonsPerPageX = 8;
    enum buttonsPerPageY = 6;
    this(Geom g) { super(g); }

protected:
    override @property int pageLen() const
    {
        return buttonsPerPageX * buttonsPerPageY;
    }

    override TextButton newDirButton(Filename fn)
    {
        assert (fn);
        return new TextButton(new Geom(0, 0,
            xlg / buttonsPerPageX * dirSizeMultiplier,
            ylg / buttonsPerPageY), fn.dirInnermost);
    }

    override TerrainBrowserButton newFileButton(Filename fn, in int fileID)
    {
        assert (fn);
        return new TerrainBrowserButton(new Geom(0, 0,
            xlg / buttonsPerPageX,
            ylg / buttonsPerPageY), fn);
    }

    override float buttonXg(in int idFromTop) const
    {
        return xlg * (idFromTop % buttonsPerPageX) / buttonsPerPageX;
    }

    override float buttonYg(in int idFromTop) const
    {
        return ylg * (idFromTop / buttonsPerPageX) / buttonsPerPageY;
    }
}

class TerrainBrowserButton : Button {
private:
    CutbitElement _cbe;
    Label _text;

public:
    this(Geom g, Filename fn)
    {
        assert (fn);
        super(g);
        Rebindable!(const(Platonic)) tile = get_terrain(fn.rootlessNoExt);
        if (! tile)
            tile = get_gadget(fn.rootlessNoExt);
        if (tile) {
            _cbe = new CutbitElement(new Geom(0, 0, xlg, ylg - 10), tile.cb);
            addChild(_cbe);
        }
        _text = new Label(new Geom(0, 0, xlg, 13, From.BOTTOM),
            fn.fileNoExtNoPre);
        _text.font = djvuS;
        addChild(_text);
    }
}
