From: Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/4] drm/amdgpu: do not create ras debugfs/sysfs node for
 ASICs that don't have ras ability
Date: Thu, 18 Jul 2019 16:20:11 +0800
Message-ID: <1563438014-29690-1-git-send-email-Hawking.Zhang@amd.com>
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
Cc: Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

ZHJpdmVyIHNob3VsZG4ndCBpbml0IGFueSByYXMgZGVidWdmcy9zeXNmcyBub2RlIGZvciBBU0lD
cyB0aGF0IGRvbid0IGhhdmUgcmFzCmhhcmR3YXJlIGFiaWxpdHkKClNpZ25lZC1vZmYtYnk6IEhh
d2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfcmFzLmMgfCA2ICsrKysrKwogMSBmaWxlIGNoYW5nZWQsIDYgaW5z
ZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9yYXMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYwppbmRleCBj
MjBkMDNiLi5iZGE5MDI1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfcmFzLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5j
CkBAIC0xNDk2LDYgKzE0OTYsMTIgQEAgaW50IGFtZGdwdV9yYXNfaW5pdChzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldikKIAogCWFtZGdwdV9yYXNfY2hlY2tfc3VwcG9ydGVkKGFkZXYsICZjb24t
Pmh3X3N1cHBvcnRlZCwKIAkJCSZjb24tPnN1cHBvcnRlZCk7CisJaWYgKCFjb24tPmh3X3N1cHBv
cnRlZCkgeworCQlhbWRncHVfcmFzX3NldF9jb250ZXh0KGFkZXYsIE5VTEwpOworCQlrZnJlZShj
b24pOworCQlyZXR1cm4gMDsKKwl9CisKIAljb24tPmZlYXR1cmVzID0gMDsKIAlJTklUX0xJU1Rf
SEVBRCgmY29uLT5oZWFkKTsKIAkvKiBNaWdodCBuZWVkIGdldCB0aGlzIGZsYWcgZnJvbSB2Ymlv
cy4gKi8KLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
