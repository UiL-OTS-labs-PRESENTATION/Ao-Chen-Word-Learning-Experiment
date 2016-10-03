################# main header info 
/* 258!
This experiment results from combining two scripts
The information relating to reading information from a tab-delimited file (in a pseudo-randomized order) 
comes from Doug davidson; modified by Petra van Alphen; modified again by Caroline Junge, June 2008 (caroline.junge@mpi.nl);

This EEG experiment presents 240 picture-word sequences (10 blocks of 26 such pairs focusing on 2 categories); 
a training block consists of 2x 6 pictures& correct word (with either the same picture of a category presented six times in a row or 6 different exemplars of a category)
& a test phase consisting of 12 picture-word pairs (with 6 'match' and 6 'mismatch' with 3 novel exemplars from the 2 trained categories)
& an eye-tracking phase (where a picture contains 2 objects; 2 such pictures per eye-tracking phase)

There are 3 main trials: 
1) the playing of a picture-word pair (picture is on the whole trial; word starts at 1000ms; end is 2200ms
2) the pause (isi) between trials -> 1000ms 
3) the playing of an attention grabber
 
Markers to the EEG computer are sent:
1) at the beginning of each picture  (marker is always 53)
2) This is followed 50 ms after onset picture by a marker denoting which fase we're in 
		(training: 111 (1 exemplar) / 123 (multiple exemplars); test phase 222 (trained on 1 exemplar) or 234 (trained on mulitiple exemplars)
3) This is 100 ms after onset picture followed by a marker 1-6 (number of training) or 70 (match) or 80 (mismatch) 

4) at the onset of target word (tw) (marker is always 13)
5) 50 ms after onset tw to indicate which fase we 're in (cf.marker #2): 111/123/222/234
 6) 100 ms after onset tw to indicate whether it is in the early fase or late fase of the training [1-6]; 
												or for test phase; whether it is a match or mismatch (70/80); 
												or for eye-tracking whether the tw matches the left picture [131] or the right one [130]
7) at the isi trial to indicate in which block we actually are 
		(marker is 20 + block number -> [21-30])


settings: response -> 1 response buttons
audio -> hardware DirectX; Primary sound Driver; 16 bit;
port -> no input port; 1 output port (parallel port; make sure that 'independent lines & delay codes' are selected)


you need a txtfile (for example, excel file saved as tab delimited) in which 
the first column denotes the name of the jpg file; the second the wavfile;
third column are eeg markers denoting which phase the word belongs to and whether the type/token ratio in training was 1/1 or 1/6: training (111/123) or test (222/234)
4th column are eeg markers for position whithin training block or match/mismatch
5th column is blocknumber

Example:
cat1.jpg	poes2.wav	111	1	21
cat1.jpg	poes8.wav	111	2	21	
make sure that txt file does not end on a blank line, but with last number

*/

##############################################################################################3 
scenario = "EWL_sep09.sce"; 
#no_logfile = true;
scenario_type = trials; 

#write_codes = true; #		#WRITE CODES TO LOG/EEG PC
write_codes = false;

pulse_width= 20; 

response_matching = simple_matching;

active_buttons = 1;
button_codes =1;
default_font_size = 48;
default_background_color = 82, 82, 82;

begin;
################ DEFINE OBJECTS 

sound { wavefile { filename = ""; preload = false;} s; } snd;  #define sound 1 

picture {
	default_code = "";
	background_color = 82, 82, 82;
	bitmap { filename = ""; preload = false; } bit; #the bitmap is called bit, but will be overwritten
	x = 0;
	y = 0;
	} pic1; #define pic1

/*array{
	text {caption = "Attention Grabber 1 playing!!"; }text_ag1;
	text {caption = "Attention Grabber 2 playing!!"; }text_ag2;
	text {caption = "Attention Grabber 3 playing!!"; }text_ag3;
	text {caption = "Attention Grabber 4 playing!!"; }text_ag4;
	text {caption = "Attention Grabber 5 playing!!"; }text_ag5;
	text {caption = "Attention Grabber 6 playing!!"; }text_ag6;
}textcaption;
*/


text {caption = "PAUZE"; }pauze_txt;
text {caption = "EINDE       BEDANKT!"; }einde_txt;

picture {
	background_color = 82, 82, 82;
	text pauze_txt; 
	x = 0;
	y = 0;  
}pauze_pic; #pauze_pic

picture {
	background_color = 82, 82, 82;
}default; #default

