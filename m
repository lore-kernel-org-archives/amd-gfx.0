From: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 08/10] drm/amd/powerplay: change dmesg log level in powerplay
Date: Mon, 25 Sep 2017 21:49:02 +0800
Message-ID: <1506347344-26516-8-git-send-email-Rex.Zhu@amd.com>
References: <1506347344-26516-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1506347344-26516-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

VXNlIHByX2RlYnVnIHRvIHByZXZlbnQgc3BhbW1pbmcgdW5pbXBvcnRhbnQgZG1lc2cuCgpDaGFu
Z2UtSWQ6IEkxOGI0ZGY2MWQ5ZDM2ZjA4MWRmOGFkM2VkMDQ3ZWIxOTVkYTcwZTdjClNpZ25lZC1v
ZmYtYnk6IFJleCBaaHUgPFJleC5aaHVAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1k
L3Bvd2VycGxheS9od21nci9jel9od21nci5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wb3dlcnBsYXkvaHdtZ3IvY3pfaHdtZ3IuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJw
bGF5L2h3bWdyL2N6X2h3bWdyLmMKaW5kZXggNzNiYjk5ZC4uMTg5ZjNiNSAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3IvY3pfaHdtZ3IuYworKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci9jel9od21nci5jCkBAIC03MDQsNyArNzA0
LDcgQEAgc3RhdGljIGludCBjel91cGRhdGVfc2Nsa19saW1pdChzdHJ1Y3QgcHBfaHdtZ3IgKmh3
bWdyKQogCiAJY2xvY2sgPSBod21nci0+ZGlzcGxheV9jb25maWcubWluX2NvcmVfc2V0X2Nsb2Nr
OwogCWlmIChjbG9jayA9PSAwKQotCQlwcl9pbmZvKCJtaW5fY29yZV9zZXRfY2xvY2sgbm90IHNl
dFxuIik7CisJCXByX2RlYnVnKCJtaW5fY29yZV9zZXRfY2xvY2sgbm90IHNldFxuIik7CiAKIAlp
ZiAoY3pfaHdtZ3ItPnNjbGtfZHBtLmhhcmRfbWluX2NsayAhPSBjbG9jaykgewogCQljel9od21n
ci0+c2Nsa19kcG0uaGFyZF9taW5fY2xrID0gY2xvY2s7Ci0tIAoxLjkuMQoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
