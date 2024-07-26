;;; smartpy.el -*- lexical-binding: t; -*-

(add-to-list 'auto-mode-alist '("\\.spy\\'" . python-mode))


(defun magit-log-in-dir-since-date (dir date)
  "Show the log for DIR since DATE."
  (interactive "DDirectory: \nsSince the date: ")
  (magit-log-current nil (list "--since" date) (list (file-relative-name dir (magit-toplevel))))
  )
