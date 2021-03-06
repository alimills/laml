package laml.display {
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	
	public class SelectableButton extends Button {
		protected const SELECTED_UP_STATE:String = "SelectedUp";
		protected const SELECTED_OVER_STATE:String = "SelectedOver";
		protected const SELECTED_DOWN_STATE:String = "SelectedDown";
		protected const SELECTED_HIT_TEST_STATE:String = "SelectedHitTest";
		protected var unselectedButtonView:SimpleButton;
		protected var selectedButtonView:SimpleButton; 
		
		override protected function initialize():void { 
			super.initialize();
			model.validate_upSelectedState = validateUpSelectedState;
			model.validate_overSelectedState = validateOverSelectedState;
			model.validate_downSelectedState = validateDownSelectedState;
			model.validate_selected = validateSelected;
			selected = false;
		}

		override protected function createView():void {
			selectedButtonView = new SimpleButton();
			unselectedButtonView = new SimpleButton();
		}
		
		override protected function createStates():void {
			super.createStates();
			if(defaultUpSelectedState) {
				upSelectedState = defaultUpSelectedState;
			}
			
			if(defaultOverSelectedState) {
				overSelectedState = defaultOverSelectedState;
			}

			if(defaultDownSelectedState) {
				downSelectedState = defaultDownSelectedState;
			}
		}
		
		override protected function commitProperties():void {
			super.commitProperties();
			if(!overSelectedState) {
				overSelectedState = upSelectedState;
			} 
			if(!downSelectedState) {
				downSelectedState = overSelectedState || upSelectedState;
			}
		}

		override protected function updateSize(w:Number, h:Number):void {
			if(selectedButtonView.upState is BasicBackground) {
				BasicBackground(selectedButtonView.upState).draw(w, h);
				BasicBackground(selectedButtonView.overState).draw(w, h);
				BasicBackground(selectedButtonView.downState).draw(w, h);
				BasicBackground(selectedButtonView.hitTestState).draw(w, h);
			}
			else {
				selectedButtonView.width = w;
				selectedButtonView.height = h;
			}

			if(unselectedButtonView.upState is BasicBackground) {
				BasicBackground(unselectedButtonView.upState).draw(w, h);
				BasicBackground(unselectedButtonView.overState).draw(w, h);
				BasicBackground(unselectedButtonView.downState).draw(w, h);
				BasicBackground(unselectedButtonView.hitTestState).draw(w, h);
			}
			else {
				unselectedButtonView.width = w;
				unselectedButtonView.height = h;
			}
		}

		public function set upSelectedState(upSelectedState:DisplayObject):void {
			model.upSelectedState = upSelectedState;
		}
		
		public function get upSelectedState():DisplayObject {
			return model.upSelectedState;
		}
		
		public function set overSelectedState(overSelectedState:DisplayObject):void {
			model.overSelectedState = overSelectedState;
		}
		
		public function get overSelectedState():DisplayObject {
			return model.overSelectedState;
		}
		
		public function set downSelectedState(downSelectedState:DisplayObject):void {
			model.downSelectedState = downSelectedState;
		}
		
		public function get downSelectedState():DisplayObject {
			return model.downSelectedState;
		}

		override protected function validateUpState(newValue:*, oldValue:*):void {
			unselectedButtonView.upState = newValue;
		}
		
		override protected function validateOverState(newValue:*, oldValue:*):void {
			unselectedButtonView.overState = newValue;
		}

		override protected function validateDownState(newValue:*, oldValue:*):void {
			unselectedButtonView.downState = newValue;
		}
		
		protected function validateUpSelectedState(newValue:*, oldValue:*):void {
			selectedButtonView.upState = newValue;
		}
		
		protected function validateOverSelectedState(newValue:*, oldValue:*):void {
			selectedButtonView.overState = newValue;
		}

		protected function validateDownSelectedState(newValue:*, oldValue:*):void {
			selectedButtonView.downState = newValue;
		}

		override protected function validateHitTestState(newValue:*, oldValue:*):void {
			unselectedButtonView.hitTestState = newValue;
			selectedButtonView.hitTestState = newValue;
		}

		public function get defaultUpSelectedState():DisplayObject {
			var alias:String = unQualifiedClassName + SELECTED_UP_STATE;
			return getBitmapByName(alias);
		}
		
		public function get defaultOverSelectedState():DisplayObject {
			var alias:String = unQualifiedClassName + SELECTED_OVER_STATE;
			return getBitmapByName(alias);
		}

		public function get defaultDownSelectedState():DisplayObject {
			var alias:String = unQualifiedClassName + SELECTED_DOWN_STATE;
			return getBitmapByName(alias);
		}
		
		public function set selected(selected:Boolean):void {
			model.selected = selected;
		}

		public function get selected():Boolean {
			return model.selected;
		}
		
		protected function validateSelected(newValue:*, oldValue:*):void {
			if(newValue) {
				buttonView = selectedButtonView;
			}
			else {
				buttonView = unselectedButtonView;
			}
		}
		
		public function toggleState():void {
			selected = !selected;
		}
		
		override protected function mouseClickHandler(mouseEvent:MouseEvent):void {
			toggleState();
			mouseEventHandler(mouseEvent);
		}
	}
}