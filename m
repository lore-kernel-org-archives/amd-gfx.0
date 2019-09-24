From: "Yuan, Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu/gmc10: apply the 'invalidation from sdma'
 workaround for navi12
Date: Tue, 24 Sep 2019 03:00:56 +0000
Message-ID: <20190924030042.5545-1-xiaojie.yuan@amd.com>
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
Cc: "Xiao, Jack" <Jack.Xiao-5C7GfCeVMHo@public.gmane.org>, "Yin,
 Tianci (Rico)" <Tianci.Yin-5C7GfCeVMHo@public.gmane.org>, "Yuan, Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>, "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

d2hlbiBnZnhvZmYgaXMgZW5hYmxlZCwgc2RtYSBoYW5ncyB3aGlsZSBlbnRlcmluZyBkZXNrdG9w
IHdpdGhvdXQgdGhpcwp3b3JrYXJvdW5kCgpTaWduZWQtb2ZmLWJ5OiBYaWFvamllIFl1YW4gPHhp
YW9qaWUueXVhbkBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192
MTBfMC5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAuYwppbmRleCBlZDFjM2I4ODNm
NmEuLjAzMDRjYThmZTcyMyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Z21jX3YxMF8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMK
QEAgLTI5MSw3ICsyOTEsNyBAQCBzdGF0aWMgdm9pZCBnbWNfdjEwXzBfZmx1c2hfZ3B1X3RsYihz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdWludDMyX3Qgdm1pZCwKIAogCWlmICghYWRldi0+
bW1hbi5idWZmZXJfZnVuY3NfZW5hYmxlZCB8fAogCSAgICAhYWRldi0+aWJfcG9vbF9yZWFkeSB8
fAotCSAgICBhZGV2LT5hc2ljX3R5cGUgPiBDSElQX05BVkkxNCB8fAorCSAgICBhZGV2LT5hc2lj
X3R5cGUgPiBDSElQX05BVkkxMiB8fAogCSAgICBhZGV2LT5pbl9ncHVfcmVzZXQpIHsKIAkJZ21j
X3YxMF8wX2ZsdXNoX3ZtX2h1YihhZGV2LCB2bWlkLCBBTURHUFVfR0ZYSFVCXzAsIDApOwogCQlt
dXRleF91bmxvY2soJmFkZXYtPm1tYW4uZ3R0X3dpbmRvd19sb2NrKTsKLS0gCjIuMjAuMQoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
