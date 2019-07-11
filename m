From: "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amd/powerplay: fix smu clock type change miss error
Date: Thu, 11 Jul 2019 13:40:31 +0000
Message-ID: <20190711133937.10417-1-kevin1.wang@amd.com>
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
Cc: "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>, "Feng,
 Kenneth" <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>

aW4gdGhlIHNtdSBtb2R1bGUsIHVzZSB0aGUgc211X3h4eGNsayB0eXBlIHRvIGlkZW50aWZ5IHRo
ZSBDTEsgdHlwZQp1c2UgU01VX1NDTEssIFNNVV9NQ0xLIHRvIHJlcGxhY2UgUFBfU0NMSywgUFBf
TUNMSy4KCkNoYW5nZS1JZDogSWZhODcwYWVhMzhmMDQzZTE5ODNmNmYwNTYwZWVkMmFjMDcwYjY4
YjcKU2lnbmVkLW9mZi1ieTogS2V2aW4gV2FuZyA8a2V2aW4xLndhbmdAYW1kLmNvbT4KLS0tCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRncHVfc211LmMgfCA0ICsrLS0KIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5jCmluZGV4IDFjMTVmMDIxMDFmZS4uZGU2Y2M1
ZDQ4OWNkIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRncHVf
c211LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5jCkBA
IC0xMzg2LDggKzEzODYsOCBAQCBpbnQgc211X2FkanVzdF9wb3dlcl9zdGF0ZV9keW5hbWljKHN0
cnVjdCBzbXVfY29udGV4dCAqc211LAogCQkJCQkJCSAmc29jX21hc2spOwogCQkJaWYgKHJldCkK
IAkJCQlyZXR1cm4gcmV0OwotCQkJc211X2ZvcmNlX2Nsa19sZXZlbHMoc211LCBQUF9TQ0xLLCAx
IDw8IHNjbGtfbWFzayk7Ci0JCQlzbXVfZm9yY2VfY2xrX2xldmVscyhzbXUsIFBQX01DTEssIDEg
PDwgbWNsa19tYXNrKTsKKwkJCXNtdV9mb3JjZV9jbGtfbGV2ZWxzKHNtdSwgU01VX1NDTEssIDEg
PDwgc2Nsa19tYXNrKTsKKwkJCXNtdV9mb3JjZV9jbGtfbGV2ZWxzKHNtdSwgU01VX01DTEssIDEg
PDwgbWNsa19tYXNrKTsKIAkJCWJyZWFrOwogCiAJCWNhc2UgQU1EX0RQTV9GT1JDRURfTEVWRUxf
TUFOVUFMOgotLSAKMi4yMi4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
Zng=
