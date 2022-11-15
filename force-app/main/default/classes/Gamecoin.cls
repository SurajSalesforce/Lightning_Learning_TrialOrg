//Abstract Example
Public abstract class Gamecoin{
    
    Public abstract Integer coinValue();
    Public Integer absorbCoin(Integer existingPoints){
        return existingPoints + coinValue(); 
    }
}