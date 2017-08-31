From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 11/14] drm/amd/amdgpu: Tidy up
 gfx_v9_0_enable_gfx_dynamic_mg_power_gating()
Date: Thu, 31 Aug 2017 12:06:42 -0400
Message-ID: <20170831160645.8754-12-tom.stdenis@amd.com>
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
YW1kZ3B1L2dmeF92OV8wLmMKaW5kZXggMjBkNDA5NzM0M2JiLi5jNDVjNjljNDY3M2IgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYwpAQCAtMTkxOSwxMCArMTkxOSw5IEBAIHN0
YXRpYyB2b2lkIGdmeF92OV8wX2VuYWJsZV9nZnhfZHluYW1pY19tZ19wb3dlcl9nYXRpbmcoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkCiAJdWludDMyX3QgZGF0YSwgZGVmYXVsdF9kYXRhOwogCiAJ
ZGVmYXVsdF9kYXRhID0gZGF0YSA9IFJSRUczMihTT0MxNV9SRUdfT0ZGU0VUKEdDLCAwLCBtbVJM
Q19QR19DTlRMKSk7Ci0JaWYgKGVuYWJsZSA9PSB0cnVlKQotCQlkYXRhIHw9IFJMQ19QR19DTlRM
X19EWU5fUEVSX0NVX1BHX0VOQUJMRV9NQVNLOwotCWVsc2UKLQkJZGF0YSAmPSB+UkxDX1BHX0NO
VExfX0RZTl9QRVJfQ1VfUEdfRU5BQkxFX01BU0s7CisJZGF0YSA9IFJFR19TRVRfRklFTEQoZGF0
YSwgUkxDX1BHX0NOVEwsCisJCQkgICAgIERZTl9QRVJfQ1VfUEdfRU5BQkxFLAorCQkJICAgICBl
bmFibGUgPyAxIDogMCk7CiAJaWYoZGVmYXVsdF9kYXRhICE9IGRhdGEpCiAJCVdSRUczMihTT0Mx
NV9SRUdfT0ZGU0VUKEdDLCAwLCBtbVJMQ19QR19DTlRMKSwgZGF0YSk7CiB9Ci0tIAoyLjEyLjAK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
