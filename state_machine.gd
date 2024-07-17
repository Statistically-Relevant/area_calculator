class_name StateMachine extends Node

@onready var ui : Control = $UI
@onready var circle_button : Button = $UI/CircleButton
@onready var triangle_button : Button = $UI/TriangleButton
@onready var square_button : Button = $UI/SquareButton
@onready var selection_type_label : RichTextLabel = $UI/SelectionTypeLabel
@onready var size_enter_label : RichTextLabel = $UI/SizeEnterLabel
@onready var size_input : LineEdit = $UI/SizeInput
@onready var submit_button : Button = $UI/SubmitButton
@onready var output_rect : ColorRect = $UI/OutputRect
@onready var output_field : LineEdit = $UI/OutputRect/OutputField
@onready var output_label : RichTextLabel = $UI/OutputRect/OutputLabel
@onready var output_rect_2 : ColorRect = $UI/OutputRect2
@onready var output_rect_2_2 : ColorRect = $"UI/OutputRect2/OutputRect2-2"
@onready var output_rect_2_3  : ColorRect = $"UI/OutputRect2/OutputRect2-3"
@onready var output_2_label : RichTextLabel = $"UI/OutputRect2/Output2-Label"
@onready var circum_field : LineEdit = $UI/OutputRect2/CircumField

var circle_selected: bool
var square_selected: bool
var triangle_selected: bool
var valid_number_given: bool

var validated_number: float = 0.01

func _ready() -> void:
    circle_button.connect("pressed", on_circle_selected)
    square_button.connect("pressed", on_square_select)
    triangle_button.connect("pressed", on_triangle_select)
    submit_button.connect("pressed", submit_pressed)
    output_rect.hide()
    output_rect_2.hide()
    
func on_circle_selected() -> void:
    reset_text()
    circle_selected = true
    square_selected = false
    triangle_selected = false
    output_label.text = "Radius:"
    output_rect_2.show()
    output_rect.show()

func on_square_select() -> void:
    circle_selected = false
    triangle_selected = false
    square_selected = true
    reset_text()
    output_label.text = "Length of Sides:"
    output_rect_2.hide()
    output_rect.show()
    
func on_triangle_select() -> void:
    reset_text()
    triangle_selected = true
    square_selected = false
    circle_selected = false
    output_label.text = "Length of Sides:"
    output_rect_2.hide()
    output_rect.show()

func submit_pressed() -> void:
    var input_text = size_input.text
    valid_number_given = valid_number(input_text)
    if valid_number_given:
        if square_selected:
            output_field.text = str(self.validated_number / 4)
        elif circle_selected:
            output_field.text = str(self.validated_number)
            circum_field.text = str(self.validated_number / (2 * PI))
        elif triangle_selected:
            output_field.text = str(self.validated_number / 3)

func valid_number(number_input: String) -> bool:
    var number = 0.00
    if number_input.is_valid_float():
        var input_value = number_input.to_float()
        if input_value > 0.00 and input_value < 50.00:
            number = round(input_value * 100) / 100.00
            validated_number = number
            return true
        elif input_value < 0.01:
            number = 0.01
            validated_number = number
            return true
        else:
            number = 50.00
            validated_number = number
            return true
    else:
        number = 0.01
        validated_number = number
        return true
    validated_number = 0.00
    return false

func reset_text() -> void:
    output_field.text = ""
    circum_field.text = ""
