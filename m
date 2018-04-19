From: Kenneth Feng <kenneth.feng-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/2] drm/amd/powerplay: header file interface to SMU update
Date: Thu, 19 Apr 2018 15:09:58 +0800
Message-ID: <1524121798-24712-1-git-send-email-kenneth.feng@amd.com>
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
Cc: Kenneth Feng <kenneth.feng-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJNmQzMDlmNjUxZGZmNWY2NTdjMWFhNDI0ZWZlYzIwNDhiOWI2NGEwYQpTaWdu
ZWQtb2ZmLWJ5OiBLZW5uZXRoIEZlbmcgPGtlbm5ldGguZmVuZ0BhbWQuY29tPgotLS0KIGRyaXZl
cnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2luYy92ZWdhMTIvc211OV9kcml2ZXJfaWYuaCB8IDQg
KysrLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2luYy92ZWdhMTIvc211OV9k
cml2ZXJfaWYuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2luYy92ZWdhMTIvc211
OV9kcml2ZXJfaWYuaAppbmRleCBmYjY5NmUzLi4yZjhhM2I5IDEwMDY0NAotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL3Bvd2VycGxheS9pbmMvdmVnYTEyL3NtdTlfZHJpdmVyX2lmLmgKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaW5jL3ZlZ2ExMi9zbXU5X2RyaXZlcl9pZi5o
CkBAIC00MTIsOCArNDEyLDEwIEBAIHR5cGVkZWYgc3RydWN0IHsKICAgUXVhZHJhdGljSW50X3Qg
ICAgUmVzZXJ2ZWRFcXVhdGlvbjI7CiAgIFF1YWRyYXRpY0ludF90ICAgIFJlc2VydmVkRXF1YXRp
b24zOwogCisJdWludDE2X3QgICAgIE1pblZvbHRhZ2VVbHZHZng7CisJdWludDE2X3QgICAgIE1p
blZvbHRhZ2VVbHZTb2M7CiAKLSAgdWludDMyX3QgICAgIFJlc2VydmVkWzE1XTsKKwl1aW50MzJf
dCAgICAgUmVzZXJ2ZWRbMTRdOwogCiAKIAotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
