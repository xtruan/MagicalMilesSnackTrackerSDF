import Toybox.Activity;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;

class ThemeParkSnacksView extends WatchUi.SimpleDataField {

	hidden var ICE_CREAM_BAR_CALS = 330.0f;
	hidden var CHURRO_CALS = 240.0f;
	hidden var SOFT_PRETZEL_CALS = 500.0f;
	hidden var DOLE_WHIP_CALS = 110.0f;
	hidden var TURKEY_LEG_CALS = 1000.0f;
	
	hidden var mCalories = 0.0f;
	hidden var mDisplayItem = 0;

    hidden var mIceCreamBarField;
    hidden var mChurroField;
    hidden var mSoftPretzelField;
    hidden var mDoleWhipField;
    hidden var mTurkeyLegField;
    
    hidden var ICE_CREAM_BAR_FIELD = 0;
	hidden var CHURRO_FIELD = 1;
	hidden var SOFT_PRETZEL_FIELD = 2;
	hidden var DOLE_WHIP_FIELD = 3;
	hidden var TURKEY_LEG_FIELD = 4;

    function initialize() {
        SimpleDataField.initialize();
        
                mIceCreamBarField = createField(
        	WatchUi.loadResource(Rez.Strings.snack_one),
            ICE_CREAM_BAR_FIELD,
            FitContributor.DATA_TYPE_FLOAT,
            {:mesgType=>FitContributor.MESG_TYPE_SESSION, 
             :units=>WatchUi.loadResource(Rez.Strings.snack_one_unit)}
        );
        mIceCreamBarField.setData(0.0);
        
        mChurroField = createField(
        	WatchUi.loadResource(Rez.Strings.snack_two),
            CHURRO_FIELD,
            FitContributor.DATA_TYPE_FLOAT,
            {:mesgType=>FitContributor.MESG_TYPE_SESSION, 
             :units=>WatchUi.loadResource(Rez.Strings.snack_two_unit)}
        );
        mChurroField.setData(0.0);
        
        mSoftPretzelField = createField(
        	WatchUi.loadResource(Rez.Strings.snack_thr),
            SOFT_PRETZEL_FIELD,
            FitContributor.DATA_TYPE_FLOAT,
            {:mesgType=>FitContributor.MESG_TYPE_SESSION, 
             :units=>WatchUi.loadResource(Rez.Strings.snack_thr_unit)}
        );
        mSoftPretzelField.setData(0.0);
        
        mDoleWhipField = createField(
        	WatchUi.loadResource(Rez.Strings.snack_fou),
            DOLE_WHIP_FIELD,
            FitContributor.DATA_TYPE_FLOAT,
            {:mesgType=>FitContributor.MESG_TYPE_SESSION, 
             :units=>WatchUi.loadResource(Rez.Strings.snack_fou_unit)}
        );
        mDoleWhipField.setData(0.0);
        
        mTurkeyLegField = createField(
        	WatchUi.loadResource(Rez.Strings.snack_fiv),
            TURKEY_LEG_FIELD,
            FitContributor.DATA_TYPE_FLOAT,
            {:mesgType=>FitContributor.MESG_TYPE_SESSION, 
             :units=>WatchUi.loadResource(Rez.Strings.snack_fiv_unit)}
        );
        mTurkeyLegField.setData(0.0);
        
        // set label
        label = WatchUi.loadResource(Rez.Strings.label);
    }

    // The given info object contains all the current workout information.
    // Calculate a value and save it locally in this method.
    // Note that compute() and onUpdate() are asynchronous, and there is no
    // guarantee that compute() will be called before onUpdate().
    function compute(info as Activity.Info) as Numeric or Toybox.Time.Duration or String or Null {
        // See Activity.Info in the documentation for available information.
        // Get calories if available.
        if (info has :calories) {
            if (info.calories != null) {
                mCalories = info.calories;
            }
        } else {
        	return WatchUi.loadResource(Rez.Strings.err_no_calorie_info);
        }
        
        // Set data field with calories and multiplier.
        mIceCreamBarField.setData(mCalories / ICE_CREAM_BAR_CALS);
        mChurroField.setData(mCalories / CHURRO_CALS);
        mSoftPretzelField.setData(mCalories / SOFT_PRETZEL_CALS);
        mDoleWhipField.setData(mCalories / DOLE_WHIP_CALS);
        mTurkeyLegField.setData(mCalories / TURKEY_LEG_CALS);
        
        return getDisplayText();
    }

	function getDisplayText() as String {
    	mDisplayItem++;
		if (mDisplayItem > 5*5) {
			mDisplayItem = 1;
		}
        
        if (mDisplayItem <= 1*5) {
        	return (mCalories / ICE_CREAM_BAR_CALS).format("%.1f") + WatchUi.loadResource(Rez.Strings.snack_one_unit_sm);
        } else if (mDisplayItem <= 2*5) {
        	return (mCalories / CHURRO_CALS).format("%.1f") + WatchUi.loadResource(Rez.Strings.snack_two_unit_sm);
        } else if (mDisplayItem <= 3*5) {
        	return (mCalories / SOFT_PRETZEL_CALS).format("%.1f") + WatchUi.loadResource(Rez.Strings.snack_thr_unit_sm);
        } else if (mDisplayItem <= 4*5) {
        	return (mCalories / DOLE_WHIP_CALS).format("%.1f") + WatchUi.loadResource(Rez.Strings.snack_fou_unit_sm);
        } else if (mDisplayItem <= 5*5) {
			return (mCalories / TURKEY_LEG_CALS).format("%.1f") + WatchUi.loadResource(Rez.Strings.snack_fiv_unit_sm);
		} else {
			return "";
		}
    }

}
