From: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 12/13] drm/amd/powerplay: correct vega12 thermal support as
 true
Date: Tue, 19 Jun 2018 15:39:04 +0800
Message-ID: <1529393945-16629-12-git-send-email-evan.quan@amd.com>
References: <1529393945-16629-1-git-send-email-evan.quan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1529393945-16629-1-git-send-email-evan.quan-5C7GfCeVMHo@public.gmane.org>
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
Cc: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>

VGhlcm1hbCBzdXBwb3J0IGlzIGVuYWJsZWQgb24gdmVnYTEyLgoKQ2hhbmdlLUlkOiBJNzA2OWE2
NWM2YjI4OWRiZmU0YTEyZjgxZmY5NmU5NDNlODc4ZTZmYQpTaWduZWQtb2ZmLWJ5OiBFdmFuIFF1
YW4gPGV2YW4ucXVhbkBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5
L2h3bWdyL3ZlZ2ExMl9od21nci5jIHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci92ZWdh
MTJfaHdtZ3IuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMl9o
d21nci5jCmluZGV4IDFmYWRiNzEuLmRlNjFmODYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvcG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMl9od21nci5jCisrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvcG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMl9od21nci5jCkBAIC04MSw2ICs4MSw3IEBAIHN0
YXRpYyB2b2lkIHZlZ2ExMl9zZXRfZGVmYXVsdF9yZWdpc3RyeV9kYXRhKHN0cnVjdCBwcF9od21n
ciAqaHdtZ3IpCiAKIAlkYXRhLT5yZWdpc3RyeV9kYXRhLmRpc2FsbG93ZWRfZmVhdHVyZXMgPSAw
eDA7CiAJZGF0YS0+cmVnaXN0cnlfZGF0YS5vZF9zdGF0ZV9pbl9kY19zdXBwb3J0ID0gMDsKKwlk
YXRhLT5yZWdpc3RyeV9kYXRhLnRoZXJtYWxfc3VwcG9ydCA9IDE7CiAJZGF0YS0+cmVnaXN0cnlf
ZGF0YS5za2lwX2JhY29faGFyZHdhcmUgPSAwOwogCiAJZGF0YS0+cmVnaXN0cnlfZGF0YS5sb2df
YXZmc19wYXJhbSA9IDA7Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
