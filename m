From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] drm/amd/powerplay: Fix double unlock bug in
 smu_sys_set_pp_table()
Date: Thu, 21 Mar 2019 09:28:22 +0300
Message-ID: <20190321062822.GD21489@kadam>
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
To: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Kevin Wang <kevin1.wang-5C7GfCeVMHo@public.gmane.org>
Cc: "David (ChunMing) Zhou" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, Chengming Gui <Jack.Gui-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, Likun Gao <Likun.Gao-5C7GfCeVMHo@public.gmane.org>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

V2UgYWxyZWFkeSB1bmxvY2tlZCBhIGZldyBsaW5lcyBlYXJsaWVyIHNvIHRoaXMgY29kZSB1bmxv
Y2tzIHR3aWNlIG9uCnRoZSBzdWNjZXNzIHBhdGguCgpGaXhlczogNTgwOWQ3NDIwZjk3ICgiZHJt
L2FtZC9wb3dlcnBsYXk6IGltcGxlbWVudCBzeXNmcyBvZiBwcF90YWJsZSBmb3Igc211MTEgKHYy
KSIpClNpZ25lZC1vZmYtYnk6IERhbiBDYXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJAb3JhY2xlLmNv
bT4KLS0tCkknbSBub3Qgc3VyZSB3aGF0IHRoaXMgYnVnIGxvb2tzIGxpa2UgYXQgcnVudGltZSwg
YnV0IGl0J3Mgc2xpZ2h0bHkKd2VpcmQgdGhhdCBubyBvbmUgbm90aWNlZC4gIFRoaXMgaXMgZnJv
bSBzdGF0aWMgYW5hbHlzaXMgYW5kIEkgaGF2ZW4ndAp0ZXN0ZWQgaXQgbXlzZWxmLgoKIGRyaXZl
cnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYyB8IDIgKysKIDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bv
d2VycGxheS9hbWRncHVfc211LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRn
cHVfc211LmMKaW5kZXggMDBiN2M4ODU3NzJiLi43ZThjNzRkYTZhNzQgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYworKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL3Bvd2VycGxheS9hbWRncHVfc211LmMKQEAgLTE4Nyw2ICsxODcsOCBAQCBpbnQg
c211X3N5c19zZXRfcHBfdGFibGUoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsICB2b2lkICpidWYs
IHNpemVfdCBzaXplKQogCWlmIChyZXQpCiAJCXByX2luZm8oInNtdSByZXNldCBmYWlsZWQsIHJl
dCA9ICVkXG4iLCByZXQpOwogCisJcmV0dXJuIHJldDsKKwogZmFpbGVkOgogCW11dGV4X3VubG9j
aygmc211LT5tdXRleCk7CiAJcmV0dXJuIHJldDsKLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
