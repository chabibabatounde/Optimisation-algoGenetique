class Probleme{
  int taillePopulation;
  JSONArray dataSet;
  
  
  public Probleme(int taille, String path){
    this.taillePopulation = taille;
    dataSet = loadJSONArray(path);
  }
  
  
  public ArrayList<Configuration> genererPopulation(){
    ArrayList<Configuration> population = new ArrayList<Configuration>();
    for (int i=0; i< taillePopulation ; i++){
      float   mass = random(0, 10);
      float   maxspeed = random(0, 10);
      float   maxforce = random(0, 10);
      population.add(new Configuration(mass,maxspeed,maxforce));
    }
    return evaluerPopulation(population);
  }
  
  
  public ArrayList<Configuration> evaluerPopulation(ArrayList<Configuration> listeConfiguration){
    ArrayList<Configuration> populationEvaluee = new ArrayList<Configuration>();
    for (int i=0; i< listeConfiguration.size() ; i++){
      Configuration cnf = listeConfiguration.get(i);
      Agent agn  = new Agent(cnf, null);
      
      //Définir le comportement ici 
      agn.behaviour = new WanderFixed1(agn, 3,9);
      
      
      Calculateur cl = new Calculateur();
      String json = cl.getData(agn);
      
      JSONArray calcules = parseJSONArray(json);
      
      float fitness = 0;
      
      for (int j = 0; j < dataSet.size()-1; j++) {
        JSONObject mesure_i = dataSet.getJSONObject(j);
        JSONObject mesure_i1 = dataSet.getJSONObject(j+1);
        
        JSONObject calcule_i = calcules.getJSONObject(j);
        JSONObject calcule_i1 = calcules.getJSONObject(j+1);
        
        float a = parseFloat(mesure_i.get("x").toString());
        float b = parseFloat(mesure_i1.get("x").toString());
        
        float c = parseFloat(calcule_i.get("x").toString());
        float d = parseFloat(calcule_i1.get("x").toString());
        
        fitness += abs(abs(b-a) - abs(d-c));
        
         a = parseFloat(mesure_i.get("y").toString());
         b = parseFloat(mesure_i1.get("y").toString());
         
         c = parseFloat(calcule_i.get("y").toString());
         d = parseFloat(calcule_i1.get("y").toString());
        
        fitness += abs(abs(b-a) - abs(d-c));
        
         a = parseFloat(mesure_i.get("z").toString());
         b = parseFloat(mesure_i1.get("z").toString());
         
         c = parseFloat(calcule_i.get("z").toString());
         d = parseFloat(calcule_i1.get("z").toString());
        
        fitness += abs(abs(b-a) - abs(d-c));
      }
      cnf.fitness = fitness;
      populationEvaluee.add(cnf);
    }
    //trierPopulation
    return trierPopulation(populationEvaluee);
  }
  
   
   public ArrayList<Configuration> croiser(Configuration parent1, Configuration parent2){
    ArrayList<Configuration> enfants = new ArrayList<Configuration>();
    int taille = parent1.codage.length();
    /*
    int  pointCroisement = (int)random(1, parent1.codage.length());
    String adn1 = parent1.codage.substring(0,pointCroisement);
    adn1 += parent2.codage.substring(pointCroisement, parent1.codage.length());
    String adn2 = parent2.codage.substring(0,pointCroisement);
    adn2 += parent1.codage.substring(pointCroisement, parent1.codage.length());
    */
    
    int  pointCroisement1 = (int)random(1, 32);
    int  pointCroisement2 = (int)random(32, 64);
    int  pointCroisement3 = (int)random(64, taille);
    
    while(pointCroisement1 >= pointCroisement2){
      pointCroisement2=(int)random(1, 16);
    }
    
    while(pointCroisement2 >= pointCroisement3){
      pointCroisement3=(int)random(1, parent1.codage.length());
    }
    
    String adn1 = parent1.codage.substring(0,pointCroisement1);
    adn1 += parent2.codage.substring(pointCroisement1, pointCroisement2);
    adn1 += parent1.codage.substring(pointCroisement2, pointCroisement3);
    adn1 += parent2.codage.substring(pointCroisement3, parent1.codage.length());
    
    String adn2 = parent2.codage.substring(0,pointCroisement1);
    adn2 += parent1.codage.substring(pointCroisement1, pointCroisement2);
    adn2 += parent2.codage.substring(pointCroisement2, pointCroisement3);
    adn2 += parent1.codage.substring(pointCroisement3, parent2.codage.length());
    
    //Muter les deux enfants
    adn1 = this.mutation(adn1);
    adn2 = this.mutation(adn2);
    
    //décodage 1
    String binary = adn1.substring(0, parent1.codage.length()/3);
    float mass = Float.intBitsToFloat(Integer.parseInt(binary, 2));
    
    binary = adn1.substring(parent1.codage.length()/3, parent1.codage.length()/3*2);
    float maxspeed =  mass = Float.intBitsToFloat(Integer.parseInt(binary, 2));
    
    binary = adn1.substring(parent1.codage.length()/3*2, parent1.codage.length());
    float maxforce =  mass = Float.intBitsToFloat(Integer.parseInt(binary, 2));
    
    Configuration enfant1 = new Configuration(mass,maxspeed,maxforce);
    
    
    //décodage 2
     binary = adn2.substring(0, parent1.codage.length()/3);
     mass = Float.intBitsToFloat(Integer.parseInt(binary, 2));
    
     binary = adn2.substring(parent1.codage.length()/3, parent1.codage.length()/3*2);
     maxspeed =  mass = Float.intBitsToFloat(Integer.parseInt(binary, 2));
    
     binary = adn2.substring(parent1.codage.length()/3*2, parent1.codage.length());
     maxforce =  mass = Float.intBitsToFloat(Integer.parseInt(binary, 2));
    
    Configuration enfant2 = new Configuration(mass,maxspeed,maxforce);
    
    enfants.add(enfant1);
    enfants.add(enfant2);

    return enfants;
  }
  
  
  public ArrayList<Configuration> normaliserPopulation(ArrayList<Configuration> listeConfiguration){
    listeConfiguration = this.trierPopulation(listeConfiguration);
    ArrayList<Configuration> tableauNormalise = new ArrayList<Configuration>();
    int position = 0;
    while(tableauNormalise.size()< taillePopulation && position < listeConfiguration.size()){
      tableauNormalise.add(listeConfiguration.get(position));
      position ++;
    }
    return tableauNormalise;
  } 
  
  public String mutation(String adn){
      /*
      int mutation = (int)random(1, adn.length());
      char car = '1';
      adn = adn.substring(0,mutation)+car+adn.substring(mutation+1);

      
      mutation = (int)random(1, adn.length());
      car = '0';
      adn = adn.substring(0,mutation)+car+adn.substring(mutation+1);
      */
      return adn;
  }
  
  
  public ArrayList<Configuration> trierPopulation(ArrayList<Configuration> listeConfiguration){
    ArrayList<Configuration> tableauTrie = new ArrayList<Configuration>();
    while(listeConfiguration.size()>0){
      int minIndex  = 0;
      for(int index =0; index < listeConfiguration.size(); index++){
        if(listeConfiguration.get(minIndex).fitness >= listeConfiguration.get(index).fitness ){
          minIndex = index;
        }
      }
      tableauTrie.add(listeConfiguration.get(minIndex));
      listeConfiguration.remove(minIndex);
    }
    return tableauTrie;
  }
}
