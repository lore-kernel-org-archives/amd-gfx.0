From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amd/amdgpu: Disable GFX_PG on laptop raven part
Date: Fri, 16 Aug 2019 17:01:47 +0000
Message-ID: <20190816170121.8172-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Language: en-US
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>

R0ZYX1BHIGNhdXNlcyB2aXN1YWwgKGFuZCBsaWtlbHkgbWVtb3J5KSBjb3JydXB0aW9uIG9uIGxh
cHRvcApyYXZlbiBwYXJ0cy4gIFVudGlsIGl0J3MgZnVsbHkgZGlhZ25vc2VkIGxldCdzIGRpc2Fi
bGUgaXQgdG8gZW5zdXJlCnN0YWJsZSBvcGVyYXRpb24uCgpUZXN0ZWQgb24gYSBEZWxsIExhdGl0
dWRlIDU0OTUuCgpTaWduZWQtb2ZmLWJ5OiBUb20gU3QgRGVuaXMgPHRvbS5zdGRlbmlzQGFtZC5j
b20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYyB8IDUgKysrKysKIDEg
ZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9zb2MxNS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUu
YwppbmRleCA3N2U2Nzk5MjBjMWMuLjI3YTUwMGY3NWY1NyAxMDA2NDQKLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9zb2MxNS5jCkBAIC0xMTM4LDYgKzExMzgsMTEgQEAgc3RhdGljIGludCBzb2MxNV9jb21tb25f
ZWFybHlfaW5pdCh2b2lkICpoYW5kbGUpCiAJCQlhZGV2LT5wZ19mbGFncyB8PSBBTURfUEdfU1VQ
UE9SVF9HRlhfUEcgfAogCQkJCUFNRF9QR19TVVBQT1JUX0NQIHwKIAkJCQlBTURfUEdfU1VQUE9S
VF9STENfU01VX0hTOworCisJCS8vIGRpc2FibGUgR0ZYX1BHIHVudGlsIGRlYnVnZ2VkLgorCQlp
ZiAoYWRldi0+ZXh0ZXJuYWxfcmV2X2lkID09IDB4MjEpCisJCQlhZGV2LT5wZ19mbGFncyAmPSB+
QU1EX1BHX1NVUFBPUlRfR0ZYX1BHOworCiAJCWJyZWFrOwogCWNhc2UgQ0hJUF9BUkNUVVJVUzoK
IAkJYWRldi0+YXNpY19mdW5jcyA9ICZ2ZWdhMjBfYXNpY19mdW5jczsKLS0gCjIuMjEuMAoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
