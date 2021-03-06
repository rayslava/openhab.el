;;; openhab-rules-mode.el --- Rules files highlighting -*- lexical-binding: t -*-

;; Copyright (C) 2020 Slava Barinov

;; Author: Slava Barinov (rayslava@gmail.com)
;; Version: 0.0.1
;; Created: 15 Jan 2020
;; Keywords: languages openhab
;; Homepage: https://github.com/rayslava/openhab.el

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2, or (at
;; your option) any later version.

;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:
;;
;;  This package provide the major `openhab-rules-mode' which supports editing
;;  openhab *.rules files

;;; Code:

(require 'smie)
(require 'openhab-items-mode)

(defconst openhab-rules-trigger-keywords
  '("item" "member of" "time" "system" "thing" "channel"))

(defconst openhab-rules-action-keywords
  '("received" "update" "changed" "started" "from" "to" "triggered"))

(defconst openhab-rules-keywords
  (let* (
	 (x-var-def-keywords '("val" "var"))
	 (x-keywords '("true" "false" "rule" "when" "and" "or" "then" "end" "if"
		       "null"))
	 (x-keywords-regexp
	  (regexp-opt (append
		       x-keywords x-var-def-keywords
		       openhab-rules-trigger-keywords
		       openhab-rules-action-keywords) 'words))
	 (x-types-regexp (regexp-opt openhab-items-types 'words)))
    `(
      (,x-keywords-regexp . font-lock-keyword-face)
      (,x-types-regexp . font-lock-type-face)
      ("\"\\.\\*\\?" . font-lock-string-face)
      (,(concat (regexp-opt openhab-rules-trigger-keywords 'nil) "[[:space:]]+?\\([[:alnum:]_:]+\\)") 1 font-lock-constant-face)
      (,(concat (regexp-opt x-var-def-keywords 'nil) "[[:space:]]+?\\([[:alnum:]_:]+\\)") 1 font-lock-variable-name-face))))

(defvar openhab-rules-mode-syntax-table
  (let ((st (make-syntax-table)))
    (modify-syntax-entry ?_ "w" st)
    (modify-syntax-entry ?< "(>" st)
    (modify-syntax-entry ?> ")<" st)
    (modify-syntax-entry ?/ ". 12b" st)
    (modify-syntax-entry ?\n "> b" st)
    st)
  "Syntax table for `sample-mode'.")

(defvar openhab-rules-mode-hook nil)

(defconst openhab-rules-smie-grammar
  (smie-prec2->grammar
   (smie-bnf->prec2
    '((id)
      (rules (rule)
	     (rule "\n" rule))
      (rule ("rule" rulename "when" rulecond "then" insts "end"))

      (rulename (id))
      (rulecond (rulecond "or" rulecond)
		(rulecond "and" rulecond)
		(trigger " " action))
      (trigger (openhab-rules-trigger-keywords))
      (action (openhab-rules-action-keywords))
      (insts (insts "\n" insts))
      (exp (exp "+" exp)
	   (exp "*" exp)
	   ("(" exps ")")
	   (id))
      (exps (exps "," exps) (exp)))
    '((assoc "\n")
      (assoc ",")
      (assoc ":")
      (assoc "+=" "=")
      (assoc "or")
      (assoc "and")
      (assoc "==" "!=" "<" "<=" ">" ">=")
      (assoc "+" "-")
      (assoc "*" "/" "%")
      (assoc ".")
      ))
   ))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.rules\\'" . openhab-rules-mode))

; This can replace (defun wpdl-mode ()...
(define-derived-mode openhab-rules-mode fundamental-mode "OpenHAB Rules"
  "Major mode for editing OpenHAB Rules files."
  :syntax-table openhab-rules-mode-syntax-table
  (set (make-local-variable 'font-lock-defaults) '(openhab-rules-keywords nil t))
  (set (make-local-variable 'comment-start) "//")
  (smie-setup openhab-rules-smie-grammar #'ignore))

(provide 'openhab-rules-mode)
;;; openhab-rules-mode.el ends here
