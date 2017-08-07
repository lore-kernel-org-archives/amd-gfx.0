From: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH libdrm 1/2] drm: fix missing mutex unlock before return
Date: Mon, 7 Aug 2017 22:35:11 +0800
Message-ID: <1502116512-14264-1-git-send-email-Monk.Liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
Cc: Monk Liu <monk.liu-5C7GfCeVMHo@public.gmane.org>

RnJvbTogTW9uayBMaXUgPG1vbmsubGl1QGFtZC5jb20+CgpDaGFuZ2UtSWQ6IEkzNzdkZGU5NzY2
NDhkNTNiYzlhM2EyZDViYTI5NGMyODQ5MTBiMTA5ClNpZ25lZC1vZmYtYnk6IE1vbmsgTGl1IDxt
b25rLmxpdUBhbWQuY29tPgotLS0KIGFtZGdwdS9hbWRncHVfYm8uYyB8IDEgKwogMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvYW1kZ3B1L2FtZGdwdV9iby5jIGIv
YW1kZ3B1L2FtZGdwdV9iby5jCmluZGV4IGVjOTk0ODguLjA3ZWI3NDMgMTAwNjQ0Ci0tLSBhL2Ft
ZGdwdS9hbWRncHVfYm8uYworKysgYi9hbWRncHUvYW1kZ3B1X2JvLmMKQEAgLTI5Nyw2ICsyOTcs
NyBAQCBpbnQgYW1kZ3B1X2JvX2ltcG9ydChhbWRncHVfZGV2aWNlX2hhbmRsZSBkZXYsCiAJCS8q
IEdldCBhIEtNUyBoYW5kbGUuICovCiAJCXIgPSBkcm1QcmltZUZEVG9IYW5kbGUoZGV2LT5mZCwg
c2hhcmVkX2hhbmRsZSwgJmhhbmRsZSk7CiAJCWlmIChyKSB7CisJCQlwdGhyZWFkX211dGV4X3Vu
bG9jaygmZGV2LT5ib190YWJsZV9tdXRleCk7CiAJCQlyZXR1cm4gcjsKIAkJfQogCi0tIAoyLjcu
NAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
