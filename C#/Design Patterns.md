# Design Patterns

## Factory Method

Allows programmers to request objects and have the correct type created behind the scene and returned.

Define an interface for creating an object, but let subclasses decide which class to instantiate. This lets a class defer instantiation to subclasses.

## Open for Extension, Closed to Modification

The general idea is that to change the behaviour of something, you shouldn't really need to modify a method. You should be extending it. Consider the below example:

``` c#
public void AskForDrink()
{
    var drink = _inputProvicder() ?? string.Empty;
    switch (drink)
    {
        case "beer":
            ServeBeer();
            break;
        case "water":
            ServeWater();
            break;
        default:
            UnavailableDrink();
            break;
    }
}
```

If we wished to modify this code to follow this principle, what would we do?

What you could do is make a new class:

```c#

public class RecipeBook
{
    private readonly Dictionary<string, Action> _recipes;

    public RecipeBook()
    {
        _recipes = new Dictionary<string, Action>
        {
            {"beer", () => ServeBeer},
            {"juice", () => ServeJuice}
        };
    }

    public Action GetRecipe(string drink)
    {
        return _recipes[drink];
    }

    public IEnumerable<string> GetAllAvailableDrinkNames()
    {
        return _recipes.Keys;
    }

    private void ServeJuice()
    {
        _outputProvider("Here's your juice!");
    }

    private void ServeBeer()
    {
        _outputProvider("Here's your cold beer!");
    }
}

```

Then in your old method we would change it to:

``` c#
public void AskForDrink()
{
    var drink = _inputProvicder() ?? string.Empty;
    if(!_recipeBook.GetAllAvailableDrinkNames.Contains(drink))
    {
        _outputProvider("Sorry I do not make that drink.");
    }
    var drinkAction = _recipeBook.GetRecipe(drink);
    drinkAction();
}
```
