From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] drm/amd/powerplay: fix amd_powerplay_reset()
Date: Tue, 24 Oct 2017 12:44:18 +0300
Message-ID: <20171024094418.za4qacxapyrud2m4@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
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
To: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Cc: David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Eric Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

V2UgYWNjaWRlbnRhbGx5IGludmVydGVkIGFuIGlmIHN0YXRlbWVudCBhbmQgdHVybmVkIGFtZF9w
b3dlcnBsYXlfcmVzZXQoKQppbnRvIGEgbm8tb3AuCgpGaXhlczogYWU5Nzk4OGZjODllICgiZHJt
L2FtZC9wb3dlcnBsYXk6IHRpZHkgdXAgcmV0IGNoZWNrcyBpbiBhbWRfcG93ZXJwbGF5LmMgKHYz
KSIpClNpZ25lZC1vZmYtYnk6IERhbiBDYXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJAb3JhY2xlLmNv
bT4KLS0tCklNSE8sIHRpZHlpbmcgdW5yZWFkYWJsZSBkb3VibGUgbmVnYXRpdmVzIGlzIHRyaWNr
eSBhbmQgZXJyb3IgcHJvbmUgYnV0CnN0aWxsIHdvcnRoIGl0IGluIHRoZSBsb25nIHJ1bi4KCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRfcG93ZXJwbGF5LmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRfcG93ZXJwbGF5LmMKaW5kZXggM2M4
ZWY0YmZjMjA1Li4wZjhiNmRjODUzYTUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
cG93ZXJwbGF5L2FtZF9wb3dlcnBsYXkuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2Vy
cGxheS9hbWRfcG93ZXJwbGF5LmMKQEAgLTExODQsNyArMTE4NCw3IEBAIGludCBhbWRfcG93ZXJw
bGF5X3Jlc2V0KHZvaWQgKmhhbmRsZSkKIAlpbnQgcmV0OwogCiAJcmV0ID0gcHBfY2hlY2soaW5z
dGFuY2UpOwotCWlmICghcmV0KQorCWlmIChyZXQpCiAJCXJldHVybiByZXQ7CiAKIAlyZXQgPSBw
cF9od19maW5pKGluc3RhbmNlKTsKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
