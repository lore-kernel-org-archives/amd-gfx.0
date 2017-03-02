From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [PATCH xf86-video-amdgpu 3/6] Don't destroy current FB if
 drmModeAddFB fails
Date: Thu,  2 Mar 2017 18:17:57 +0900
Message-ID: <20170302091800.10229-3-michel@daenzer.net>
References: <20170302091800.10229-1-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170302091800.10229-1-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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

RnJvbTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+CgpJdCB3b3VsZCBw
cm9iYWJseSByZXN1bHQgaW4gYSBibGFjayBzY3JlZW4uCgooUG9ydGVkIGZyb20gcmFkZW9uIGNv
bW1pdCAxMzUxZTQ4ZWZlN2EyYzI4ZWFiNDQ3ZTE2ZjM2YTAwZmJkMDJhZTQ4KQoKU2lnbmVkLW9m
Zi1ieTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+Ci0tLQogc3JjL2Ry
bW1vZGVfZGlzcGxheS5jIHwgMyArKy0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9zcmMvZHJtbW9kZV9kaXNwbGF5LmMgYi9zcmMv
ZHJtbW9kZV9kaXNwbGF5LmMKaW5kZXggYmM3YjljMzMuLjQ2Mzc1OWI5IDEwMDY0NAotLS0gYS9z
cmMvZHJtbW9kZV9kaXNwbGF5LmMKKysrIGIvc3JjL2RybW1vZGVfZGlzcGxheS5jCkBAIC0yNjc5
LDcgKzI2NzksOCBAQCBmbGlwX2Vycm9yOgogCQkgICBzdHJlcnJvcihlcnJubykpOwogCiBlcnJv
cjoKLQlpZiAoZmxpcGRhdGEgJiYgZmxpcGRhdGEtPmZsaXBfY291bnQgPD0gMSkgeworCWlmIChm
bGlwZGF0YSAmJiBmbGlwZGF0YS0+ZmxpcF9jb3VudCA8PSAxICYmCisJICAgIGRybW1vZGUtPmZi
X2lkICE9IGZsaXBkYXRhLT5vbGRfZmJfaWQpIHsKIAkJZHJtTW9kZVJtRkIocEFNREdQVUVudC0+
ZmQsIGRybW1vZGUtPmZiX2lkKTsKIAkJZHJtbW9kZS0+ZmJfaWQgPSBmbGlwZGF0YS0+b2xkX2Zi
X2lkOwogCX0KLS0gCjIuMTEuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