picture {
	background_color = 82, 82, 82;
	text einde_txt; 
	x = 0;
	y = 0;  
}einde; #einde picture
	
array{
	video { filename = "samplevideo.mp4"; } video1;
}movies;


################# DEFINE TRIALS
trial {
	trial_type = first_response;
	trial_duration = stimuli_length; 
	stimulus_event {
	nothing{};
	time = 0;
	target_button = 1; #enter
	response_active = true; 
	port_code = 100;
	code = "attentiongrabber";
	}attention_event;
}feedback_trial;


/*trial {
   trial_type = first_response;
   trial_duration = forever;
  	stimulus_event {
	picture {text text_ag1; x = 0; y = 0;  } feedback_txt;
	time = 0;
	target_button = 1; 
	response_active = true;
	code = "attentiongrabber"; 
#	port_code = 99;
	}feedback_pic;
}feedback_trial;
*/


	
trial { 
	trial_duration = 2200;
	monitor_sounds = true;
	all_responses = false;
	
		stimulus_event{
			picture pic1;        # Show picture ; pic1 will be overwritten in pcl
				time = 0;
				code = "onset picture"; #will be given name of jpg file
				port_code = 53;
		}picevent;					# The event of presenting picture is called 'picevent'
			
		stimulus_event{
			nothing {};
			deltat = 50; 
			code = "21"; #overwritten in pcl
			port_code = 21; #ibid
		}picidentity;	#gives information to which part of the block and what kind of block the picture belongs to
			
		stimulus_event{
			nothing {};
			deltat = 50; 
			code = "16"; #overwritten in pcl
			port_code = 16; #ibid
		}picnumber;	#gives information to which presentation in the training block [1-6] or match/mismatch or eyetracking it has
				
		stimulus_event{          # play target word                
			sound snd;
				time = 1000;
				code = "onset wav file";
				port_code = 13;
		}wavevent;               # the event of presenting the wav file is called wavevent   

		stimulus_event{
			nothing {};
			deltat = 50; 
			code = "21"; #overwritten in pcl
			port_code = 21; #ibid
		}wavidentity;	#gives information to which part of the block and what kind of block the wav belongs to
			
		stimulus_event{
			nothing {};
			deltat = 50; 
			code = "16"; #overwritten in pcl
			port_code = 16; #ibid
		}wavnumber;	#gives information to which presentation in the training block [1-6] or match/mismatch or eyetracking
         
}trial1;			
					
trial {
	trial_duration = 1000; # duration of trial
	all_responses = false;
		stimulus_event {
			picture default;  #as defined in sdl
			time = 0;
			code = "isi: bloknummer"; 
			port_code = 20; # overwritten in pcl
		}background; # this stimulus event is called 'eventblok' 
}isi;


trial {
	trial_type = first_response;
	trial_duration = forever; 
	stimulus_event {
		picture pauze_pic;
		time = 0;
		target_button = 1; 
		response_active = true; 
		port_code = 99;
	}breaky;
}pauze;
	
trial {
	trial_type = first_response;
	trial_duration = forever; 
	stimulus_event {
		picture einde;
		time = 0;
		target_button = 1; 
		response_active = true; 
		port_code = 99;
	};
}play_einde;


##############################################################

begin_pcl;

if (output_port_manager.port_count () == 0) then	###controls for whether you really have selected an output port
term.print ("Forgot to add an output port!!!")
end; 
output_port oport = output_port_manager.get_port (1);

loop until clock.time () >= 0 begin term.print(clock.time()); end;

###################################################################
###########GET INFO TXT FILE #######################################

input_file in = new input_file;							# opens the txt file with the relevant data
in.open( "example_list.txt"); ##Always check this
in.set_delimiter( '\t' );


# This is a hack to get the length of the list 
int i_stmfile = 0;  # Counter for (text) stimulus file; i_stmfile is here created
loop until
   in.end_of_file() || i_stmfile == 1000 || !in.last_succeeded() #file is 260 regels lang
begin
   i_stmfile = i_stmfile + 1;   
end;

# Set up vectors of colums in txt file (eg .wav file names) using the length
#strings before integers
array <string> jpg[i_stmfile]; # you give each array a name
array <string> wavfile[i_stmfile]; # you give each array a name
array <int> identity[i_stmfile];
array <int> number[i_stmfile];
array <int> block[i_stmfile]; #you now only have arrays

# Now you read in the actual filenames from each array per line
i_stmfile = 0;  # Counter for (text) stimulus file
loop until
   in.end_of_file() || i_stmfile == 1000 || !in.last_succeeded()
