From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [PATCH xf86-video-ati 1/2] glamor: Set RADEON_CREATE_PIXMAP_DRI2 for
 DRI3 pixmaps
Date: Thu,  2 Aug 2018 19:05:29 +0200
Message-ID: <20180802170530.29060-1-michel@daenzer.net>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

RnJvbTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+CgpOb3QgZG9pbmcg
dGhpcyByZXN1bHRlZCBpbiBmYWxsaW5nIGJhY2sgdG8gc29mdHdhcmUgZm9yIERSSTMgY2xpZW50
CnByZXNlbnRhdGlvbiBvcGVyYXRpb25zIHdpdGggU2hhZG93UHJpbWFyeS4KCihQb3J0ZWQgZnJv
bSBhbWRncHUgY29tbWl0IDI5ODlkNDBlZjc0ZDk5NjZlOGU4ZGYyZWY3NzI3YjJjYzQ4ZDQ5NjAp
CgpTaWduZWQtb2ZmLWJ5OiBNaWNoZWwgRMOkbnplciA8bWljaGVsLmRhZW56ZXJAYW1kLmNvbT4K
LS0tCiBzcmMvcmFkZW9uX2RyaTMuYyB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspCgpkaWZmIC0tZ2l0IGEvc3JjL3JhZGVvbl9kcmkzLmMgYi9zcmMvcmFkZW9uX2RyaTMuYwpp
bmRleCA2ODhlNTk0ZTEuLjdlODlhMmYwYiAxMDA2NDQKLS0tIGEvc3JjL3JhZGVvbl9kcmkzLmMK
KysrIGIvc3JjL3JhZGVvbl9kcmkzLmMKQEAgLTE2OSw2ICsxNjksNyBAQCBzdGF0aWMgUGl4bWFw
UHRyIHJhZGVvbl9kcmkzX3BpeG1hcF9mcm9tX2ZkKFNjcmVlblB0ciBzY3JlZW4sCiAKIAkJCWlm
IChwcml2KSB7CiAJCQkJcmFkZW9uX3NldF9waXhtYXBfcHJpdmF0ZShwaXhtYXAsIHByaXYpOwor
CQkJCXBpeG1hcC0+dXNhZ2VfaGludCB8PSBSQURFT05fQ1JFQVRFX1BJWE1BUF9EUkkyOwogCQkJ
CXJldHVybiBwaXhtYXA7CiAJCQl9CiAKLS0gCjIuMTguMAoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
