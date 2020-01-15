;;; openhab.el --- set of modes for editing openhab files  -*- coding: utf-8; lexical-binding: t; -*-

;; Copyright (C) 2020 Slava Barinov

;; Author: Slava Barinov (rayslava@gmail.com)
;; Version: 0.0.1
;; Created: 15 Jan 2020
;; Keywords: languages openhab
;; Homepage: https://github.com/rayslava/openhab.el

;; This file is not part of GNU Emacs.

;;; License:

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

;; Support for OpenHAB files (things, items, rules, sitemaps)

;; OpenHAB files editing support

;;; Code:
(setq mylsl-font-lock-keywords
      (let* (
            ;; define several category of keywords
            (x-keywords '("break" "default" "do" "else" "for" "if" "return" "state" "while"))
            (x-types '("float" "integer" "key" "list" "rotation" "string" "vector"))
            (x-constants '("ACTIVE" "AGENT" "ALL_SIDES" "ATTACH_BACK"))
            (x-events '("at_rot_target" "at_target" "attach"))
            (x-functions '("llAbs" "llAcos" "llAddToLandBanList" "llAddToLandPassList"))

            ;; generate regex string for each category of keywords
            (x-keywords-regexp (regexp-opt x-keywords 'words))
            (x-types-regexp (regexp-opt x-types 'words))
            (x-constants-regexp (regexp-opt x-constants 'words))
            (x-events-regexp (regexp-opt x-events 'words))
            (x-functions-regexp (regexp-opt x-functions 'words)))

        `(
          (,x-types-regexp . font-lock-type-face)
          (,x-constants-regexp . font-lock-constant-face)
          (,x-events-regexp . font-lock-builtin-face)
          (,x-functions-regexp . font-lock-function-name-face)
          (,x-keywords-regexp . font-lock-keyword-face)
          ;; note: order above matters, because once colored, that part won't change.
          ;; in general, put longer words first
          )))

;;;###autoload
(define-derived-mode mylsl-mode c-mode "lsl mode"
  "Major mode for editing LSL (Linden Scripting Language)…"

  ;; code for syntax highlighting
  (setq font-lock-defaults '((mylsl-font-lock-keywords))))

;; add the mode to the `features' list
(provide 'openhab)

;;; mylsl-mode.el ends here
