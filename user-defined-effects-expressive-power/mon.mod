module mon.
accumulate auto-mon.

mon/wf-eff (mon/cons Eff C _ _) :-
    mon/wf-eff Eff,
    pi a\ mon/wf-valty a => mon/wf-compty Eff (C a).

mon/plug (mon/evctx/reify E T) M (mon/reify EM T) :-
    mon/plug E M EM.

mon/reduce (mon/reify (mon/ret V) (mon/mon Nu _)) (Nu V).
mon/reduce (mon/reify ERN (mon/mon Nu Nb)) (Nb (mon/thunk N) (mon/thunk (mon/fun (x\ mon/reify (ER x) (mon/mon Nu Nb))))) :-
    mon/plug E (mon/reflect N) ERN,
    mon/hoisting E,
    pi x\ mon/plug E (mon/ret x) (ER x).

mon/of-monad (mon/mon Nu Nb) (mon/cons Eff C Nu Nb) :-
    pi a\ pi x\ (mon/wf-valty a => mon/of-value x a => mon/of-comp (Nu x) Eff (C a)),
    pi a\ pi b\ pi x\ pi k\ (mon/wf-valty a => mon/wf-valty b => mon/of-value x (mon/u Eff (C a)) => mon/of-value k (mon/u Eff (mon/arrow a (C b))) => mon/of-comp (Nb x k) Eff (C b)).

mon/of-comp' (mon/reify N T) Eff (C A) :-
    mon/of-monad T (mon/cons Eff C Nu Nb),
    mon/of-comp N (mon/cons Eff C Nu Nb) (mon/f A).
mon/of-comp' (mon/reflect N) (mon/cons Eff C Nu Nb) (mon/f A) :-
    mon/of-comp N Eff (C A).
mon/of-evctx' (mon/evctx/reify E T) Eff1 D Eff (C A) :-
    mon/of-monad T (mon/cons Eff C Nu Nb),
    mon/of-evctx E Eff1 D (mon/cons Eff C Nu Nb) (mon/f A).

mon/progresses ES (mon/cons _ _ _ _) :-
    mon/hoisting E,
    mon/plug E (mon/reflect _) ES.
