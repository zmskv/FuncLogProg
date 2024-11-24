prepod(arkadjeva, geografia).
prepod(babanova, angliyskiy).
prepod(korsakova, frantsuzskiy).
prepod(dashkov, nemetskiy).
prepod(iljin, matematika).
prepod(flerov, istoriya).

studied_together(arkadjeva, babanova). 
oldest_and_experienced(babanova).      
father(flerov, korsakova).             
graduated_and_teaching(iljin).         
gymnastics(dashkov, iljin).          

question(Who, Subject) :-
    prepod(Who, Subject).
