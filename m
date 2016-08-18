From: Flora Cui <Flora.Cui-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/3] drm/amdgpu: allow pagelist to be NULL for amdgpu_gart_bind
Date: Thu, 18 Aug 2016 10:58:21 +0800
Message-ID: <1471489102-31630-2-git-send-email-Flora.Cui@amd.com>
References: <1471489102-31630-1-git-send-email-Flora.Cui@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1471489102-31630-1-git-send-email-Flora.Cui-5C7GfCeVMHo@public.gmane.org>
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
Cc: Flora Cui <Flora.Cui-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogRmxvcmEgQ3VpIDxGbG9yYS5DdWlAYW1kLmNvbT4KLS0tCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2FydC5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dhcnQuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9nYXJ0LmMKaW5kZXggMGZlZWEzNC4uMDNiOWZkNiAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dhcnQuYworKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZ2FydC5jCkBAIC0yODcsNyArMjg3LDcgQEAgaW50IGFtZGdwdV9n
YXJ0X2JpbmQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVpbnQ2NF90IG9mZnNldCwKIAog
CWZvciAoaSA9IDA7IGkgPCBwYWdlczsgaSsrLCBwKyspIHsKICNpZmRlZiBDT05GSUdfQU1ER1BV
X0dBUlRfREVCVUdGUwotCQlhZGV2LT5nYXJ0LnBhZ2VzW3BdID0gcGFnZWxpc3RbaV07CisJCWFk
ZXYtPmdhcnQucGFnZXNbcF0gPSBwYWdlbGlzdCA/IHBhZ2VsaXN0W2ldIDogTlVMTDsKICNlbmRp
ZgogCQlpZiAoYWRldi0+Z2FydC5wdHIpIHsKIAkJCXBhZ2VfYmFzZSA9IGRtYV9hZGRyW2ldOwot
LSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
