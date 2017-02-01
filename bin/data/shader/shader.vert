#version 150
precision mediump float;

// from default parameter
uniform mat4 modelViewProjectionMatrix;
in vec4 position;
in vec4 normal;

uniform vec3 pos;
uniform float uTime;

out vec4 vPosition;
out vec4 vNormal;

void main() {

    float t = fract(uTime); // 0 -> 1
    float y;
    if (position.y - 1000 * t < 0) {
        y = position.y - 1000 * t + 1000;
    } else {
        y = position.y - 1000 * t;
    }

    vNormal = normal;
    vec3 p = vec3(position.x, y, position.z);
    vPosition = vec4(p + pos, 1.0);

}
