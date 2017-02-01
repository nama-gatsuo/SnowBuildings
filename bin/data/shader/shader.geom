#version 150

layout (points) in;
layout (triangle_strip) out;
layout (max_vertices = 6) out;

uniform mat4 modelViewProjectionMatrix;
uniform float uTime;
uniform vec2 texSize;

in vec4 vPosition[];
in vec4 vNormal[];

out vec2 vTexCoord;

float PI = 3.1415926535;

mat3 calclookAtMat(vec3 target) {
    float rad = sqrt(target.x * target.x + target.y * target.y + target.z * target.z);

    float lat = acos(target.y / rad) - PI / 2;
    float lon = atan(target.x, target.z);

    // z axis rotate
    mat3 m = mat3(cos(uTime*lat*10), -sin(uTime*lat*10), 0.0,
              sin(uTime*lat*10), cos(uTime*lat*10),  0.0,
              0.0,      0.0,       1.0);

    // x axis rotate
    m *= mat3(1.0, 0.0,      0.0,
                  0.0, cos(lat), -sin(lat),
                  0.0, sin(lat), cos(lat));
    // y axis rotate
    m *= mat3(cos(lon),  0.0, sin(lon),
              0.0,       1.0, 0.0,
              -sin(lon), 0.0, cos(lon));


    return m;
}

void main(void){

    float size = 2.0;

    for (int i = 0; i < gl_in.length(); i++) {

        mat3 m = calclookAtMat(vNormal[i].xyz);

        gl_Position = modelViewProjectionMatrix * vec4(vPosition[i].xyz + m * vec3(-size,-size,0), 1.0);
        vTexCoord = vec2(0.0, 0.0);
        EmitVertex();

        gl_Position = modelViewProjectionMatrix * vec4(vPosition[i].xyz + m * vec3(size,-size,0), 1.0);
        vTexCoord = vec2(texSize.x, 0.0);
        EmitVertex();

        gl_Position = modelViewProjectionMatrix * vec4(vPosition[i].xyz + m * vec3(size,size,0), 1.0);
        vTexCoord = vec2(texSize.x, texSize.y);
        EmitVertex();
        EndPrimitive();

        gl_Position = modelViewProjectionMatrix * vec4(vPosition[i].xyz + m * vec3(-size,-size,0), 1.0);
        vTexCoord = vec2(0.0, 0.0);
        EmitVertex();

        gl_Position = modelViewProjectionMatrix * vec4(vPosition[i].xyz + m * vec3(-size,size,0), 1.0);
        vTexCoord = vec2(0.0, texSize.y);
        EmitVertex();

        gl_Position = modelViewProjectionMatrix * vec4(vPosition[i].xyz + m * vec3(size,size,0), 1.0);
        vTexCoord = vec2(texSize.x, texSize.y);
        EmitVertex();
        EndPrimitive();
    }
}
