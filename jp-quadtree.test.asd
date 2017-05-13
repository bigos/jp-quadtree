#|
  This file is a part of jp-quadtree project.
  Copyright (c) 2017 Jacek Podkanski (ruby.object@googlemail.com)
|#


(in-package :cl-user)
(defpackage jp-quadtree.test-asd
  (:use :cl :asdf))
(in-package :jp-quadtree.test-asd)


(defsystem jp-quadtree.test
  :author "Jacek Podkanski"
  :mailto "ruby.object@googlemail.com"
  :description "Test system of jp-quadtree"
  :license "LLGPL"
  :depends-on (:jp-quadtree
               :fiveam)
  :components ((:module "t"
                :components
                ((:file "package"))))
  :perform (test-op :after (op c) (eval
 (read-from-string
  "(let ((res (5am:run :jp-quadtree)))
     (explain! res)
     (every #'fiveam::TEST-PASSED-P res))"))
))
