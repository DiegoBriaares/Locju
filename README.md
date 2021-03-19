<h1>Locju - Local Judge</h1>

Locju is a console controlled software, minded to test locally solutions to competitive programming problems. 
<br><br>
It allows you to judge a C/C++ code, using sample testcases. Your code can throw Accepted, Wrong Answer, Runtime Error, Time Limit Exceed or Compilation Error as a verdict. 

Locju also has a test case finder functionality. You must write a generator, correct solution and a validator (if needed) to use this function. What it does, is generate a number of testcases and report the verdict for each of them (by comparing with correct solution output). So you can find those testcases in wich your code fails. 

Furthermore, it has a functionality to download test cases of a given Codeforces Round.  

<h3>Index</h3>
<ol>
<li><a href="#requisites">Requisites</a></li>
<li><a href="#installation">Installation</a></li>
<li><a href="#usage">Usage</a></li>
<li><a href="#techused">Technology Used</a></li>
<li><a href="#testing">Testing</a></li>
</ol>

<a name="requisites"><h3>Requisites</h3></a>
<ul>
<li>A Windows version greater or equal than 8.1</li>
</ul>

<a name="installation"><h3>Installation</h3></a>
<ol>
<li>Download this repository or directly from here: https://drive.google.com/file/d/1z7bUH-hIEbinCTq9J7nut2YLi9H-ckYM/view?usp=sharing</li>
<li>Put Locju folder inside <b>C:\</b>. So you will have a <b>C:\Locju\</b> Directory.</li>	
<li>Add <b>C:\Locju\</b> to your path environment variables, you can do this as follows: 
    <ol>
	<li>Go to <i>Control Panel</i>.</li>
	<li>Open <i>advance system settings</i>.</li>
	    <li>Select <i>Environment Variables</i>.</li>
	    <li>In the <i>Edit System Variable</i> window, add <b>C:\Locju\</b></li>
	</ol>
</li>
</ol>

<a name="usage"><h3>Usage</h3></a>
<ul>
<li>A Locju environment consists of four folders and a cpp file: <b>tests</b>, <b>correct_solution</b>, <b>generator</b>, <b>validato</b>r and <i>sol.cpp</i>.
	<ul>
		<li><b>tests</b> contains inside the problem test cases (with <i>inT.in</i> and <i>outT.out</i> format, T is a positive integer number, wich stands for the test case number), and also contains a folder <b>time-limit</b>
			<ul>
				<li><i>inT.in</i> is the test case input (ex: <i>in1.in</i>)</li>
				<li><i>outT.out</i> is the test case output (ex: <i>out1.in</i>)</li>
				<li><b>time-limit</b> contains inside the file <i>time-limit.out</i>, wich contains a positive number, the time limit for the problem.</li>
			</ul>
		<li><b>correct solution</b> contains a cpp file <i>correct_solution.cpp</i>, which must have a correct solution for the problem (brute force maybe)</li>
		<li><b>generator</b> contains a cpp file <i>generator.cpp</i>, which must have a test case generator (ideally random, and generating small test cases that brute force can take)</li>
		<li><b>validator</b> contains a cpp file <i>validator.cpp</i>, which tests the correctness of your output. You must read the input (with standard cin or scanf) in the following order:</li>
			<ul>
				<li>Read input from test case</li>
				<li>Read output from correct solution (for the readed test case)</li>
				<li>Read output from your code (for the readed test case)</li>
			</ul>
		<li><i>sol.cpp</i> this is the cpp file that contains your solution to the problem.</li>	
		<li><b>NOTE1:</b> You must not rename the files listed previously</li>	
		<li><b>NOTE2:</b> You can add test cases inside <b>\tests\</b> but respecting the format (if you add <i>inT.out</i> and <i>outT.out</i>, there also must be inside <i>in(T-1).in</i> and <i>out(T-1).out</i> (except for <i>in0.in</i> and <i>out0.in</i>)) </li>
	</ul>
</li>
<li>Listed below are the commands that Locju allows you to use in the console. In order to use them, go to your project folder in the console (ex: <b>C:\users\Briaares\Desk\Codeforces\</b>)
	<ul>
		<li><b>locju start</b> creates a Locju environment in your current directory.</li>
		<br>
		<br>
		<center><img src="https://github.com/DiegoBriaares/Locju/blob/master/locju_env.jpg?raw=true"></center>
		<br>
		<li><b>locju startcf</b> asks for a Codeforces Round, wich is the one that appears on the round link, and it create directories with the format <b>\RoundName\ProblemIndex\</b> (ex: \707-Div-2\A) and inside each directory, a Locju environment.</li>
		<br>
		<br>
		<center><img src="https://github.com/DiegoBriaares/Locju/blob/master/Round_number.jpg?raw=true"></center>
		<br>
		<br>
		<br>
		<br>
		<center><img src="https://github.com/DiegoBriaares/Locju/blob/master/startcf.jpg?raw=true"></center>
		<br>
		<br>
		<center><img src="https://github.com/DiegoBriaares/Locju/blob/master/dirs_created.jpg?raw=true"></center>
		<br>
		<li><b>locju judge</b> Judge your solution with the test cases inside <b>\tests</b>.</li>
		<br>
		<br>
		<center><img src="https://github.com/DiegoBriaares/Locju/blob/master/locju_judge.jpg?raw=true"></center>
		<br>
		<li><b>locju validatorjudge</b> Judge your solution with the test cases inside <b>\tests</b> using <b>\validator\validator.cpp</b> (useful when there can be several answers).</li>
		<li><b>locju find</b> asks for a number to test cases to generate, and report if it finds a Non-Accepted test case (you need to write a <b>\correct_solution\correct_solution.cpp</b> and a <b>\generator\generator.cpp</b>).</li>
		<br>
		<br>
		<center><img src="https://github.com/DiegoBriaares/Locju/blob/master/find_case.jpg?raw=true"></center>
		<br>
		<li><b>locju find</b> asks for a number to test cases to generate, and report if it finds a Non-Accepted test case (you need to write a <b>\correct_solution\correct_solution.cpp</b> and a <b>\generator\generator.cpp</b>) using <b>\validator\validator.cpp</b> (useful when there can be several answers).</li>
	</ul>
</li>.


<a name="techused"><h3>Technology Used</h3></a>
<ul>
<li>The application is made using Python-3.9.4 and Shell scripting</li>
<li><b>BeautifulSoup</b> module is used alongwith <b>requests</b> in Python</li>
<li><b>NOTE:</b> This is my very first Shell scripting software, so the code is not the clearest.</li>
</ul>

<a name="testing"><h3>Testing</h3></a>
The program has been tested on Windows-10, 64-bit
<br>                                                                                                                                      
Feel free to contact me at <b>diegobriaares@gmail.com</b>
