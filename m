From: "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/2] drm/amd/powerplay: change metrics update period from 1ms
 to 100ms
Date: Thu, 26 Sep 2019 08:56:22 +0000
Message-ID: <20190926085607.2510-1-kevin1.wang@amd.com>
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

dG9vIGhpZ2ggZnJlcXVlbmNlIHRvIHVwZGF0ZSBtZXJ0cmljcyB0YWJsZSB3aWxsIGNhdXNlIHNt
dSBmaXJtd2FyZQplcnJvcixzbyBjaGFuZ2UgbWVydHJpY3MgdGFibGUgdXBkYXRlIHBlcmlvZCBm
cm9tIDFtcyB0byAxMDBtcwoobmF2aTEwLCAxMiwgMTQpCgpTaWduZWQtb2ZmLWJ5OiBLZXZpbiBX
YW5nIDxrZXZpbjEud2FuZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJw
bGF5L25hdmkxMF9wcHQuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5
L25hdmkxMF9wcHQuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L25hdmkxMF9wcHQu
YwppbmRleCA0YzI4YWFkZWY1MDQuLmRiMmUxODFiYTQ1YSAxMDA2NDQKLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9wb3dlcnBsYXkvbmF2aTEwX3BwdC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvcG93ZXJwbGF5L25hdmkxMF9wcHQuYwpAQCAtNTQ4LDcgKzU0OCw3IEBAIHN0YXRpYyBpbnQg
bmF2aTEwX2dldF9tZXRyaWNzX3RhYmxlKHN0cnVjdCBzbXVfY29udGV4dCAqc211LAogCXN0cnVj
dCBzbXVfdGFibGVfY29udGV4dCAqc211X3RhYmxlPSAmc211LT5zbXVfdGFibGU7CiAJaW50IHJl
dCA9IDA7CiAKLQlpZiAoIXNtdV90YWJsZS0+bWV0cmljc190aW1lIHx8IHRpbWVfYWZ0ZXIoamlm
Zmllcywgc211X3RhYmxlLT5tZXRyaWNzX3RpbWUgKyBIWiAvIDEwMDApKSB7CisJaWYgKCFzbXVf
dGFibGUtPm1ldHJpY3NfdGltZSB8fCB0aW1lX2FmdGVyKGppZmZpZXMsIHNtdV90YWJsZS0+bWV0
cmljc190aW1lICsgbXNlY3NfdG9famlmZmllcygxMCkpKSB7CiAJCXJldCA9IHNtdV91cGRhdGVf
dGFibGUoc211LCBTTVVfVEFCTEVfU01VX01FVFJJQ1MsIDAsCiAJCQkJKHZvaWQgKilzbXVfdGFi
bGUtPm1ldHJpY3NfdGFibGUsIGZhbHNlKTsKIAkJaWYgKHJldCkgewotLSAKMi4xNy4xCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
