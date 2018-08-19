.data? 
CommandLine                                     DWORD ? 
hInstance                                       DWORD ? 
hWindow                                         DWORD ? 
rWindow                                         DWORD ? 
param                                           DWORD ? 
window_class_1                                  DB  SIZEOF WNDCLASSEX dup (?) 
string1                                         DB  512 dup (?) 
string2                                         DB  512 dup (?) 
main_run                                        DWORD ? 
screen_w                                        DWORD ? 
screen_h                                        DWORD ? 
log_filename                                    DB  512 dup (?) 

;; startwindow child handles: 
s_window                                        DWORD ? 
s_button1                                       DWORD ? 
s_button2                                       DWORD ? 
s_button3                                       DWORD ? 
s_finish                                        DWORD ? 

;; fullwindow child handles: 
f_window                                        DWORD ? 
f_edit1                                         DWORD ? 
f_edit2                                         DWORD ? 
f_button1                                       DWORD ? 
f_finish                                        DWORD ? 

;; The test variables: 
t_x                                             DWORD ? 
t_y                                             DWORD ? 
t_a                                             DWORD ? 
t_b                                             DWORD ? 
t_w                                             DWORD ? 
t_h                                             DWORD ? 
t_attempt                                       DWORD ? 
t_try                                           DWORD ? 
t_taker                                         DWORD ? 
t_time1                                         DWORD ? 
t_time2                                         DWORD ? 
t_gender                                        DB  16  dup (?) 
test_log                                        DB  512 dup (?) 

;; Other variables: 
time                                            SYSTEMTIME <> 
last_rand                                       DWORD ? 
