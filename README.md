# Ao-Chen-Word-Learning-Experiment
Presentation® Experiment for recording mismatch negativity ERP's around word 
learning. Words and image pairs are meant to be learned during the training 
phase and the detection of miss matches during the test phase.

The target participants are young children. Hence an attention grabber is 
introduced in the form of an small movie. The attention grabber is played at the 
start of the experiment and following every pause.

Each trial in the experiment consists of the following parts, see _input lists_ 
below.
* Present `SOUND_FILE` and send `ONSET_TRIGGER`
* Present `IMAGE_FILE` from `START1_` to `STOP1`, at onset send `trigger 53`
* Present `IMAGE_FILE` from `START2` to `STOP2` , at onset send `trigger 54`

If `IMAGE_FILE` is one of the following no picture will be shown:
* empty
* 'EMPTY'
* 'empty'
* 'BLANK'
* 'blank'

During the block that represent a training phase each group/set consists of three sub trials. 
During the block that represents a trest phase each group/set consists of a single sub trial.
Members of sub trials are indicated via the `GROUP_IDENTITY` column in the input list.


# Important Keys
The following keys are relevant in the experiment.
* *Enter or Return* continues the attention grabber and pause, sends `trigger 3`
* *Space (down)* indicates the start of a looking epoch, sends `trigger 1`
* *Space (up)* indicates the end of a looking epoch, sends `trigger 2`

# Input Lists
An input list should be a tab-delimited text file with _no empty line_ at the end of the file. 
It should have the following columns:
* `UNIQUE_IDENTITY`: a unique number for each trial
* `BLOCK`: `1` for training phase, `2` for test phase)
* `GROUP_IDENTITY`: if sub trial belongs to a group/set of trials (used for randomisation)
* `IMAGE_FILE`
* `START1`
* `STOP1`
* `START2`
* `STOP2`
* `SOUND_FILE`
* `ONSET_TRIGGER`

# Example Input List

| UNIQUE_IDENTITY | BLOCK | GROUP_IDENTITY | IMAGE_FILE  | START1 | STOP1 | START2 | STOP2 | SOUND_FILE | ONSET_TRIGGER |
|-----------------|-------|----------------|-------------|--------|-------|--------|-------|------------|---------------|
| 1               | 1     | 1              | BLANK       | 0      | 1000  | 0      | 0     | kitty.wav  | 10            |
| 2               | 1     | 1              | figure2.png | 0      | 1000  | 0      | 0     | kitty.wav  | 10            |
| 3               | 1     | 1              | figure3.png | 0      | 600   | 800    | 1000  | kitty.wav  | -1            |
| 4               | 1     | 2              | BLANK       | 0      | 1000  | 0      | 0     | kitty.wav  | 10            |
| 5               | 1     | 2              | figure2.png | 0      | 1000  | 0      | 0     | kitty.wav  | 10            |
| 6               | 1     | 2              | figure3.png | 0      | 600   | 800    | 1000  | kitty.wav  | -1            |
| 7               | 2     | 3              | figure1.png | 0      | 1000  | 0      | 0     | kitty.wav  | 11            |
| 8               | 2     | 4              | figure1.png | 0      | 1000  | 0      | 0     | kitty.wav  | 11            |
| 9               | 2     | 5              | figure1.png | 0      | 1000  | 0      | 0     | kitty.wav  | 11            |

# Randomisation
Order of groups of sub trials is randomised via a regular shuffle. 
However, to keep the order of training phase and test phase correct the following is important. 
The training phase is considered to run to the end of the block 1 trials.
The test phase is considered to start from the change from block 1 to block 2.

# Import: before experimental usage
Do not forget to set the `write_codes = false;` to `write_codes = true;` in _word_learning.sce_


# Experiment Requestee
[dr. Ao Chen](http://www.uu.nl/staff/AChen/0)

# Acknowledgements
The original script comes from Doug Davidson; modified by Petra van Alphen; modified again by Caroline Junge, June 2008 (caroline.junge@mpi.nl). 
A heavy rewrite was done by Chris van Run (UiL OTS, Oktober 2016).