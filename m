From: Joakim Tjernlund <joakim.tjernlund-27rvihrghlNWk0Htik3J/w@public.gmane.org>
Subject: [PATCH] xf86-video-ati: Fix non GLAMOR build
Date: Fri, 24 Nov 2017 17:27:09 +0100
Message-ID: <20171124162709.14749-1-joakim.tjernlund@infinera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, michel-otUistvHUpPR7s880joybQ@public.gmane.org
Cc: Joakim Tjernlund <joakim.tjernlund-27rvihrghlNWk0Htik3J/w@public.gmane.org>

Tm9uIEdMQU1PUiBidWlsZHMgbmVlZHMgcFJBREVPTkVudCBzbyBtb3ZlIHRoZSBVU0VfR0xBTU9S
IGRlZmluZQpkb3duIHRvIG1ha2UgcFJBREVPTkVudCBkZWZpbmVkIGluIHRoaXMgY2FzZS4KClNp
Z25lZC1vZmYtYnk6IEpvYWtpbSBUamVybmx1bmQgPGpvYWtpbS50amVybmx1bmRAaW5maW5lcmEu
Y29tPgotLS0KIHNyYy9yYWRlb24uaCB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3NyYy9yYWRlb24uaCBiL3NyYy9yYWRl
b24uaAppbmRleCBkNTRlNDk5MC4uM2UwNDEwMWMgMTAwNjQ0Ci0tLSBhL3NyYy9yYWRlb24uaAor
KysgYi9zcmMvcmFkZW9uLmgKQEAgLTcxMiw5ICs3MTIsOSBAQCB1aW50MzJfdCByYWRlb25fZ2V0
X3BpeG1hcF90aWxpbmcoUGl4bWFwUHRyIHBQaXgpOwogCiBzdGF0aWMgaW5saW5lIEJvb2wgcmFk
ZW9uX3NldF9waXhtYXBfYm8oUGl4bWFwUHRyIHBQaXgsIHN0cnVjdCByYWRlb25fYm8gKmJvKQog
ewotI2lmZGVmIFVTRV9HTEFNT1IKICAgICBTY3JuSW5mb1B0ciBzY3JuID0geGY4NlNjcmVlblRv
U2NybihwUGl4LT5kcmF3YWJsZS5wU2NyZWVuKTsKICAgICBSQURFT05FbnRQdHIgcFJBREVPTkVu
dCA9IFJBREVPTkVudFByaXYoc2Nybik7CisjaWZkZWYgVVNFX0dMQU1PUgogICAgIFJBREVPTklu
Zm9QdHIgaW5mbyA9IFJBREVPTlBUUihzY3JuKTsKIAogICAgIGlmIChpbmZvLT51c2VfZ2xhbW9y
KSB7Ci0tIAoyLjEzLjYKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
