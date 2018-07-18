From: <boyuan.zhang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 4/5] drm/amdgpu: add emit trap for vcn jpeg
Date: Wed, 18 Jul 2018 16:39:14 -0400
Message-ID: <1531946355-17488-4-git-send-email-boyuan.zhang@amd.com>
References: <1531946355-17488-1-git-send-email-boyuan.zhang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1531946355-17488-1-git-send-email-boyuan.zhang-5C7GfCeVMHo@public.gmane.org>
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
Cc: Boyuan Zhang <boyuan.zhang-5C7GfCeVMHo@public.gmane.org>

RnJvbTogQm95dWFuIFpoYW5nIDxib3l1YW4uemhhbmdAYW1kLmNvbT4KCkFkZCBlbWl0IHRyYXAg
Y29tbWFuZCBpbiBqcGVnIGVtaXQgZmVuY2UgY2FsbC4KClNpZ25lZC1vZmYtYnk6IEJveXVhbiBa
aGFuZyA8Ym95dWFuLnpoYW5nQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvdmNuX3YxXzAuYyB8IDQgKysrKwogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92MV8wLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjFfMC5jCmluZGV4IDIyYzE1ODguLjc0NWM5YWUg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92MV8wLmMKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3YxXzAuYwpAQCAtMTMxNyw2ICsxMzE3LDEw
IEBAIHN0YXRpYyB2b2lkIHZjbl92MV8wX2pwZWdfcmluZ19lbWl0X2ZlbmNlKHN0cnVjdCBhbWRn
cHVfcmluZyAqcmluZywgdTY0IGFkZHIsIHU2CiAJYW1kZ3B1X3Jpbmdfd3JpdGUocmluZywKIAkJ
UEFDS0VUSigwLCAwLCAwLCBQQUNLRVRKX1RZUEUwKSk7CiAJYW1kZ3B1X3Jpbmdfd3JpdGUocmlu
ZywgMHgxKTsKKworCS8qIGVtaXQgdHJhcCAqLworCWFtZGdwdV9yaW5nX3dyaXRlKHJpbmcsIFBB
Q0tFVEooMCwgMCwgMCwgUEFDS0VUSl9UWVBFNykpOworCWFtZGdwdV9yaW5nX3dyaXRlKHJpbmcs
IDApOwogfQogCiAvKioKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
