From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 10/14] drm/amd/amdgpu: Tidy up
 gfx_v9_0_enable_gfx_static_mg_power_gating()
Date: Thu, 31 Aug 2017 12:06:41 -0400
Message-ID: <20170831160645.8754-11-tom.stdenis@amd.com>
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
YW1kZ3B1L2dmeF92OV8wLmMKaW5kZXggODA3ODMwYTM4ODM1Li4yMGQ0MDk3MzQzYmIgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYwpAQCAtMTkwNiwxMCArMTkwNiw5IEBAIHN0
YXRpYyB2b2lkIGdmeF92OV8wX2VuYWJsZV9nZnhfc3RhdGljX21nX3Bvd2VyX2dhdGluZyhzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRlCiAJdWludDMyX3QgZGF0YSwgZGVmYXVsdF9kYXRhOwogCiAJ
ZGVmYXVsdF9kYXRhID0gZGF0YSA9IFJSRUczMihTT0MxNV9SRUdfT0ZGU0VUKEdDLCAwLCBtbVJM
Q19QR19DTlRMKSk7Ci0JaWYgKGVuYWJsZSA9PSB0cnVlKQotCQlkYXRhIHw9IFJMQ19QR19DTlRM
X19TVEFUSUNfUEVSX0NVX1BHX0VOQUJMRV9NQVNLOwotCWVsc2UKLQkJZGF0YSAmPSB+UkxDX1BH
X0NOVExfX1NUQVRJQ19QRVJfQ1VfUEdfRU5BQkxFX01BU0s7CisJZGF0YSA9IFJFR19TRVRfRklF
TEQoZGF0YSwgUkxDX1BHX0NOVEwsCisJCQkgICAgIFNUQVRJQ19QRVJfQ1VfUEdfRU5BQkxFLAor
CQkJICAgICBlbmFibGUgPyAxIDogMCk7CiAJaWYoZGVmYXVsdF9kYXRhICE9IGRhdGEpCiAJCVdS
RUczMihTT0MxNV9SRUdfT0ZGU0VUKEdDLCAwLCBtbVJMQ19QR19DTlRMKSwgZGF0YSk7CiB9Ci0t
IAoyLjEyLjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
