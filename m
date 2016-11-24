From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 30/39] drm/amd/dal: fix bug in
 dal_display_clock_get_min_clocks_state
Date: Wed, 23 Nov 2016 21:02:59 -0500
Message-ID: <20161124020308.28124-31-harry.wentland@amd.com>
References: <20161124020308.28124-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20161124020308.28124-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

RnJvbTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgoKTWlzc2luZyBy
ZXR1cm4uCgpDaGFuZ2UtSWQ6IElkZjc3YjVhNzNjODllYzg2YTliN2VmNWQyMzFhY2FjNmJmNThh
NGM3ClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNv
bT4KQWNrZWQtYnk6IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgotLS0K
IGRyaXZlcnMvZ3B1L2RybS9hbWQvZGFsL2RjL2dwdS9kaXNwbGF5X2Nsb2NrLmMgfCAyICstCiAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2RhbC9kYy9ncHUvZGlzcGxheV9jbG9jay5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kYWwvZGMvZ3B1L2Rpc3BsYXlfY2xvY2suYwppbmRleCA0OTI5Y2QyYWEz
ZGEuLmJjYzBhNTEzMjYwMCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kYWwvZGMv
Z3B1L2Rpc3BsYXlfY2xvY2suYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2RhbC9kYy9ncHUv
ZGlzcGxheV9jbG9jay5jCkBAIC0xMTgsNyArMTE4LDcgQEAgYm9vbCBkYWxfZGlzcGxheV9jbG9j
a19nZXRfbWluX2Nsb2Nrc19zdGF0ZSgKIAllbnVtIGNsb2Nrc19zdGF0ZSAqY2xvY2tzX3N0YXRl
KQogewogCWlmICghZGlzcF9jbGstPmZ1bmNzLT5nZXRfbWluX2Nsb2Nrc19zdGF0ZSkKLQkJZmFs
c2U7CisJCXJldHVybiBmYWxzZTsKIAogCSpjbG9ja3Nfc3RhdGUgPSBkaXNwX2Nsay0+ZnVuY3Mt
PmdldF9taW5fY2xvY2tzX3N0YXRlKGRpc3BfY2xrKTsKIAlyZXR1cm4gdHJ1ZTsKLS0gCjIuMTAu
MQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
