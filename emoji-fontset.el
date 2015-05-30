;;; emoji-fontset.el --- Set font face for Emoji.

;; Copyright (C) 2015 USAMI Kenta

;; Author: USAMI Kenta <tadsan@zonu.me>
;; Created: 31 May 2015
;; Version: 0.0.1
;; Keywords: emoji font config

;; This file is NOT part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; I recommend that you install the Symbola font.
;; http://users.teilar.gr/~g1951d/
;; (It should do so even in the Mac OS X. "Apple Color Emoji" is too heavy.)

;; put into your own .emacs file (init.el)

;;   (custom-set-variables
;;     '(emoji-fontset/font-family "Symbola"))
;;
;;   (emoji-fontset/turn-on)

;;; Code:

(defcustom emoji-fontset/default-font-family "Symbola"
  "Default Font Family Emoji for Emoji."
  :type '(string))

(defcustom emoji-fontset/font-families
  '((ns  "Apple Color Emoji")
    (w32 "Segoe UI Emoji"))
  "Assoc list of Font Family for Emoji by `WINDOW-SYSTEM'."
  :type '(repeat (cons symbol string)))

(defconst emoji-fontset/codepoint
  '((#x2300 . #x23ff)   ; Miscellaneous Technical
    (#x2600 . #x27bf)   ; Miscellaneous Symbols, Dingbet
    (#x1f000 . #x1f02f) ; Mahjong Tiles
    (#x1f0a0 . #x1f0ff) ; Playing Cards
    (#x1f110 . #x1f19a) ; Enclosed Alphanumeric Supplement
    ; Regional Indicator Symbol, Enclosed Ideographic Supplement,
    ; Emoticons, Transport and Map Symbols, Alchemical Symbols
    (#x1f1e6 . #x1f8ff)))

(defun emoji-fontset/font-family (font-family)
  "Choose `FONT-FAMILY' for Emoji fontset by `WINDOW-SYSTEM'."
  (or
   font-family
   (car (assoc-default window-system emoji-fontset/font-families 'eq '()))
   emoji-fontset/default-font-family))

(defun emoji-fontset/set-fontset (font-family range)
  "Set `FONT-FAMILY' to fontset for Emojis by `RANGE'."
  (set-fontset-font
   "fontset-default"
   (cons (decode-char 'ucs (car range)) (decode-char 'ucs (cdr range)))
   font-family))

;;;###autoload
(defun emoji-fontset/turn-on (&optional font-family)
  "Be enable Emoji Font face by `FONT-FAMILY'."
  (interactive)
  (when window-system
    (let ((-emoji-font-family (emoji-fontset/font-family font-family)))
      (mapc (lambda (it) (emoji-fontset/set-fontset -emoji-font-family it))
            emoji-fontset/codepoint)
      t)))

(provide 'emoji-fontset)
;;; emoji-fontset.el ends here
