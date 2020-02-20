class Agent
{
   
   int     id;
   PVector location;
   PVector velocity;
   PVector acceleration;
   Wander  behaviour;
   float   size;
   float   mass;
   float   maxspeed;
   float   maxforce;
   
   
   public Agent(Configuration config, Wander b )
   {
     behaviour    = b;
     mass         = config.mass;
     maxspeed     = config.maxspeed;
     maxforce     = config.maxforce;
     
     location     = new PVector(0, 0);
     velocity     = new PVector(0, 0);
     acceleration = new PVector(0, 0);    
     size         = 20;
   }
   
   public void applyForce(PVector force)
   {
     acceleration.add(force.copy().div(mass));
   }
   
   public void update()
   {
     acceleration.limit(maxforce);
     velocity.add(acceleration);
     velocity.limit(maxspeed);
     location.add(velocity);
     acceleration.set(0, 0);
   }
   
   public void play()
   {
      if(!behaviour.equals(null))
        behaviour.activate();
        
      update();
   }
   
   
}
