#version 150

uniform sampler2DRect uImg;

in vec2 vTexCoord;
out vec4 outputColor;

void main() {
    outputColor = texture(uImg, vTexCoord);
}
