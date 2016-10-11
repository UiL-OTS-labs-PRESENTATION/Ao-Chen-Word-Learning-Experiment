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
scenario = "word_learning.sce";
pcl_file = "word_learning_main.pcl";

#no_logfile = true;
scenario_type = trials;

#write_codes = true; #		#WRITE CODES TO LOG/EEG PC
write_codes = false;

pulse_width= 20; 

response_matching = simple_matching;

# define button codes, 3=enter/return, 1=space(down), 2=space(up) where pressing space down indicates a looking behaviour and space up indicates looking away
active_buttons 				= 3;
button_codes 					= 3,1,2;
response_logging 				= log_active;

default_font_size 			= 48;
default_background_color 	= 82, 82, 82;

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

text {caption = "PAUZE"; } pauze_txt;
text {caption = "EINDE       BEDANKT!"; } einde_txt;

picture {
	background_color = 82, 82, 82;
	text pauze_txt; 
	x = 0;
	y = 0;  
} pauze_pic; #pauze_pic

picture {
	background_color = 82, 82, 82;
} default; #default

picture {
	background_color = 82, 82, 82;
	text einde_txt; 
	x = 0;
	y = 0;  
}einde; #einde picture


################# DEFINE TRIALS
trial {
	trial_type = first_response;
	trial_duration = stimuli_length; 
	picture default;
	stimulus_event {
		nothing{};
		time = 0;
		target_button = 1; #enter
		response_active = true; 
		port_code = 100;
		code = "attentiongrabber";
	} attention_event;
} attentiongrabber_trial;
	
trial { 
	trial_duration = 2200;
	monitor_sounds = true;
	all_responses = false;
	
		stimulus_event{
			picture pic1;        # Show picture ; pic1 will be overwritten in pcl
				time = 0;
				code = "onset picture"; #will be given name of image file
				port_code = 53;
		}picevent;					# The event of presenting picture is called 'picevent'
			
		stimulus_event{
			nothing {};
			deltat = 50; 
		}picidentity;	#gives information to which part of the block and what kind of block the picture belongs to
			
		stimulus_event{
			nothing {};
			deltat = 50; 
		}picnumber;	#gives information to which presentation in the training block [1-6] or match/mismatch or eyetracking it has
				
		stimulus_event{          # play target word                
			sound snd;
				time = 1000;
		}wavevent;               # the event of presenting the wav file is called wavevent   

		stimulus_event{
			nothing {};
			deltat = 50; 
			code = "placeholder"; #overwritten in pcl
			port_code = 21; #ibid
		} wavidentity;	#gives information to which part of the block and what kind of block the wav belongs to
			
		stimulus_event{
			nothing {};
			deltat = 50; 
			code = "placeholder"; #overwritten in pcl
			port_code = 16; #ibid
		} wavnumber;	#gives information to which presentation in the training block [1-6] or match/mismatch or eyetracking
         
} main_trial;			
					
trial {
	trial_duration = 1000; # duration of trial
	all_responses = false;
		stimulus_event {
			picture default;  #as defined in sdl
			time = 0;
			code = "isi: bloknummer"; 
			port_code = 999; # overwritten in pcl
		}background;
} inter_stimuli_interval;


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