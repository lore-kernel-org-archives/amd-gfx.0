From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 083/138] drm/amd/powerplay: implement sensor of SCLK and MCLK
 for smu11
Date: Fri, 25 Jan 2019 18:24:50 +0800
Message-ID: <1548411945-12396-84-git-send-email-ray.huang@amd.com>
References: <1548411945-12396-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1548411945-12396-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
Cc: Likun Gao <Likun.Gao-5C7GfCeVMHo@public.gmane.org>, Kevin Wang <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>, Chengming Gui <Jack.Gui-5C7GfCeVMHo@public.gmane.org>

RnJvbTogS2V2aW4gV2FuZyA8S2V2aW4xLldhbmdAYW1kLmNvbT4KCmFkZCBzZW5zb3IgaW50ZXJm
YWNlIG9mIFNDTEsgYW5kIE1DS0wgZm9yIHN5cyBpbnRlcmZhY2UgYW5kIGh3bW9uLgoKU2lnbmVk
LW9mZi1ieTogS2V2aW4gV2FuZyA8S2V2aW4xLldhbmdAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IEh1
YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+ClJldmlld2VkLWJ5OiBFdmFuIFF1YW4gPGV2YW4u
cXVhbkBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdV92MTFf
MC5jIHwgOCArKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdV92MTFfMC5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211X3YxMV8wLmMKaW5kZXggMWFlZjZjNi4uN2MxNmVj
ZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211X3YxMV8wLmMK
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211X3YxMV8wLmMKQEAgLTEwMjAs
NiArMTAyMCwxNCBAQCBzdGF0aWMgaW50IHNtdV92MTFfMF9yZWFkX3NlbnNvcihzdHJ1Y3Qgc211
X2NvbnRleHQgKnNtdSwKIAkJcmV0ID0gc211X3YxMV8wX2dldF9jdXJyZW50X2FjdGl2aXR5X3Bl
cmNlbnQoc211LCBkYXRhKTsKIAkJKnNpemUgPSA0OwogCQlicmVhazsKKwljYXNlIEFNREdQVV9Q
UF9TRU5TT1JfR0ZYX01DTEs6CisJCXJldCA9IHNtdV9nZXRfY3VycmVudF9jbGtfZnJlcShzbXUs
IFBQQ0xLX1VDTEssICh1aW50MzJfdCAqKWRhdGEpOworCQkqc2l6ZSA9IDQ7CisJCWJyZWFrOwor
CWNhc2UgQU1ER1BVX1BQX1NFTlNPUl9HRlhfU0NMSzoKKwkJcmV0ID0gc211X2dldF9jdXJyZW50
X2Nsa19mcmVxKHNtdSwgUFBDTEtfR0ZYQ0xLLCAodWludDMyX3QgKilkYXRhKTsKKwkJKnNpemUg
PSA0OworCQlicmVhazsKIAlkZWZhdWx0OgogCQlyZXQgPSAtRUlOVkFMOwogCQlicmVhazsKLS0g
CjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
