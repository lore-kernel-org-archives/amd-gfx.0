From: Shirish S <shirish.s-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: avoid sleep while executing atombios table
Date: Wed, 30 May 2018 15:49:07 +0530
Message-ID: <1527675547-24093-1-git-send-email-shirish.s@amd.com>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Harry.Wentland-5C7GfCeVMHo@public.gmane.org, Rex.Zhu-5C7GfCeVMHo@public.gmane.org
Cc: Shirish S <shirish.s-5C7GfCeVMHo@public.gmane.org>

VGhpcyBwYXRjaCByZXBsYWNlcyBremFsbG9jJ3MgZmxhZyBmcm9tIEdGUF9LRVJORUwgdG8KR0ZQ
X0FUT01JQyB0byBhdm9pZCBzbGVlcGluZyBpbiBhdG9taWMgY29udGV4dC4KClNpZ25lZC1vZmYt
Ynk6IFNoaXJpc2ggUyA8c2hpcmlzaC5zQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYXRvbS5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYXRv
bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYXRvbS5jCmluZGV4IGJmZDk4ZjAuLmRh
NDU1OGMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2F0b20uYworKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hdG9tLmMKQEAgLTEyMjEsNyArMTIyMSw3IEBA
IHN0YXRpYyBpbnQgYW1kZ3B1X2F0b21fZXhlY3V0ZV90YWJsZV9sb2NrZWQoc3RydWN0IGF0b21f
Y29udGV4dCAqY3R4LCBpbnQgaW5kZXgsCiAJZWN0eC5hYm9ydCA9IGZhbHNlOwogCWVjdHgubGFz
dF9qdW1wID0gMDsKIAlpZiAod3MpCi0JCWVjdHgud3MgPSBremFsbG9jKDQgKiB3cywgR0ZQX0tF
Uk5FTCk7CisJCWVjdHgud3MgPSBremFsbG9jKDQgKiB3cywgR0ZQX0FUT01JQyk7CiAJZWxzZQog
CQllY3R4LndzID0gTlVMTDsKIAotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
