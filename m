From: "Yuan, Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/2] drm/amdgpu/gmc10: do not apply the 'invalidation from
 sdma' workaround for navi12
Date: Mon, 23 Sep 2019 13:58:09 +0000
Message-ID: <20190923135746.8066-1-xiaojie.yuan@amd.com>
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
Cc: "Xiao, Jack" <Jack.Xiao-5C7GfCeVMHo@public.gmane.org>, "Wang,
 Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>, "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>, "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, "Feng, Kenneth" <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>, "Yuan, Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>

d2hlbiBnZnhvZmYgaXMgZW5hYmxlZCwgYXBwbHlpbmcgdGhpcyB3b3JrYXJvdW5kIG1ha2VzIHNk
bWEgaGFuZyB3aGlsZQplbnRlcmluZyBkZXNrdG9wLgoKU2lnbmVkLW9mZi1ieTogWGlhb2ppZSBZ
dWFuIDx4aWFvamllLnl1YW5AYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9nbWNfdjEwXzAuYyB8IDMgKystCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21j
X3YxMF8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAuYwppbmRleCBl
ZDFjM2I4ODNmNmEuLjM4OTdlMGQyODgzOCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ21jX3YxMF8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21j
X3YxMF8wLmMKQEAgLTI5MSw3ICsyOTEsOCBAQCBzdGF0aWMgdm9pZCBnbWNfdjEwXzBfZmx1c2hf
Z3B1X3RsYihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdWludDMyX3Qgdm1pZCwKIAogCWlm
ICghYWRldi0+bW1hbi5idWZmZXJfZnVuY3NfZW5hYmxlZCB8fAogCSAgICAhYWRldi0+aWJfcG9v
bF9yZWFkeSB8fAotCSAgICBhZGV2LT5hc2ljX3R5cGUgPiBDSElQX05BVkkxNCB8fAorCSAgICBh
ZGV2LT5hc2ljX3R5cGUgPT0gQ0hJUF9OQVZJMTAgfHwKKwkgICAgYWRldi0+YXNpY190eXBlID09
IENISVBfTkFWSTE0IHx8CiAJICAgIGFkZXYtPmluX2dwdV9yZXNldCkgewogCQlnbWNfdjEwXzBf
Zmx1c2hfdm1faHViKGFkZXYsIHZtaWQsIEFNREdQVV9HRlhIVUJfMCwgMCk7CiAJCW11dGV4X3Vu
bG9jaygmYWRldi0+bW1hbi5ndHRfd2luZG93X2xvY2spOwotLSAKMi4yMC4xCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
