;;; openhab-things-mode.el --- Things files highlighting -*- lexical-binding: t -*-

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
;;  This package provide the major `openhab-things-mode' which supports editing
;;  openhab *.things files

;;; Code:

(require 'openhab-items-mode)

(defconst openhab-things-keywords
  (let* (
	 (x-keywords '("Thing" "Bridge" "Type" "Channels"))
	 (x-keywords-regexp (regexp-opt x-keywords 'words))
	 (x-types-regexp (regexp-opt openhab-items-types 'words)))
    `(
      (,x-keywords-regexp . font-lock-keyword-face)
      (,x-types-regexp . font-lock-type-face)
      ("\"\\.\\*\\?" . font-lock-string-face)
      (,(concat (regexp-opt x-keywords 'nil) "[[:space:]]+?\\([[:alnum:]_:]+\\)[[:space:]]+?") 1 font-lock-constant-face)
      (,(concat (regexp-opt openhab-items-types 'nil) "[[:space:]]*?:[[:space:]]*?\\([[:alnum:]_:]+\\)") 1 font-lock-variable-name-face))))

(defvar openhab-things-mode-syntax-table
  (let ((st (make-syntax-table)))
    (modify-syntax-entry ?_ "w" st)
    (modify-syntax-entry ?< "(>" st)
    (modify-syntax-entry ?> ")<" st)
    st)
  "Syntax table for `sample-mode'.")

(defvar openhab-things-mode-hook nil)

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.things\\'" . openhab-things-mode))

; This can replace (defun wpdl-mode ()...
(define-derived-mode openhab-things-mode fundamental-mode "OpenHAB Things"
  "Major mode for editing OpenHAB Things files."
  :syntax-table openhab-things-mode-syntax-table
  (set (make-local-variable 'font-lock-defaults) '(openhab-things-keywords nil t)))

(provide 'openhab-things-mode)
;;; openhab-things-mode.el ends here
