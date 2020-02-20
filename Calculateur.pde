class Calculateur{
  
  int time = 101;
  
  public float fitness(){
    return random(0,10);
  }
  
  public String getData(Agent agent){
    String resultat = "[\n";
    for(int i = 0; i < time+1 ; i++){
      resultat += "\t{\"x\":"+agent.location.x + ", \"y\":"+agent.location.y + ", \"z\":"+agent.location.z + ", \"time\":"+ + i + "},\n";
      agent.play();
    }
    resultat += "]";
    return resultat;
  }
}
