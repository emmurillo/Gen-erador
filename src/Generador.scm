(load "Archivos.scm")
(load "Operadores.scm")
(load "Listas.scm")

;OPERACIONES DE ARBOLES

; Genera un individuo de mínimo 1 de altura
(define crea-individuo
  (lambda ()
    (list (operador-random)
          (crea-individuo-aux)
          (crea-individuo-aux))))

; Genera un individuo aleatoriamente
(define crea-individuo-aux
  (lambda ()
    (cond ((< (random) 0.6) (crea-hoja))
          (else
           (list (operador-random)
                 (crea-individuo-aux)
                 (crea-individuo-aux)
                 )))))

;Determina el valor de una hoja
(define crea-hoja
  (lambda ()
    (cond ((< (random) 0.15) 'x)
          ((< (random) 0.30) 'y)
          (else
           (- 10 (random 20))))))

;Crea la población de tamaño cantidad
(define crear-poblacion
  (lambda (cantidad)
    (cond ((= cantidad 0) '())
          (else (cons (crea-individuo) (crear-poblacion (- cantidad 1) ) )))))

;Dados x y y pasa por parámetros los valores y evalua en el individuo
(define mostrar-individuo
  (lambda (individuo x y)
    (display individuo) (newline)
    (display ((eval (cons 'lambda(cons '(x y) (list individuo)))) x y))
    (display (newline))))

;Dados x y y pasa por parámetros los valores y evalua en el individuo
(define eval-individuo
  (lambda (individuo x y)
    ((eval (cons 'lambda(cons '(x y) (list individuo)))) x y)))

;Obtiene los z del individuo
(define z-individuo
  (lambda (indiv)
    (display indiv)(newline)
    (z-individuo-aux indiv (obtener-x-y))))

(define z-individuo-aux
  (lambda (indiv lista)
    (cond ((null? lista) '())
          (else
           (cons (eval-individuo indiv (caar lista) (cadar lista)) (z-individuo-aux indiv (cdr lista)))))))


