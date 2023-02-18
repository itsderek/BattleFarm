// NOTE: Shader automatically converted from Godot Engine 3.4.3.stable's CanvasItemMaterial.

shader_type canvas_item;
render_mode blend_mix;

uniform int is_white : hint_range(0,1);

void fragment() {
	if (is_white > 0) {
		vec4 texture_color = texture(TEXTURE, UV);
		COLOR = vec4(mix(texture_color.rgb, vec3(1,1,1), 1.0), texture_color.a);
	} else {
		vec4 texture_color = texture(TEXTURE, UV);
		COLOR = texture_color;
	}
}