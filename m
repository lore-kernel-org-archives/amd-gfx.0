From: Leo Liu <leo.liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/2] drm/amdgpu: return -ENOENT from uvd 6.0 early init for
 harvesting
Date: Wed,  1 Nov 2017 09:10:56 -0400
Message-ID: <20171101131057.5308-1-leo.liu@amd.com>
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
Cc: Leo Liu <leo.liu-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogTGVvIExpdSA8bGVvLmxpdUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L3V2ZF92Nl8wLmMgfCA0ICsrKysKIDEgZmlsZSBjaGFuZ2VkLCA0IGlu
c2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRf
djZfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdXZkX3Y2XzAuYwppbmRleCA3ZTRk
ZTNlNjk1MGYuLjBjMDE4MjVhOGI5ZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvdXZkX3Y2XzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRfdjZf
MC5jCkBAIC0zNzEsNiArMzcxLDEwIEBAIHN0YXRpYyBpbnQgdXZkX3Y2XzBfZWFybHlfaW5pdCh2
b2lkICpoYW5kbGUpCiB7CiAJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSAoc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKiloYW5kbGU7CiAKKwlpZiAoIShhZGV2LT5mbGFncyAmIEFNRF9JU19BUFUp
ICYmCisJICAgIChSUkVHMzJfU01DKGl4Q0NfSEFSVkVTVF9GVVNFUykgJiBDQ19IQVJWRVNUX0ZV
U0VTX19VVkRfRElTQUJMRV9NQVNLKSkKKwkJcmV0dXJuIC1FTk9FTlQ7CisKIAl1dmRfdjZfMF9z
ZXRfcmluZ19mdW5jcyhhZGV2KTsKIAogCWlmICh1dmRfdjZfMF9lbmNfc3VwcG9ydChhZGV2KSkg
ewotLSAKMi4xNC4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
