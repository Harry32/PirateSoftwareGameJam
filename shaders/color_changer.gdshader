shader_type canvas_item;

uniform vec4 newColor : source_color = vec4(0.74902, 0.607843, 0.376471, 1);
uniform vec4 borderColor : source_color = vec4(1.0);
uniform float width : hint_range(0, 10) = 1.0;
uniform bool showBorder = false;

const int pattern = 1;

bool hasContraryNeighbour(vec2 uv, vec2 texture_pixel_size, sampler2D texture) {
	for (float i = -ceil(width); i <= ceil(width); i++) {
		float x = abs(i) > width ? width * sign(i) : i;
		float offset;
		
		if (pattern == 0) {
			offset = width - abs(x);
		} else if (pattern == 1) {
			offset = floor(sqrt(pow(width + 0.5, 2) - x * x));
		} else if (pattern == 2) {
			offset = width;
		}
		
		for (float j = -ceil(offset); j <= ceil(offset); j++) {
			float y = abs(j) > offset ? offset * sign(j) : j;
			vec2 xy = uv + texture_pixel_size * vec2(x, y);
			
			if ((xy != clamp(xy, vec2(0.0), vec2(1.0)) || texture(texture, xy).a == 0.0) == false) {
				return true;
			}
		}
	}
	
	return false;
}

void fragment() {
	vec4 textureColor = texture(TEXTURE, UV);
	vec2 uv = UV;
	
	float control = (textureColor.r + textureColor.g + textureColor.b);
	
	float newRed = control * newColor.r;
	float newGreen = control * newColor.g;
	float newBlue = control * newColor.b;
	
	COLOR = vec4(newRed, newGreen, newBlue,textureColor.a);
	
	if (showBorder && (COLOR.a > 0.0) == false && hasContraryNeighbour(uv, TEXTURE_PIXEL_SIZE, TEXTURE)) {
		COLOR.rgb = false ? mix(COLOR.rgb, borderColor.rgb, borderColor.a) : borderColor.rgb;
		COLOR.a += (1.0 - COLOR.a) * borderColor.a;
	}
}