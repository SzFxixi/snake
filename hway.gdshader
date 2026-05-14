shader_type canvas_item; 
 
uniform float glitch_amount : hint_range(0.0, 1.0) = 0.0; 
uniform float scan_jitter = 0.01; 
uniform float color_shift = 0.02; 
uniform float block_size = 64.0; 
uniform float time_scale = 10.0; 
 
float rand(vec2 co) { 
    return fract(sin(dot(co.xy, vec2(12.9898, 78.233))) * 43758.5453); 
} 
 
float block_noise(vec2 uv, float size) { 
    vec2 block_uv = floor(uv * size) / size; 
    return rand(block_uv); 
} 
 
void fragment() { 
    vec2 uv = UV; 
    vec4 color = texture(TEXTURE, uv); 
 
    float glitch = glitch_amount; 
 
    if (glitch > 0.0) { 
        //扫描线抖动 
        float jitter = rand(vec2(TIME, uv.y)) * 2.0 - 1.0; 
        uv.x += jitter * scan_jitter * glitch; 
 
        //色道分离 
        float r_offset = (rand(vec2(TIME * 0.3, uv.y)) * 2.0 - 1.0) * color_shift * glitch; 
        float g_offset = (rand(vec2(TIME * 0.5, uv.y + 0.1)) * 2.0 - 1.0) * color_shift * glitch; 
        float b_offset = (rand(vec2(TIME * 0.7, uv.y + 0.2)) * 2.0 - 1.0) * color_shift * glitch; 
 
        float r = texture(TEXTURE, vec2(uv.x + r_offset, uv.y)).r; 
        float g = texture(TEXTURE, vec2(uv.x + g_offset, uv.y)).g; 
        float b = texture(TEXTURE, vec2(uv.x + b_offset, uv.y)).b; 
        float a = texture(TEXTURE, uv).a; 
 
        //像素块故障 
        float block_noise_val = block_noise(uv, block_size); 
        if (block_noise_val < glitch * 0.3) { 
            float block_offset = (rand(vec2(TIME, block_noise_val)) * 2.0 - 1.0) * 0.1; 
            uv.x += block_offset; 
 
            r = texture(TEXTURE, vec2(uv.x + r_offset, uv.y)).r; 
            g = texture(TEXTURE, vec2(uv.x + g_offset, uv.y)).g; 
            b = texture(TEXTURE, vec2(uv.x + b_offset, uv.y)).b; 
        } 
 
        //亮度闪烁 
        float brightness_flicker = 1.0 + sin(TIME * time_scale) * 0.3 * glitch; 
 
        //黑白闪屏 
        float static_noise = rand(uv + TIME); 
        if (static_noise < glitch * 0.1) { 
            float bw = (r + g + b) / 3.0; 
            r = g = b = bw; 
        } 
 
        color = vec4(r, g, b, a) * brightness_flicker; 
    } 
 
    COLOR = color; 
}