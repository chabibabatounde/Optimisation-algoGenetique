class Configuration{
  float   mass;
  float   maxspeed;
  float   maxforce;
  String  codage;
  float   fitness =-1;
  
  public Configuration(float pmass, float pmaxspeed, float pmaxforce){
    //println(pmass);
    
    mass = pmass;
    maxspeed = pmaxspeed;
    maxforce = pmaxforce;

    int bits = Float.floatToIntBits(pmass);
    String chaine = (Integer.toBinaryString(bits));
    
    
    while (chaine.length () < 32 ){
      chaine = "0" + chaine;
    }
    
    codage = chaine;
    
    bits = Float.floatToIntBits(pmaxspeed);
    chaine= (Integer.toBinaryString(bits));
    
    while (chaine.length () < 32 ){
      chaine = "0" + chaine;
    }

    codage += chaine;
    
    bits = Float.floatToIntBits(pmaxspeed);
    chaine= (Integer.toBinaryString(bits));
    
    while (chaine.length () < 32 ){
      chaine = "0" + chaine;
    }

    codage += chaine;
    
    //println(codage);
  }

}
