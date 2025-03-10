# Godot Pong
This is an implementation of Pong using the Godot game engine. This implementation is for the 
[20 Games Challenge](https://20_games_challenge.gitlab.io/games/pong/) to create a Pong game.

![Pong Game](https://github.com/alexloney/Godot-Pong/blob/main/pong.png)

This supports moving one paddle with player input (W and S or mouse), while the other paddle
will move with an AI which follows the ball, but is not quite as fast as the ball. Every 10
seconds of gameplay, the difficulty will increase by the speed of the ball increasing and
the AI speed increasing, but not as much as the ball speed. This is to make the AI imperfect
and if the player is able to play well enough, eventually the AI will not be able to keep up.

Some possible enhacements to this project would be:
* Implement an opening screen with a "Play" button
* Implement a Win/Lose screen based on which player gets to a set number of points first
* Add sound effects when the ball hits something

