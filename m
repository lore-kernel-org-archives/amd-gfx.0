From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: [Part II PATCH 11/15] drm/amd/powerplay: fix the incorrect checking
 condition
Date: Thu, 28 Jul 2016 15:25:01 +0800
Message-ID: <1469690705-877-12-git-send-email-ray.huang@amd.com>
References: <1469690705-877-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1469690705-877-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Cc: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6
IEtlbiBXYW5nIDxRaW5ncWluZy5XYW5nQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wb3dlcnBsYXkvaHdtZ3IvaWNlbGFuZF9od21nci5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3IvaWNlbGFuZF9od21nci5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9wb3dlcnBsYXkvaHdtZ3IvaWNlbGFuZF9od21nci5jCmluZGV4IDljNmQ3ZTMuLjdmZmJi
ZWYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL2ljZWxh
bmRfaHdtZ3IuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci9pY2Vs
YW5kX2h3bWdyLmMKQEAgLTQxNzAsNyArNDE3MCw3IEBAIGludCBpY2VsYW5kX3VuZm9yY2VfZHBt
X2xldmVscyhzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyKQogCQkJCQkJCQlyZXR1cm4gLTEpOwogCX0K
IAotCWlmICgwID09IGRhdGEtPnBjaWVfZHBtX2tleV9kaXNhYmxlZCkgeworCWlmICgwID09IGRh
dGEtPm1jbGtfZHBtX2tleV9kaXNhYmxlZCkgewogCQlQUF9BU1NFUlRfV0lUSF9DT0RFKCgwID09
IHNtdW1fc2VuZF9tc2dfdG9fc21jKAogCQkJCQkJCSAgICAgaHdtZ3ItPnNtdW1nciwKIAkJCQkJ
UFBTTUNfTVNHX01DTEtEUE1fTm9Gb3JjZWRMZXZlbCkpLAotLSAKMi43LjQKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
