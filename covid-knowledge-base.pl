go:-
/*hypothesis(disease),*/ recommend(Action),
write('I believe that you should '),
( write(Action), !);
write('You are fine. Stay safe.'),!.
/*Hypothesis that should be tested*/
recommend("seek medical attention") :- major_symptom. recommend("self-isolate and await more symptoms") :- minor_symptoms.
hypothesis(covid) :- major_symptom;minor_symptoms. hypothesis("flu like symptoms") :- fls. hypothesis(fever) :- fever. hypothesis(infectious_situation) :- infectious_situation.
major_symptom:-
verify("dry cough"); hypothesis(fever); verify("difficulty breathing").
minor_symptoms:-
hypothesis("flu like symptoms"); hypothesis(infectious_situation), verify('diarrhea'),
verify('loss of taste of smell').
fls :-
  verify(headache);
  verify(runny_nose);
  verify(sneezing);
  verify(sore_throat).
fever :-
verify('high tempreture');
( verify(chills),
verify(aches),
verify('sore eyes'), verify('muscle pain'), verify(headache)).
infectious_situation :-
( verify_action("travel to highly infected location recently (within
the last 2 weeks)"));
( verify_action("Interacted with someone who has travelled to a
highly infected location"));
verify_action("Interacted with someone while that person was sick"); verify_action("Work in a field that puts you at risk of infection").
/* how to ask questions */
ask(Question) :-
write('Do you have:'),
  write(Question),
  write('? '),
  read(Response),
nl,
( (Response == yes ; Response == y) ->
assert(yes(Question)) ; assert(no(Question)), fail).
:- dynamic yes/1,no/1.
/*How to verify something */
verify(S) :-
(yes(S)
->
true ;
(no(S)
->
fail ;
ask(S))).
ask_action(Question) :-
  write('Did you: '),
  write(Question),
  write('? '),
  read(Response),
nl,
( (Response == yes ; Response == y) ->
assert(yes(Question)) ; assert(no(Question)), fail).
:- dynamic yes/1,no/1.
/*How to verify something */ verify_action(S) :-
(yes(S)
->
true ;
(no(S)
->
fail ;
ask_action(S))).
/* undo all yes/no assertions*/ undo :- retract(yes(_)),fail. undo :- retract(no(_)),fail. undo.