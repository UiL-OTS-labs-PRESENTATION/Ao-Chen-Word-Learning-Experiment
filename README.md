# Ao-Chen-Word-Learning-Experiment
Presentation® Experiment for recording mismatch negativity ERP's around word learning.

Each trial consists of the following parts, see _input lists_ below.
* Present `SOUND_FILE` and send `ONSET_TRIGGER`
* Present `IMAGE_FILE` from `START1_` to `STOP1`, at onset send trigger *53*
* Present `IMAGE_FILE` from `START2` to `STOP2` , at onset send trigger *54*

If `IMAGE_FILE` is one of the following no picture will be shown:
* empty
* 'EMPTY'
* 'empty'
* 'BLANK'
* 'blank'

During training phase each trial is a group/set of three sub trials. 
During test phase each trial consists of a group/set of a single sub trial.
Being a member of a trial group is indicated via the input list.

# Important Keys
* *Enter or Return* continues the attention grabber and pause
* *Space (down)* indicates the start of a looking epoch
* *Space (up)* indicates the end of a looking epoch

# Input Lists
An input list should be a tab-delimited text file with _no empty line_ at the end of the file. 
It should have the following columns:
* `UNIQUE_IDENTITY`: a unique number for each trial
* `BLOCK`: block number (`1` for training test, `2` for test phase)
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