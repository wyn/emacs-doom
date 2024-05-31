;;; utils.el -*- lexical-binding: t; -*-

(defun kbee-make-full-frame ()
"Makes a new frame at double height."
(interactive)
  (make-frame '((name . "KBEE-full")
                (top . 1000)
                (left . 0)
                (left-fringe . 0)
                (right-fringe . 0)
                (vertical-scroll-bars . right)
                (width . (text-pixels . 2540))
                (height . (text-pixels . 3150)))))


(defun kbee-make-half-frame ()
"Doc-string."
(interactive)
  (make-frame '((name . "KBEE-half")
                (top . 1000)
                (left . 0)
                (left-fringe . 0)
                (right-fringe . 0)
                (vertical-scroll-bars . right)
                (width . (text-pixels . 2540))
                (height . (text-pixels . 1500)))))
