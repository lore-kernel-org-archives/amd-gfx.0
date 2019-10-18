From: "Yuan, Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/2] drm/amdgpu/psp11: wait for sOS ready for ring creation
Date: Fri, 18 Oct 2019 10:59:39 +0000
Message-ID: <20191018105923.8277-1-xiaojie.yuan@amd.com>
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
Cc: "Long, Gang" <Gang.Long-5C7GfCeVMHo@public.gmane.org>, "Xiao, Jack" <Jack.Xiao-5C7GfCeVMHo@public.gmane.org>, "Yuan,
 Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>, "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogWGlhb2ppZSBZdWFuIDx4aWFvamllLnl1YW5AYW1kLmNvbT4KLS0tCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9wc3BfdjExXzAuYyB8IDggKysrKysrKysKIDEgZmls
ZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9wc3BfdjExXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3BzcF92
MTFfMC5jCmluZGV4IGU4ZTcwYjc0ZWE1Yi4uZGZlODVhMWQ3OWE1IDEwMDY0NAotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9wc3BfdjExXzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9wc3BfdjExXzAuYwpAQCAtNDU5LDYgKzQ1OSwxNCBAQCBzdGF0aWMgaW50IHBz
cF92MTFfMF9yaW5nX2NyZWF0ZShzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCwKIAkJCQkgICAweDgw
MDAwMDAwLCAweDgwMDBGRkZGLCBmYWxzZSk7CiAKIAl9IGVsc2UgeworCQkvKiBXYWl0IGZvciBz
T1MgcmVhZHkgZm9yIHJpbmcgY3JlYXRpb24gKi8KKwkJcmV0ID0gcHNwX3dhaXRfZm9yKHBzcCwg
U09DMTVfUkVHX09GRlNFVChNUDAsIDAsIG1tTVAwX1NNTl9DMlBNU0dfNjQpLAorCQkJCSAgIDB4
ODAwMDAwMDAsIDB4ODAwMDAwMDAsIGZhbHNlKTsKKwkJaWYgKHJldCkgeworCQkJRFJNX0VSUk9S
KCJGYWlsZWQgdG8gd2FpdCBmb3Igc09TIHJlYWR5IGZvciByaW5nIGNyZWF0aW9uXG4iKTsKKwkJ
CXJldHVybiByZXQ7CisJCX0KKwogCQkvKiBXcml0ZSBsb3cgYWRkcmVzcyBvZiB0aGUgcmluZyB0
byBDMlBNU0dfNjkgKi8KIAkJcHNwX3JpbmdfcmVnID0gbG93ZXJfMzJfYml0cyhyaW5nLT5yaW5n
X21lbV9tY19hZGRyKTsKIAkJV1JFRzMyX1NPQzE1KE1QMCwgMCwgbW1NUDBfU01OX0MyUE1TR182
OSwgcHNwX3JpbmdfcmVnKTsKLS0gCjIuMjAuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4
