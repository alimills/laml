package fixtures {
	import laml.display.Button;
	

	public class CustomButton extends Button {
		[Embed(source="assets/Play1Normal.png")]
		public var CustomButtonUp:Class;

		[Embed(source="assets/Play1Hot.png")]
		public var CustomButtonOver:Class;

		[Embed(source="assets/Play1Pressed.png")]
		public var CustomButtonDown:Class;
		
//		[Embed(source="images/Play1Disabled.png")]

		override protected function initialize():void {
			super.initialize();
			width = 24;
			height = 24;
		}
	}
}