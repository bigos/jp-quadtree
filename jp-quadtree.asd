#|
  This file is a part of jp-quadtree project.
  Copyright (c) 2017 Jacek Podkanski (ruby.object@googlemail.com)
|#

#|
  quadtree implementation

  Author: Jacek Podkanski (ruby.object@googlemail.com)
|#



(in-package :cl-user)
(defpackage jp-quadtree-asd
  (:use :cl :asdf))
(in-package :jp-quadtree-asd)


(defsystem jp-quadtree
  :version "0.1"
  :author "Jacek Podkanski"
  :mailto "ruby.object@googlemail.com"
  :license "LLGPL"
  :depends-on (:alexandria :iterate)
  :components ((:module "src"
                :components
                ((:file "package")
                 (:file "quadtree"))))
  :description "quadtree implementation"
  :in-order-to ((test-op (test-op :jp-quadtree.test))))
