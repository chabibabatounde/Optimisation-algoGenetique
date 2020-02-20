interface Wander
{
   public void activate(); 
}

////////////////////////////////////////////////////////
///
///  VECTEUR [VITESSE] FIXE, 5px/dt
///  (3, -4, 0)
///  MOUVEMENT LINEAIRE
///

class WanderFixed1 implements Wander
{
     Agent   agent;
   PVector direction;
  
   public WanderFixed1(Agent a, float x, float y)
   {
     agent     = a;
     direction = new PVector(x, y);
   }
  
   @Override
   public void activate()
   {
     agent.velocity.set(direction);
   }
}
