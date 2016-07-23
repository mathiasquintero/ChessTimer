# ChessTimer

Tutorial to create a small iOS App.

# Getting Started

In this tutorial we will be creating a small iOS App that will function as a Clock for fast chess.

We will cover:

* MVC, Observer Pattern, State Pattern and Delegation
* NSTimer
* Basic UIAnimation
* Cocoapods
  * SnapKit

# Let's do it!

## Step One - Create a Project

Just go into XCode and create a new Project. A Single View Application.

## Step Two - The Models

First we have to figure out how we are going to Model the game internally.
For that we have to think about the main components which are the 2 Players.

The first thing we need for the Player is to model the states in which the player can be. A player can either be playing at the moment or waiting for the other player to make a move.
For that we can create a simple enum. That allows us to store the state easily and know to what state we should go if an action is like toggling the player is triggered:

```Swift
enum State {
      case Playing
      case Waiting

      func toggle() -> State {
          switch self {
          case .Playing:
            return .Waiting
          case .Waiting:
            return .Playing
         }
      }
}
```

We can model the Player as a simple integer counting the number of miliseconds left, starting with 1000 * 60 * 5 = 300000 and the current state.

```Swift
class Player {
    
    var state: State
    var counter = 300000
    
    init() {
        state = .Waiting
    }

}
```

Now we should just look at what the player need to do. Mainly an action that should get called every millisecond that will decrease our counter of time left and a toggle to switch the state of the player. So we add the following functions:

```Swift
func toggle() {
    state = state.toggle()
}
    
func action() {
    if state == .Playing && counter > 0 {
        counter -= 1
    }
}
```

We might also want to know if the Player has already lost. For that we can have a computed property:

```Swift
var lost: Bool {
    get {
        return counter == 0
    }
}
```

At last we propably don't want to update the interface every milisecond. So we can make a property that will tell us if we should update or not. Which is if we're at a new second and the player is playing. Meaning the counter is still moving:

```Swift
var isChangeRelevant: Bool {
    get {
        return counter % 1000 == 0 && state == .Playing
    }
}
```

Now we have modeled our players. We have to model the game itself and start work on the Observer Pattern.

With the Observer Pattern we will make the model update the Views when it needs to. So we have to ask what when we should update the Views:

* Counters are different.
* New Turn. (Perhaps change the colors.
* Someone has lost.

For that we can already image a protocol:

```Swift
protocol GameObserver {
    func updatePlayers(playerOne: Player, playerTwo: Player) // Update counters
    func animateToggle(playerOne: Player, playerTwo: Player) // Update animations
    func gameEnded(playerOne: Bool, playerTwo: Bool) // Someone has lost. True if won. False if lost.
}
```

With that in mind we can now have a Game Object with two players and an observer:

```Swift
class Game {
    
    var playerOne: Player
    var playerTwo: Player
    let observer: GameObserver
    
    init(observer: GameObserver) {
        self.observer = observer
        playerOne = Player()
        playerTwo = Player()
    }
    
}
```

More explanations coming... This is still a WIP
