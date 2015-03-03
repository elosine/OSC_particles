class Particle{
  PVector loc;   //2d vector storing x and y locations
  PVector acc;   //rate of acceleration
  PVector vel;   //controlling direction
  float r;       //radius of particle
  float timer;   //particle lifetime
  float mass;    //"weight" of particle, need for attraction algorithm
  float velLim;  //limit the speed at which the particles can travel
  float g;       //gravity constant
  ArrayList parts;

  Particle(PVector l, float _r, float _mass, float _grav, float _timer){
    loc = l.get(); //x and y values
    acc = new PVector(random(0, 2), random(0, 2), 0);  //set initial acceleration
    vel = new PVector(random(-2, 2), random(-1, 1), 0); //set initial velocity
    r = _r;
    mass = _mass;
    g = _grav;
    timer = _timer;
    velLim = 5.0;
  }

  void applyAttraction(ArrayList parts){
    //compare location values between different particles in the arraylist
    for(int i=0; i<parts.size();i++){
      Particle p1 = (Particle)parts.get(i);
      for(int j=i+1;j<parts.size();j++){
        Particle p2 = (Particle)parts.get(j);

        PVector dir = PVector.sub(p1.loc, p2.loc);
        float d = dir.mag();
        dir.normalize();
        
        //calculate strength of attraction
        float force = (g * p1.mass * p2.mass) / (d*d);
        dir.mult(force);
      
        p2.applyForce(dir);
        dir.mult(-1.0);
        p1.applyForce(dir);
      }
    }
  }
  
  //used to apply the attraction force
  void applyForce(PVector force){
    force.div(mass);
    acc.add(force);
  }
  
  //main
  void run(ArrayList parts){
    bounds();
    applyAttraction(parts);
    update();
    render();
  }
  
  //update vector values
  void update(){
    vel.add(acc);
    vel.limit(velLim);
    loc.add(vel);
    acc.mult(0);
    timer -= 1.0;
  }

  //bounces particles off canvas edge
  void bounds(){
    if(loc.y > height || loc.y < 0){
      vel.y *= -1;
    }
    if(loc.x > width || loc.x < 0){
      vel.x *= -1;
    }
  }
  
  //set the visual characteristics of the individual particles here
  void render(){
    ellipseMode(CENTER);
    noStroke();
    fill(255,  timer);
    ellipse(loc.x, loc.y, r, r);
  }
  
  //check if the particle's timer is 0
  boolean dead(){
    if(timer <= 0.0){
      return true;
    }
    else{
      return false;
    }
  }
}