begin
   i_stmfile = i_stmfile + 1;
   jpg[i_stmfile] = in.get_string(); #because array is string
	wavfile[i_stmfile] = in.get_string(); #because array is string
	identity[i_stmfile] = in.get_int ();
	number[i_stmfile] = in.get_int ();
	block[i_stmfile] = in.get_int ();
end;
in.close();	# Close the file


### Starting with an attention grabber####


int cnt=1; # so you know which attention grabber to play, starting with the first 1

movies[cnt].prepare ();
attention_event.set_stimulus (movies[cnt]);
#feedback_txt.set_part (1, textcaption [cnt] );
feedback_trial.present(); # we start with an attention grabber
movies[cnt].release();

##############################
### MAIN TRIAL DEFINITION####
##############################

loop
   int i_trial = 1  #you create a new variable called 'i_trial' (1-240)
until
  i_trial > i_stmfile
#i_trial > 26

begin 

	####resetting parameters for each trial###
	string q = jpg[i_trial];
	bit.set_filename (q);
	bit.load();

	string f = wavfile[i_trial]; #new variable 'f' where the wavfile (as string) is defined as (abc.wav)
	s.set_filename (f); #reset; cf.  line 49 where s is defined, and line 189 where f is defined
	s.load();

	picevent.set_stimulus (pic1);
	picevent.set_event_code (jpg[i_trial]); #changes log code into name of picture

	picidentity.set_event_code (string (identity[i_trial]));
	picidentity.set_port_code (identity[i_trial]);

	picnumber.set_event_code (string (number[i_trial]));
	picnumber.set_port_code (number[i_trial]);

	wavevent.set_stimulus( snd );
	wavevent.set_event_code (wavfile[i_trial]);

	wavidentity.set_event_code (string (identity[i_trial]));
	wavidentity.set_port_code (identity[i_trial]);

	wavnumber.set_event_code (string (number[i_trial]));
	wavnumber.set_port_code (number[i_trial]);

	background.set_event_code (string (block[i_trial]));
	background.set_port_code (block[i_trial]);
	background.set_target_button (1);

	trial1.present();

	bit.unload();
	s.unload(); #unload so that new wav file can be played 

	isi.present ();

	int type = stimulus_manager.last_stimulus_data().type();
	if (type ==stimulus_hit) then
		if cnt > 5 then 
			cnt = 1
		else 
			cnt = cnt+1;
		end;
		
		movies[cnt].prepare ();
		attention_event.set_stimulus (movies[cnt]);
		#feedback_txt.set_part (1, textcaption [cnt] );
		feedback_trial.present();
		movies[cnt].release ();
	elseif (type == stimulus_miss) then #so with no key press it just continues to the next line
		#Nothing here.
	end; #end of if-when to play an attention grabber
 
	if (i_trial == 48 || i_trial == 96 || i_trial == 144 || i_trial == 192) then
		if cnt > 5 then 
			cnt = 1
		else 
			cnt = cnt+1;
		end;
		pauze.present (); #"PAUZE!"
		movies[cnt].prepare ();
		attention_event.set_stimulus (movies[cnt]);
		#feedback_txt.set_part (1, textcaption [cnt] );
		feedback_trial.present();
		movies[cnt].release ();
  end;
  
  if (i_trial == 240) then
	play_einde.present ();
  end;

  i_trial = i_trial + 1 ; 
end;

 /* if (i_trial == 104) then
		if cnt > 6 then cnt = 1
		else cnt = cnt+1;
		end;
	pauze.present ();
	movies[cnt].prepare ();
	attention_event.set_stimulus (movies[cnt]);
	#feedback_txt.set_part (1, textcaption [cnt] );
	feedback_trial.present();
	movies[cnt].release ();
  end;
  
   if (i_trial == 156) then
		if cnt > 6 then cnt = 1
		else cnt = cnt+1;
		end;
	pauze.present ();
	movies[cnt].prepare ();
	attention_event.set_stimulus (movies[cnt]);
	#feedback_txt.set_part (1, textcaption [cnt] );
	feedback_trial.present();
	movies[cnt].release ();
  end;
  
  if (i_trial == 208) then
		if cnt > 6 then cnt = 1
		else cnt = cnt+1;
		end;
	pauze.present ();
	movies[cnt].prepare ();
	attention_event.set_stimulus (movies[cnt]);
	#feedback_txt.set_part (1, textcaption [cnt] );
	feedback_trial.present();
	movies[cnt].release ();
  end;
*/