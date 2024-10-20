:- set_prolog_flag(encoding, utf8).

:- consult('two.pl').

start_interface :-
    write('Главное меню'), nl,
    menu.

% Меню выбора
menu :-
    write('Выберите опцию:'), nl,
    write('1. Показать средний балл по всем предметам'), nl,
    write('2. Показать количество не сдавших студентов в каждой группе'), nl,
    write('3. Показать количество не сдавших студентов по каждому предмету'), nl,
    write('4. Выход'), nl,
    read(Choice),
    handle_choice(Choice).

% Обработка выбора пользователя
handle_choice(1) :-
    print_average_grades,
    menu.
handle_choice(2) :-
    print_failed_students_per_group,
    menu.
handle_choice(3) :-
    print_failed_students_per_subject,
    menu.
handle_choice(4) :-
    write('Выход из системы...'), nl.
handle_choice(_) :-
    write('Неверный выбор, попробуйте снова.'), nl,
    menu.


% Предикат для вычисления среднего балла по предмету
average_grade_per_subject(Subject, Average) :-
    findall(Grade, grade(_, _, Subject, Grade), Grades),
    (   Grades = []
    ->  Average = 0  % Handle case with no grades
    ;   sum_list(Grades, Sum),
        length(Grades, Count),
        Average is Sum / Count
    ).

% Предикат для вывода среднего балла по всем предметам
print_average_grades :-
    findall(Subject, grade(_, _, Subject, _), Subjects),
    list_to_set(Subjects, UniqueSubjects),
    forall(member(Subject, UniqueSubjects),
           (average_grade_per_subject(Subject, Average),
            format('Средний балл по предмету "~w": ~2f~n', [Subject, Average]))).

% Предикат для определения, является ли студент не сдавшим
failed_student(Group, Student) :-
    grade(Group, Student, _, Grade),
    Grade < 3.

% Предикат для подсчета количества не сдавших студентов в группе
count_failed_students_in_group(Group, Count) :-
    findall(Student, failed_student(Group, Student), FailedStudents),
    list_to_set(FailedStudents, UniqueFailedStudents),
    length(UniqueFailedStudents, Count).

% Предикат для вывода количества не сдавших студентов в каждой группе
print_failed_students_per_group :-
    findall(Group, grade(Group, _, _, _), Groups),
    list_to_set(Groups, UniqueGroups),
    forall(member(Group, UniqueGroups),
           (count_failed_students_in_group(Group, Count),
            format('Количество не сдавших студентов в группе ~w: ~w~n', [Group, Count]))).

% Предикат для определения, является ли студент не сдавшим по предмету
failed_student_in_subject(Subject, Student) :-
    grade(_, Student, Subject, Grade),
    Grade < 3.

% Предикат для подсчета количества не сдавших студентов по предмету
count_failed_students_in_subject(Subject, Count) :-
    findall(Student, failed_student_in_subject(Subject, Student), FailedStudents),
    list_to_set(FailedStudents, UniqueFailedStudents),
    length(UniqueFailedStudents, Count).

% Предикат для вывода количества не сдавших студентов по каждому предмету
print_failed_students_per_subject :-
    findall(Subject, grade(_, _, Subject, _), Subjects),
    list_to_set(Subjects, UniqueSubjects),
    forall(member(Subject, UniqueSubjects),
           (count_failed_students_in_subject(Subject, Count),
            format('Количество не сдавших студентов по предмету "~w": ~w~n', [Subject, Count]))).