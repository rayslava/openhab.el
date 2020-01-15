;;; openhab-items-mode.el --- Items files highlighting -*- lexical-binding: t -*-

;; Copyright (C) 2014-2016 Free Software Foundation, Inc.

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
;;  This package provide the major `openhab-items-mode' which supports editing
;;  openhab *.items files

;;; Code:

(defconst openhab-items-keywords
  (let* (
	 (x-types '("Color" "Contact" "DateTime" "Dimmer"
		    "Group" "Image" "Location" "Number"
		    "Player" "Rollershutter" "String" "Switch"))
	 (x-types-regexp (regexp-opt x-types 'word)))
    `(
      (,x-types-regexp . font-lock-type-face)
      ("\"\\.\\*\\?" . font-lock-string-face)
      (,(concat (regexp-opt x-types 'non-nil) "[[:space:]]+?\\([[:alnum:]_]+\\)[[:space:]]+?") 2 font-lock-variable-name-face)
      ("<\\(\\w*\\)>" . font-lock-constant-face))))

(defvar openhab-items-mode-syntax-table
  (let ((st (make-syntax-table)))
    (modify-syntax-entry ?_ "w" st)
    (modify-syntax-entry ?< "(>" st)
    (modify-syntax-entry ?> ")<" st)
    st)
  "Syntax table for `sample-mode'.")

(defvar openhab-items-mode-hook nil)

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.items\\'" . openhab-items-mode))

; This can replace (defun wpdl-mode ()...
(define-derived-mode openhab-items-mode fundamental-mode "OpenHAB Items"
  "Major mode for editing OpenHAB Items files."
  :syntax-table openhab-items-mode-syntax-table
  (set (make-local-variable 'font-lock-defaults) '(openhab-items-keywords)))

(provide 'openhab-items-mode)
;;; openhab-items-mode.el ends here
