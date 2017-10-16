From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 7/7] drm/amd/powerplay: Tidy up cz_dpm_powerup_vce()
Date: Mon, 16 Oct 2017 13:55:03 -0400
Message-ID: <20171016175503.18367-8-tom.stdenis@amd.com>
References: <20171016175503.18367-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171016175503.18367-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
aXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL2N6X2h3bWdyLmMgfCA1ICsrLS0tCiAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL2N6X2h3bWdyLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci9jel9od21nci5jCmluZGV4IDIzZGYwNTZh
MDM0Yi4uY2EwNjAzM2NkMTU1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2Vy
cGxheS9od21nci9jel9od21nci5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5
L2h3bWdyL2N6X2h3bWdyLmMKQEAgLTEzNzAsMTAgKzEzNzAsOSBAQCBpbnQgY3pfZHBtX3Bvd2Vy
ZG93bl92Y2Uoc3RydWN0IHBwX2h3bWdyICpod21ncikKIAogaW50IGN6X2RwbV9wb3dlcnVwX3Zj
ZShzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyKQogewotCWlmIChwaG1fY2FwX2VuYWJsZWQoaHdtZ3It
PnBsYXRmb3JtX2Rlc2NyaXB0b3IucGxhdGZvcm1DYXBzLAotCQkJCQkgUEhNX1BsYXRmb3JtQ2Fw
c19WQ0VQb3dlckdhdGluZykpCisJaWYgKFBQX0NBUChQSE1fUGxhdGZvcm1DYXBzX1ZDRVBvd2Vy
R2F0aW5nKSkKIAkJcmV0dXJuIHNtdW1fc2VuZF9tc2dfdG9fc21jKGh3bWdyLAotCQkJCQkJICAg
ICBQUFNNQ19NU0dfVkNFUG93ZXJPTik7CisJCQkJUFBTTUNfTVNHX1ZDRVBvd2VyT04pOwogCXJl
dHVybiAwOwogfQogCi0tIAoyLjEyLjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
