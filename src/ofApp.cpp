#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
    ofBackground(0);
    
    shader.setGeometryInputType(GL_POINTS);
    shader.setGeometryOutputType(GL_TRIANGLE_STRIP);
    shader.setGeometryOutputCount(6);
    shader.load("shader/shader.vert", "shader/shader.frag", "shader/shader.geom");
    
    img.load("img/snow.png");
    texSize.x = img.getWidth();
    texSize.y = img.getHeight();
    
    for (int j = 0; j < 100000; j++) {
        
        mesh.addVertex(ofVec3f(ofRandom(-1000,1000), ofRandom(1000), ofRandom(-1000,1000)));
        mesh.addNormal(ofVec3f(ofRandom(1.0), ofRandom(1.0), ofRandom(1.0)));
        
    }
    mesh.setMode(OF_PRIMITIVE_POINTS);
    
}

//--------------------------------------------------------------
void ofApp::update(){
    t += 0.001;
}

//--------------------------------------------------------------
void ofApp::draw(){
    cam.begin();
    
    shader.begin();
    shader.setUniform3f("pos", ofVec3f(0,-100,0));
    shader.setUniform1f("uTime", t);
    shader.setUniformTexture("uImg", img.getTexture(), 0);
    shader.setUniform2f("texSize", texSize);
        
    mesh.draw();
        
    shader.end();
    
    ofPushMatrix();
    ofTranslate(0, -100);
    ofScale(4,4,4);
    buildings.draw();
    ofPopMatrix();
    
    cam.end();
    
    ofDrawBitmapString("FPS: " + ofToString(ofGetFrameRate()), ofGetWidth()-300, 10);
}
