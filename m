From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 09/14] drm/amd/amdgpu: Tidy up
 gfx_v9_0_enable_gfx_pipeline_powergating()
Date: Thu, 31 Aug 2017 12:06:40 -0400
Message-ID: <20170831160645.8754-10-tom.stdenis@amd.com>
References: <20170831160645.8754-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170831160645.8754-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogVG9tIFN0IERlbmlzIDx0b20uc3RkZW5pc0BhbWQuY29tPgotLS0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMgfCA3ICsrKy0tLS0KIDEgZmlsZSBj
aGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2dmeF92OV8wLmMKaW5kZXggZjkyMjk5YzcxZjQ2Li44MDc4MzBhMzg4MzUgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYwpAQCAtMTg4OSwxMCArMTg4OSw5IEBAIHN0
YXRpYyB2b2lkIGdmeF92OV8wX2VuYWJsZV9nZnhfcGlwZWxpbmVfcG93ZXJnYXRpbmcoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJdWludDMyX3QgZGF0YSwgZGVmYXVsdF9kYXRhOwogCiAJ
ZGVmYXVsdF9kYXRhID0gZGF0YSA9IFJSRUczMihTT0MxNV9SRUdfT0ZGU0VUKEdDLCAwLCBtbVJM
Q19QR19DTlRMKSk7Ci0JaWYgKGVuYWJsZSA9PSB0cnVlKQotCQlkYXRhIHw9IFJMQ19QR19DTlRM
X19HRlhfUElQRUxJTkVfUEdfRU5BQkxFX01BU0s7Ci0JZWxzZQotCQlkYXRhICY9IH5STENfUEdf
Q05UTF9fR0ZYX1BJUEVMSU5FX1BHX0VOQUJMRV9NQVNLOworCWRhdGEgPSBSRUdfU0VUX0ZJRUxE
KGRhdGEsIFJMQ19QR19DTlRMLAorCQkJICAgICBHRlhfUElQRUxJTkVfUEdfRU5BQkxFLAorCQkJ
ICAgICBlbmFibGUgPyAxIDogMCk7CiAJaWYoZGVmYXVsdF9kYXRhICE9IGRhdGEpCiAJCVdSRUcz
MihTT0MxNV9SRUdfT0ZGU0VUKEdDLCAwLCBtbVJMQ19QR19DTlRMKSwgZGF0YSk7CiAKLS0gCjIu
MTIuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
