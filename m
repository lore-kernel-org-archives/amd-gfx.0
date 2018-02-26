From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 31/33] drm/amd/display: Don't blow up if TG is NULL in
 dce110_vblank_set
Date: Mon, 26 Feb 2018 15:16:01 -0500
Message-ID: <20180226201603.28609-32-harry.wentland@amd.com>
References: <20180226201603.28609-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180226201603.28609-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+ClJl
dmlld2VkLWJ5OiBSb21hbiBMaSA8Um9tYW4uTGlAYW1kLmNvbT4KQWNrZWQtYnk6IEhhcnJ5IFdl
bnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kYy9pcnEvZGNlMTEwL2lycV9zZXJ2aWNlX2RjZTExMC5jIHwgMiArLQogMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2lycS9kY2UxMTAvaXJxX3NlcnZpY2VfZGNlMTEw
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvaXJxL2RjZTExMC9pcnFfc2Vydmlj
ZV9kY2UxMTAuYwppbmRleCA5YmMxYzFkOTBiYWQuLmFmZTA4NzZmZTZmOCAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2lycS9kY2UxMTAvaXJxX3NlcnZpY2VfZGNl
MTEwLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2lycS9kY2UxMTAvaXJx
X3NlcnZpY2VfZGNlMTEwLmMKQEAgLTIwOCw3ICsyMDgsNyBAQCBib29sIGRjZTExMF92Ymxhbmtf
c2V0KHN0cnVjdCBpcnFfc2VydmljZSAqaXJxX3NlcnZpY2UsCiAJCQljb3JlX2RjLT5jdXJyZW50
X3N0YXRlLT5yZXNfY3R4LnBpcGVfY3R4W3BpcGVfb2Zmc2V0XS5zdHJlYW1fcmVzLnRnOwogCiAJ
aWYgKGVuYWJsZSkgewotCQlpZiAoIXRnLT5mdW5jcy0+YXJtX3ZlcnRfaW50cih0ZywgMikpIHsK
KwkJaWYgKCF0ZyB8fCAhdGctPmZ1bmNzLT5hcm1fdmVydF9pbnRyKHRnLCAyKSkgewogCQkJRENf
RVJST1IoIkZhaWxlZCB0byBnZXQgVkJMQU5LIVxuIik7CiAJCQlyZXR1cm4gZmFsc2U7CiAJCX0K
LS0gCjIuMTQuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
