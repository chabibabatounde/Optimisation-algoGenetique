import java.io.IOException;

void setup()
{
  size(100, 100, P3D); 
  background(255,255,255);

}

void draw()
{
  int maxIterration =  100;
  int iterration = 0;
  int taillePopulation =  100;
  int nombreCroisement =  (int) taillePopulation/100 * 40;
 
  
  Probleme pb = new Probleme(taillePopulation, "input.json");
  //Génération aléatoire de solution
  ArrayList<Configuration> population = pb.genererPopulation();
  //Evaluation de la population + Trie

for(int t=0; t< population.size(); t++){
   println("mass:"+population.get(t).mass+" \t massspeed: "+population.get(t).maxspeed+" \t massforce: "+population.get(t).maxforce+" \t fitness: "+population.get(t).fitness);
}

  
  while (iterration < maxIterration){
      
      //Sélection des reproducteurs
      
      for(int z=0; z < nombreCroisement; z++){
        
        int indexParent1 = (int)random(0, population.size());
        int indexParent2 = (int)random(0, population.size());
        Configuration parent1 = population.get(indexParent1);
        Configuration parent2 = population.get(indexParent2);
  
        //Croiser les deux parents
        ArrayList<Configuration> enfants = pb.croiser(parent1, parent2);
        
        //Ajouter les deux enfants à la population
        population.add(enfants.get(0));
        population.add(enfants.get(1));
        
      }

      //Evaluer la population
      population = pb.evaluerPopulation(population);
      //Normaliser la population
      population = pb.normaliserPopulation(population);
      
      iterration++;
      println("iterration "+iterration + " ["+population.get(0).mass+" "+population.get(0).maxspeed+" "+population.get(0).maxforce+" ==> "+population.get(0).fitness+" ]");
  }
   println("\nMin : "+population.get(0).mass+" "+population.get(0).maxspeed+" "+population.get(0).maxforce+" ==> "+population.get(0).fitness);
   println("Max : "+population.get(99).mass+" "+population.get(99).maxspeed+" "+population.get(99).maxforce+" ==> "+population.get(99).fitness);
   noLoop();
}
