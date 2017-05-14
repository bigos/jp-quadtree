(declaim (optimize (debug 3) (speed 0)))

(in-package :jp-quadtree)


(defun hello ()
  (format t "I'm going to implement quadtree"))

(defstruct node
  (element)
  (size)
  (central-point)
  (top-left)
  (top-right)
  (bottom-left)
  (bottom-right))

(defun qualifier (central-point coords)
  (if (>= (car central-point) (car coords))
      (if (>= (cdr central-point) (cdr coords))
          :bottom-left
          :top-left)
      (if (>= (cdr central-point) (cdr coords))
          :bottom-right
          :top-right)))

(defun root-node-creator ()
  (make-node :element (cons 0 0) :size (cons 10 10) :central-point (cons 5 5)))

(defun pair-fn (fn a b)
  "Run a function FN using pairs A and B as arguments."
  (cons (funcall fn (car a) (car b))
        (funcall fn (cdr a) (cdr b))))

(defun quadrant-functions (quadrant)
  (cond
    ((eq quadrant :top-left)     (cons '- '+))
    ((eq quadrant :top-right)    (cons '+ '+))
    ((eq quadrant :bottom-right) (cons '+ '-))
    ((eq quadrant :bottom-left)  (cons '- '-))
    (T (error "wrong quadrant"))))

(defun create-subnode (node quadrant)
  "Create a sub node based on QUADRANT with correct central-point."
  (let* ((quadrant-functions (quadrant-functions quadrant))
         (vector-distances (pair-fn (lambda (a b) (floor (/ a b))) (node-size node) (cons 4 4)))
         (new-central-point (cons
                             (funcall (car quadrant-functions)
                                      (car (node-central-point node)) (car vector-distances))
                             (funcall (cdr quadrant-functions)
                                      (cdr (node-central-point node)) (cdr vector-distances))))
         (new-size (pair-fn (lambda (a b) (floor (/ a b))) (node-size node) (cons 2 2))))
    (cond ((eq quadrant :top-right)
           (if (null (node-top-right node))
               (setf (node-top-right node)
                     (make-node :size new-size :central-point new-central-point))
               (create-subnode (node-top-right node) :top-right)))
          (T (error "not implemented")))
    node))
