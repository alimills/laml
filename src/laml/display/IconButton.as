package laml.display {
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import laml.xml.LAMLParser;
	
	public class IconButton extends Button {
		private var classId:String = generateId();
		private var ICON:String = classId + "_icon_button_icon";
		private var LABEL:String = classId + "_icon_button_label";
		private var ICON_CONTAINER:String = classId + "_icon_container";
		
		private var iconComponent:Image;
		private var iconContainer:Component;
		private var label:Label;
		
		override protected function initialize():void {
			super.initialize();
			model.validate_icon = validateIcon;
			model.validate_text = validateText;
			model.validate_textFormat = validateTextFormat;
			model.validate_selectable = validateSelectable;
			model.validate_embedFonts = validateEmbedFonts;
			text = "";
		}

		override protected function createChildren():void {
			super.createChildren();
			var parsedXml:Component = parser.parseLayoutable(configXml, skin) as Component;
			addChild(parsedXml);
			configureChildren();
			textFormat = getTextFormat();
		}
		
		protected function configureChildren():void {
			iconComponent = getChildById(ICON) as Image;
			label = getChildById(LABEL) as Label;

			iconContainer = getChildById(ICON_CONTAINER) as Component;
			// TODO: not accessing the view directly results in not taking the
			// children's size into consideration - maybe a missed invalidate call?
			iconContainer.view.mouseEnabled = false;
			iconContainer.view.mouseChildren = false;
		}
		
		override protected function commitProperties():void {
			super.commitProperties();
			if(!iconComponent.source) {
				iconContainer.removeChild(iconComponent);
			}
		}

		public function set icon(icon:String):void {
			model.icon = icon;
		}
		
		public function get icon():String {
			return model.icon;
		}
		
		public function set url(url:String):void {
			model.url = url;
		}
		
		public function get url():String {
			return model.url;
		}
		
		protected function validateIcon(newValue:*, oldValue:*):void {
			iconComponent.source = getBitmapByName(newValue) as Bitmap;
			iconComponent.render();
		}
		
		public function set text(text:String):void {
			model.text = text;
		}
		
		public function get text():String {
			return label.text;
		}
		
		protected function validateText(newValue:*, oldValue:*):void {
			label.text = newValue;
		}
		
		public function set textFormat(textFormat:TextFormat):void {
			model.textFormat = textFormat;
		}
		
		public function get textFormat():TextFormat {
			return label.textFormat;
		}
		
		protected function validateTextFormat(newValue:*, oldValue:*):void {
			label.textFormat = newValue;
		}

		public function set selectable(selectable:Boolean):void {
			model.selectable = selectable;
		}

		public function get selectable():Boolean {
			return label.selectable;
		}
		
		protected function validateSelectable(newValue:*, oldValue:*):void {
			label.selectable = newValue;
		}
		
		public function set embedFonts(embedFonts:Boolean):void {
			model.embedFonts = embedFonts;
		}
		
		public function get embedFonts():Boolean {
			return label.embedFonts;
		}
		
		protected function validateEmbedFonts(newValue:*, oldValue:*):void {
			label.embedFonts = newValue;
		}			

		protected function get configXml():XML {
			var xml:XML = <HBox id={ICON_CONTAINER} width="100%" height="100%" gutter="4" xmlns="laml.display">
							<Image id={ICON} width="~1" height="~1"></Image>
							<Label id={LABEL} width="100%" height="100%"></Label>
						</HBox>;
			return xml;
		}
	}
}
