From: <boyuan.zhang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 07/17] drm/amdgpu: add vcn jpeg irq support
Date: Thu, 24 May 2018 16:15:19 -0400
Message-ID: <1527192929-2480-7-git-send-email-boyuan.zhang@amd.com>
References: <1527192929-2480-1-git-send-email-boyuan.zhang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1527192929-2480-1-git-send-email-boyuan.zhang-5C7GfCeVMHo@public.gmane.org>
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
Cc: alexander.deucher-5C7GfCeVMHo@public.gmane.org, Boyuan Zhang <boyuan.zhang-5C7GfCeVMHo@public.gmane.org>, leo.liu-5C7GfCeVMHo@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org, peter.fang-5C7GfCeVMHo@public.gmane.org

RnJvbTogQm95dWFuIFpoYW5nIDxib3l1YW4uemhhbmdAYW1kLmNvbT4KCkFkZCB2Y24ganBlZyBp
cnEgc3VwcG9ydAoKU2lnbmVkLW9mZi1ieTogQm95dWFuIFpoYW5nIDxib3l1YW4uemhhbmdAYW1k
LmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjFfMC5jIHwgOCArKysr
KysrKwogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92MV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS92Y25fdjFfMC5jCmluZGV4IDBkZGU0MjQuLjlhMDRhOWEgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92MV8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvdmNuX3YxXzAuYwpAQCAtODksNiArODksMTEgQEAgc3RhdGljIGludCB2Y25fdjFf
MF9zd19pbml0KHZvaWQgKmhhbmRsZSkKIAkJCXJldHVybiByOwogCX0KIAorCS8qIFZDTiBKUEVH
IFRSQVAgKi8KKwlyID0gYW1kZ3B1X2lycV9hZGRfaWQoYWRldiwgU09DMTVfSUhfQ0xJRU5USURf
VkNOLCAxMjYsICZhZGV2LT52Y24uaXJxKTsKKwlpZiAocikKKwkJcmV0dXJuIHI7CisKIAlyID0g
YW1kZ3B1X3Zjbl9zd19pbml0KGFkZXYpOwogCWlmIChyKQogCQlyZXR1cm4gcjsKQEAgLTEzMzUs
NiArMTM0MCw5IEBAIHN0YXRpYyBpbnQgdmNuX3YxXzBfcHJvY2Vzc19pbnRlcnJ1cHQoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJY2FzZSAxMjA6CiAJCWFtZGdwdV9mZW5jZV9wcm9jZXNz
KCZhZGV2LT52Y24ucmluZ19lbmNbMV0pOwogCQlicmVhazsKKwljYXNlIDEyNjoKKwkJYW1kZ3B1
X2ZlbmNlX3Byb2Nlc3MoJmFkZXYtPnZjbi5yaW5nX2pwZWcpOworCQlicmVhazsKIAlkZWZhdWx0
OgogCQlEUk1fRVJST1IoIlVuaGFuZGxlZCBpbnRlcnJ1cHQ6ICVkICVkXG4iLAogCQkJICBlbnRy
eS0+c3JjX2lkLCBlbnRyeS0+c3JjX2RhdGFbMF0pOwotLSAKMi43LjQKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
