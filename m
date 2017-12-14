From: Yong Zhao <yong.zhao-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: Fix a bug that vm size is wrong on Raven
Date: Wed, 13 Dec 2017 21:25:50 -0500
Message-ID: <1513218350-29030-1-git-send-email-yong.zhao@amd.com>
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
Cc: Yong Zhao <yong.zhao-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJZDUyMmMxY2JhZGI4YzA2OTcyMGY0ZTY0YTMxY2ZmNDJjZDAxNDczMwpTaWdu
ZWQtb2ZmLWJ5OiBZb25nIFpoYW8gPHlvbmcuemhhb0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dm0uYwppbmRleCA3MDk1ODdkLi4zYjllYjFhIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdm0uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdm0uYwpAQCAtMjUzNCw3ICsyNTM0LDcgQEAgdm9pZCBhbWRncHVfdm1fYWRqdXN0X3Np
emUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVpbnQzMl90IHZtX3NpemUsCiAJdWludDY0
X3QgdG1wOwogCiAJLyogYWRqdXN0IHZtIHNpemUgZmlyc3QgKi8KLQlpZiAoYW1kZ3B1X3ZtX3Np
emUgIT0gLTEpIHsKKwlpZiAoYW1kZ3B1X3ZtX3NpemUgIT0gLTEgJiYgbWF4X2xldmVsID09IDEp
IHsKIAkJdW5zaWduZWQgbWF4X3NpemUgPSAxIDw8IChtYXhfYml0cyAtIDMwKTsKIAogCQl2bV9z
aXplID0gYW1kZ3B1X3ZtX3NpemU7Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
