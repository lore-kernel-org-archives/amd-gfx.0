From: "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v2] drm/amd/powerplay: change metrics update period from 1ms
 to 100ms
Date: Thu, 26 Sep 2019 09:14:14 +0000
Message-ID: <20190926091359.5467-1-kevin1.wang@amd.com>
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
Cc: "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "Feng, Kenneth" <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>, "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>

djI6CmNoYW5nZSBwZXJpb2QgZnJvbSAxMG1zIHRvIDEwMG1zICh0eXBvIGVycm9yKQoKdG9vIGhp
Z2ggZnJlcXVlbmNlIHRvIHVwZGF0ZSBtZXJ0cmljcyB0YWJsZSB3aWxsIGNhdXNlIHNtdSBmaXJt
d2FyZQplcnJvcixzbyBjaGFuZ2UgbWVydHJpY3MgdGFibGUgdXBkYXRlIHBlcmlvZCBmcm9tIDFt
cyB0byAxMDBtcwoobmF2aTEwLCAxMiwgMTQpCgpTaWduZWQtb2ZmLWJ5OiBLZXZpbiBXYW5nIDxr
ZXZpbjEud2FuZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L25h
dmkxMF9wcHQuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L25hdmkx
MF9wcHQuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L25hdmkxMF9wcHQuYwppbmRl
eCA0YzI4YWFkZWY1MDQuLjBhNDRhYTgxZDQzNSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9wb3dlcnBsYXkvbmF2aTEwX3BwdC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93
ZXJwbGF5L25hdmkxMF9wcHQuYwpAQCAtNTQ4LDcgKzU0OCw3IEBAIHN0YXRpYyBpbnQgbmF2aTEw
X2dldF9tZXRyaWNzX3RhYmxlKHN0cnVjdCBzbXVfY29udGV4dCAqc211LAogCXN0cnVjdCBzbXVf
dGFibGVfY29udGV4dCAqc211X3RhYmxlPSAmc211LT5zbXVfdGFibGU7CiAJaW50IHJldCA9IDA7
CiAKLQlpZiAoIXNtdV90YWJsZS0+bWV0cmljc190aW1lIHx8IHRpbWVfYWZ0ZXIoamlmZmllcywg
c211X3RhYmxlLT5tZXRyaWNzX3RpbWUgKyBIWiAvIDEwMDApKSB7CisJaWYgKCFzbXVfdGFibGUt
Pm1ldHJpY3NfdGltZSB8fCB0aW1lX2FmdGVyKGppZmZpZXMsIHNtdV90YWJsZS0+bWV0cmljc190
aW1lICsgbXNlY3NfdG9famlmZmllcygxMDApKSkgewogCQlyZXQgPSBzbXVfdXBkYXRlX3RhYmxl
KHNtdSwgU01VX1RBQkxFX1NNVV9NRVRSSUNTLCAwLAogCQkJCSh2b2lkICopc211X3RhYmxlLT5t
ZXRyaWNzX3RhYmxlLCBmYWxzZSk7CiAJCWlmIChyZXQpIHsKLS0gCjIuMTcuMQoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
