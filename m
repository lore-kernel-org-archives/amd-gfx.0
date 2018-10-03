From: Aleksandr Mezin <mezin.alexander-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] drm/amd/vega10: allow increased power limit
Date: Thu,  4 Oct 2018 03:59:51 +0600
Message-ID: <20181003220300.5931-2-mezin.alexander@gmail.com>
References: <20181003220300.5931-1-mezin.alexander@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181003220300.5931-1-mezin.alexander-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
Cc: "David (ChunMing) Zhou" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Aleksandr Mezin <mezin.alexander-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>, Rex Zhu <rex.zhu-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

QWxsb3cgc2V0dGluZyB0aGUgcG93ZXIgbGltaXQgdG8gMTUwJSBvZiB0aGUgZGVmYXVsdCBvbmUs
IGxpa2UKV2luZG93cyBkcml2ZXIgZG9lcy4KClNpZ25lZC1vZmYtYnk6IEFsZWtzYW5kciBNZXpp
biA8bWV6aW4uYWxleGFuZGVyQGdtYWlsLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bv
d2VycGxheS9od21nci92ZWdhMTBfcG93ZXJ0dW5lLmMgfCAzICsrLQogMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMF9wb3dlcnR1bmUuYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMF9wb3dlcnR1bmUuYwppbmRleCBhNjQzMmY5
YTc1YjQuLjgyMThhYTkxODlkYSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dl
cnBsYXkvaHdtZ3IvdmVnYTEwX3Bvd2VydHVuZS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
cG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMF9wb3dlcnR1bmUuYwpAQCAtMTM0Miw3ICsxMzQyLDggQEAg
aW50IHZlZ2ExMF9lbmFibGVfcG93ZXJfY29udGFpbm1lbnQoc3RydWN0IHBwX2h3bWdyICpod21n
cikKIAogCWh3bWdyLT5kZWZhdWx0X3Bvd2VyX2xpbWl0ID0gaHdtZ3ItPnBvd2VyX2xpbWl0ID0K
IAkJCSh1aW50MzJfdCkodGRwX3RhYmxlLT51c01heGltdW1Qb3dlckRlbGl2ZXJ5TGltaXQpOwot
CWh3bWdyLT5tYXhfcG93ZXJfbGltaXQgPSBod21nci0+ZGVmYXVsdF9wb3dlcl9saW1pdDsKKwlo
d21nci0+bWF4X3Bvd2VyX2xpbWl0ID0gaHdtZ3ItPmRlZmF1bHRfcG93ZXJfbGltaXQgKworCQkJ
aHdtZ3ItPmRlZmF1bHRfcG93ZXJfbGltaXQgLyAyOwogCiAJaWYgKFBQX0NBUChQSE1fUGxhdGZv
cm1DYXBzX1Bvd2VyQ29udGFpbm1lbnQpKSB7CiAJCWlmIChkYXRhLT5zbXVfZmVhdHVyZXNbR05M
RF9QUFRdLnN1cHBvcnRlZCkKLS0gCjIuMTkuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
