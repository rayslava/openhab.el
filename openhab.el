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

(require 'openhab-items-mode)
(require 'openhab-things-mode)

(provide 'openhab)

;;; mylsl-mode.el ends here
