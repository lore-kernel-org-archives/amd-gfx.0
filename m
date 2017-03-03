From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [PATCH xf86-video-amdgpu 3/9] present: Wait for GPU idle before
 setting modes for unflip
Date: Fri,  3 Mar 2017 18:07:39 +0900
Message-ID: <20170303090745.2254-3-michel@daenzer.net>
References: <20170303090745.2254-1-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170303090745.2254-1-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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

RnJvbTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+CgpUbyBtYWtlIHN1
cmUgdGhlIHNjcmVlbiBwaXhtYXAgY29udGVudHMgYXJlIHVwIHRvIGRhdGUgd2hlbiBpdCBzdGFy
dHMKYmVpbmcgc2Nhbm5lZCBvdXQuCgooUG9ydGVkIGZyb20gcmFkZW9uIGNvbW1pdCAyNDRkNGJj
N2Y4YzhmNmJjOTBmNDk1NTZjMGI5MzQ0YzhhYTQwMjk1KQoKU2lnbmVkLW9mZi1ieTogTWljaGVs
IETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+Ci0tLQogc3JjL2FtZGdwdV9wcmVzZW50
LmMgfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL3Ny
Yy9hbWRncHVfcHJlc2VudC5jIGIvc3JjL2FtZGdwdV9wcmVzZW50LmMKaW5kZXggNWEzNDVjYjBh
Li5jZjZlMzZiMmYgMTAwNjQ0Ci0tLSBhL3NyYy9hbWRncHVfcHJlc2VudC5jCisrKyBiL3NyYy9h
bWRncHVfcHJlc2VudC5jCkBAIC0zNzgsNiArMzc4LDcgQEAgbW9kZXNldDoKIAlvbGRfZmJfaWQg
PSBpbmZvLT5kcm1tb2RlLmZiX2lkOwogCWluZm8tPmRybW1vZGUuZmJfaWQgPSAwOwogCisJYW1k
Z3B1X2dsYW1vcl9maW5pc2goc2Nybik7CiAJZm9yIChpID0gMDsgaSA8IGNvbmZpZy0+bnVtX2Ny
dGM7IGkrKykgewogCQl4Zjg2Q3J0Y1B0ciBjcnRjID0gY29uZmlnLT5jcnRjW2ldOwogCQlkcm1t
b2RlX2NydGNfcHJpdmF0ZV9wdHIgZHJtbW9kZV9jcnRjID0gY3J0Yy0+ZHJpdmVyX3ByaXZhdGU7
Ci0tIAoyLjExLjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
