shader_type canvas_item;

uniform vec4 newColor : source_color = vec4(0.74902, 0.607843, 0.376471, 1);
uniform float value;

void fragment() {
	vec4 textureColor = texture(TEXTURE, UV);
	
	float control = (textureColor.r + textureColor.g + textureColor.b);
	
	float newRed = control * newColor.r;
	float newGreen = control * newColor.g;
	float newBlue = control * newColor.b;
	
	COLOR = vec4(newRed, newGreen, newBlue ,textureColor.a);
}