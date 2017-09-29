From: <Ken.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: correct reference clock value on vega10
Date: Fri, 29 Sep 2017 16:14:51 +0800
Message-ID: <1506672891-19703-1-git-send-email-Ken.Wang@amd.com>
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
Cc: Ken Wang <Ken.Wang-5C7GfCeVMHo@public.gmane.org>

RnJvbTogS2VuIFdhbmcgPEtlbi5XYW5nQGFtZC5jb20+CgpDaGFuZ2UtSWQ6IEkzNzcwMjkwNzVh
ZjFlMmUwMDJmN2NmZDc5M2RkZDU4ZDg2MTBlNDc0ClNpZ25lZC1vZmYtYnk6IEtlbiBXYW5nIDxL
ZW4uV2FuZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMg
fCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYwppbmRleCA3ODM5Njc3Li42MzFiMWUzIDEwMDY0NAot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMKQEAgLTI4MCw3ICsyODAsNyBAQCBzdGF0aWMgdm9pZCBz
b2MxNV9pbml0X2dvbGRlbl9yZWdpc3RlcnMoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiBz
dGF0aWMgdTMyIHNvYzE1X2dldF94Y2xrKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogewog
CWlmIChhZGV2LT5hc2ljX3R5cGUgPT0gQ0hJUF9WRUdBMTApCi0JCXJldHVybiBhZGV2LT5jbG9j
ay5zcGxsLnJlZmVyZW5jZV9mcmVxLzQ7CisJCXJldHVybiAyNzAwMDsKIAllbHNlCiAJCXJldHVy
biBhZGV2LT5jbG9jay5zcGxsLnJlZmVyZW5jZV9mcmVxOwogfQotLSAKMi43LjQKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
