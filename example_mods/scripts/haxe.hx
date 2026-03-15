/** Variables **/

/**
 * The current stage.
 */
var curStage:String; // assigned through main script
/**
 * The stage position offset.
 */
var stageOffsets:{x:Float, y:Float} // assigned through main script



/** Callbacks **/

/**
 * Called when a stage needs to be precached.
 */
function precacheStage():Void {
	// precache stage object images
}
/**
 * Called when a stage is created.
 * @param snapChanges
 */
function onStageCreation(snapChanges:Bool):Void {
	if (curStage == 'matrix' || curStage == 'matrix-golden' || curStage == 'matrix-red' || curStage == 'matrix-blue - Copy') {
		// create stage objects
	}
}
/**
 * Called when a stage is destroyed.
 * @param snapChanges
 */
function onStageDestruction(snapChanges:Bool):Void {
	if (curStage == 'matrix' || curStage == 'matrix-golden' || curStage == 'matrix-red' || curStage == 'matrix-blue - Copy') {
		// destroy stage objects
	}
}