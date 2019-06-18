From: Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH libdrm 2/4] libdrm/amdgpu: add new member in
 drm_amdgpu_device_info for navi10
Date: Tue, 18 Jun 2019 19:40:31 +0800
Message-ID: <1560858033-1499-2-git-send-email-Hawking.Zhang@amd.com>
References: <1560858033-1499-1-git-send-email-Hawking.Zhang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1560858033-1499-1-git-send-email-Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

cGFfc2NfdGlsZV9zdGVlcmluZ19vdmVycmlkZSBpcyBhIG5ldyBtZW1iZXIgaW50cm9kdWNlZCBm
b3IgZ2Z4MTAKCkNoYW5nZS1JZDogSTE0ODJhNWVmMjJjYzQ1NjRlZWE2M2UwOWIxYzQwZTliZTM5
MDBlMWYKU2lnbmVkLW9mZi1ieTogSGF3a2luZyBaaGFuZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29t
PgpSZXZpZXdlZC1ieTogTWFyZWsgT2zFocOhayA8bWFyZWsub2xzYWtAYW1kLmNvbT4KLS0tCiBp
bmNsdWRlL2RybS9hbWRncHVfZHJtLmggfCAyICsrCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9kcm0vYW1kZ3B1X2RybS5oIGIvaW5jbHVkZS9k
cm0vYW1kZ3B1X2RybS5oCmluZGV4IGIyOGZlZTQuLmIwYzc1NTUgMTAwNjQ0Ci0tLSBhL2luY2x1
ZGUvZHJtL2FtZGdwdV9kcm0uaAorKysgYi9pbmNsdWRlL2RybS9hbWRncHVfZHJtLmgKQEAgLTk5
Miw2ICs5OTIsOCBAQCBzdHJ1Y3QgZHJtX2FtZGdwdV9pbmZvX2RldmljZSB7CiAJX191NjQgaGln
aF92YV9vZmZzZXQ7CiAJLyoqIFRoZSBtYXhpbXVtIGhpZ2ggdmlydHVhbCBhZGRyZXNzICovCiAJ
X191NjQgaGlnaF92YV9tYXg7CisJLyogZ2Z4MTAgcGFfc2NfdGlsZV9zdGVlcmluZ19vdmVycmlk
ZSAqLworCV9fdTMyIHBhX3NjX3RpbGVfc3RlZXJpbmdfb3ZlcnJpZGU7CiB9OwogCiBzdHJ1Y3Qg
ZHJtX2FtZGdwdV9pbmZvX2h3X2lwIHsKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZng=
