From: <boyuan.zhang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 07/18] drm/amdgpu: add vcn jpeg irq support
Date: Wed, 30 May 2018 16:27:22 -0400
Message-ID: <1527712053-15027-7-git-send-email-boyuan.zhang@amd.com>
References: <1527712053-15027-1-git-send-email-boyuan.zhang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1527712053-15027-1-git-send-email-boyuan.zhang-5C7GfCeVMHo@public.gmane.org>
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
Cc: alexander.deucher-5C7GfCeVMHo@public.gmane.org, Boyuan Zhang <boyuan.zhang-5C7GfCeVMHo@public.gmane.org>, leo.liu-5C7GfCeVMHo@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org

RnJvbTogQm95dWFuIFpoYW5nIDxib3l1YW4uemhhbmdAYW1kLmNvbT4KCkFkZCB2Y24ganBlZyBp
cnEgc3VwcG9ydC4KClNpZ25lZC1vZmYtYnk6IEJveXVhbiBaaGFuZyA8Ym95dWFuLnpoYW5nQGFt
ZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3YxXzAuYyB8IDggKysr
KysrKysKIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjFfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvdmNuX3YxXzAuYwppbmRleCA4YjI5ZjQ3Li4wNzZjNDljIDEwMDY0NAotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjFfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L3Zjbl92MV8wLmMKQEAgLTg4LDYgKzg4LDExIEBAIHN0YXRpYyBpbnQgdmNuX3Yx
XzBfc3dfaW5pdCh2b2lkICpoYW5kbGUpCiAJCQlyZXR1cm4gcjsKIAl9CiAKKwkvKiBWQ04gSlBF
RyBUUkFQICovCisJciA9IGFtZGdwdV9pcnFfYWRkX2lkKGFkZXYsIFNPQzE1X0lIX0NMSUVOVElE
X1ZDTiwgMTI2LCAmYWRldi0+dmNuLmlycSk7CisJaWYgKHIpCisJCXJldHVybiByOworCiAJciA9
IGFtZGdwdV92Y25fc3dfaW5pdChhZGV2KTsKIAlpZiAocikKIAkJcmV0dXJuIHI7CkBAIC0xNDM4
LDYgKzE0NDMsOSBAQCBzdGF0aWMgaW50IHZjbl92MV8wX3Byb2Nlc3NfaW50ZXJydXB0KHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2LAogCWNhc2UgMTIwOgogCQlhbWRncHVfZmVuY2VfcHJvY2Vz
cygmYWRldi0+dmNuLnJpbmdfZW5jWzFdKTsKIAkJYnJlYWs7CisJY2FzZSAxMjY6CisJCWFtZGdw
dV9mZW5jZV9wcm9jZXNzKCZhZGV2LT52Y24ucmluZ19qcGVnKTsKKwkJYnJlYWs7CiAJZGVmYXVs
dDoKIAkJRFJNX0VSUk9SKCJVbmhhbmRsZWQgaW50ZXJydXB0OiAlZCAlZFxuIiwKIAkJCSAgZW50
cnktPnNyY19pZCwgZW50cnktPnNyY19kYXRhWzBdKTsKLS0gCjIuNy40CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
