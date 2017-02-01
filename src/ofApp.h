#pragma once

#include "ofMain.h"
#include "Buildings.hpp"

class ofApp : public ofBaseApp{

public:
    void setup();
    void update();
    void draw();

    Buildings buildings;
    ofVboMesh mesh;
    ofShader shader;
    
    ofImage img;
    ofVec2f texSize;
    float t;
    
    ofEasyCam cam;
    
};
