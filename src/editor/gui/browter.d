module editor.gui.browter;

import basics.globals;
import file.language;
import gui;
import gui.picker;

class TerrainBrowser : Window {
private:
    ImagePicker _picker;
    TextButton _cancel;

public:
    this()
    {
        super(new Geom(0, 0, Geom.screenXlg, Geom.mapYlg, From.TOP),
            Lang.addTerrain.transl);
        _cancel = new TextButton(
            new Geom(20, 20, 80, 40, From.BOTTOM_RIGHT),
            Lang.commonCancel.transl);
        addChild(_cancel);
        _picker = new ImagePicker(new Geom(20, 40, xlg - 140, ylg - 60));
        addChild(_picker);
        _picker.basedir = dirImages;
        _picker.currentDir = new Filename("./images/simon/");
    }

    bool   done()       const { return chosenTile != null || _cancel.execute; }
    string chosenTile() const { return null; }
}
