From: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/2] drm/amd/powerplay: fix issue power containment not
 enabled on Tonga.
Date: Mon, 5 Sep 2016 18:37:15 +0800
Message-ID: <1473071835-12006-2-git-send-email-Rex.Zhu@amd.com>
References: <1473071835-12006-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1473071835-12006-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJMzA5ZDcxZmU1Y2E3MjZmNjIwYTI5NDI1NTM2ZDA4MjRiZDhmMmUwOApTaWdu
ZWQtb2ZmLWJ5OiBSZXggWmh1IDxSZXguWmh1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9wb3dlcnBsYXkvaHdtZ3IvdG9uZ2FfcG93ZXJ0dW5lLmMgfCAzIC0tLQogMSBmaWxlIGNo
YW5nZWQsIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9w
b3dlcnBsYXkvaHdtZ3IvdG9uZ2FfcG93ZXJ0dW5lLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bv
d2VycGxheS9od21nci90b25nYV9wb3dlcnR1bmUuYwppbmRleCA5NDk2YWRlLi4yNGQ5YTA1IDEw
MDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci90b25nYV9wb3dl
cnR1bmUuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci90b25nYV9w
b3dlcnR1bmUuYwpAQCAtNTYsOSArNTYsNiBAQCB2b2lkIHRvbmdhX2luaXRpYWxpemVfcG93ZXJf
dHVuZV9kZWZhdWx0cyhzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyKQogCWVsc2UKIAkJdG9uZ2FfaHdt
Z3ItPnBvd2VyX3R1bmVfZGVmYXVsdHMgPSAmdG9uZ2FfcG93ZXJfdHVuZV9kYXRhX3NldF9hcnJh
eVswXTsKIAotCS8qIEFzc3VtZSBkaXNhYmxlZCAqLwotCXBobV9jYXBfdW5zZXQoaHdtZ3ItPnBs
YXRmb3JtX2Rlc2NyaXB0b3IucGxhdGZvcm1DYXBzLAotCQkJUEhNX1BsYXRmb3JtQ2Fwc19Qb3dl
ckNvbnRhaW5tZW50KTsKIAlwaG1fY2FwX3Vuc2V0KGh3bWdyLT5wbGF0Zm9ybV9kZXNjcmlwdG9y
LnBsYXRmb3JtQ2FwcywKIAkJCVBITV9QbGF0Zm9ybUNhcHNfQ0FDKTsKIAlwaG1fY2FwX3Vuc2V0
KGh3bWdyLT5wbGF0Zm9ybV9kZXNjcmlwdG9yLnBsYXRmb3JtQ2FwcywKLS0gCjEuOS4xCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
