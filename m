From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/6] drm/amd/powerplay: Tidy up
 smu7_fan_ctrl_get_fan_speed_rpm()
Date: Tue, 12 Sep 2017 10:47:17 -0400
Message-ID: <20170912144721.4628-2-tom.stdenis@amd.com>
References: <20170912144721.4628-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170912144721.4628-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
aXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3NtdTdfdGhlcm1hbC5jIHwgMyArLS0K
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci9zbXU3X3RoZXJtYWwuYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3NtdTdfdGhlcm1hbC5jCmluZGV4
IGE0OTFmMTIwMWZkYS4uMGM4MjJlZjdkOTA3IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL3Bvd2VycGxheS9od21nci9zbXU3X3RoZXJtYWwuYworKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL3Bvd2VycGxheS9od21nci9zbXU3X3RoZXJtYWwuYwpAQCAtODYsOCArODYsNyBAQCBpbnQg
c211N19mYW5fY3RybF9nZXRfZmFuX3NwZWVkX3JwbShzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyLCB1
aW50MzJfdCAqc3BlZWQpCiAJdWludDMyX3QgY3J5c3RhbF9jbG9ja19mcmVxOwogCiAJaWYgKGh3
bWdyLT50aGVybWFsX2NvbnRyb2xsZXIuZmFuSW5mby5iTm9GYW4gfHwKLQkJCShod21nci0+dGhl
cm1hbF9jb250cm9sbGVyLmZhbkluZm8uCi0JCQkJdWNUYWNob21ldGVyUHVsc2VzUGVyUmV2b2x1
dGlvbiA9PSAwKSkKKwkgICAgIWh3bWdyLT50aGVybWFsX2NvbnRyb2xsZXIuZmFuSW5mby4JdWNU
YWNob21ldGVyUHVsc2VzUGVyUmV2b2x1dGlvbikKIAkJcmV0dXJuIC1FTk9ERVY7CiAKIAl0YWNo
X3BlcmlvZCA9IFBITV9SRUFEX1ZGUEZfSU5ESVJFQ1RfRklFTEQoaHdtZ3ItPmRldmljZSwgQ0dT
X0lORF9SRUdfX1NNQywKLS0gCjIuMTIuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
