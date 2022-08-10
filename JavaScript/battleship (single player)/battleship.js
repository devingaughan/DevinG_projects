// sets grid rows and columns and the size of each square
var rows = 10;
var cols = 10;
var squareSize = 50;
var gameArray = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J" ]
var letter = ""
var hitCount = 0;


// gets the container element
var gameBoardContainer = document.getElementById("gameboard");

// you can use this to convert your letters into numbers for use
// with the 2D array
var letterConversion = {
	"A": 0,
	"B": 1,
	"C": 2,
	"D": 3,
	"E": 4,
	"F": 5,
	"G": 6,
	"H": 7,
	"I": 8,
	"J": 9
}

// makes the grid columns and rows
for (i = 0; i < cols; i++) {
	for (j = 0; j < rows; j++) {

		// creates a new div HTML element for each grid square and makes it the right size
		var square = document.createElement("div");
		gameBoardContainer.appendChild(square);

var rowDisplay = i + 1;

    // give each div element a unique id based on its row and column, like "s00"
		square.id = 's' + j + i;
		square.className = "boardSquare";

		// THIS IS WHERE YOU WILL ADD CODE FOR PART 1 TO ADD TEXT TO EACH SQUARE


			square.textContent = gameArray[j] + rowDisplay;







		// set each grid square's coordinates: multiples of the current row or column number
		var topPosition = j * squareSize;
		var leftPosition = i * squareSize;

		// use CSS absolute positioning to place each grid square on the page
		square.style.top = topPosition + 'px';
		square.style.left = leftPosition + 'px';
	}
}

var firstInput;
var secondInput;
var convertedInput;
var colorVariable;


// Hardcoded 2D array to indicate where the ships are placed
var gameBoard = [
				[0,0,0,1,1,1,1,0,0,0],//array 0
				[0,0,0,0,0,0,0,0,0,0],//array 1
				[0,0,0,0,0,0,0,0,0,0],//array 2
				[0,0,0,0,0,0,1,0,0,0],//array 3
				[0,0,0,0,0,0,1,0,0,0],//array 4
				[1,0,0,0,0,0,1,1,1,1],//array 5
				[1,0,0,0,0,0,0,0,0,0],//array 6
				[1,0,0,1,0,0,0,0,0,0],//array 7
				[1,0,0,1,0,0,0,0,0,0],//array 8
				[1,0,0,0,0,0,0,0,0,0]//array 9
				]

function fireTorpedo() {
 fireInput = document.getElementById("gameboardInput").value;
firstInput = fireInput.substring(0, 1); //gets the first letterfrom the user input box
convertedInput = letterConversion[firstInput];//takes first letter and converts into number using letter conversion object
secondInput = fireInput.substring(1, 3);//takes second character from user input box

console.log(convertedInput, secondInput);
if(gameBoard[convertedInput][secondInput - 1] == 1)
{

 document.getElementById("s" + convertedInput + (secondInput - 1)).style.background = "red";
 hitCount += 1;
 console.log(hitCount);
}
else {
	document.getElementById("s" + convertedInput + (secondInput - 1)).style.background = "grey";
}

if(hitCount == 17) {
	$("#instructions").text("Enemy teminated!!");
}
}
