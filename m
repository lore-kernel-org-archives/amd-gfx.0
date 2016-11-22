From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 04/11] drm/amd/dal/dc: fix bug in
 dal_display_clock_get_min_clocks_state
Date: Tue, 22 Nov 2016 11:57:21 -0500
Message-ID: <1479833848-14275-4-git-send-email-alexander.deucher@amd.com>
References: <1479833848-14275-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1479833848-14275-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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

TWlzc2luZyByZXR1cm4uCgpSZXZpZXdlZC1ieTogSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRs
YW5kQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNo
ZXJAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2RhbC9kYy9ncHUvZGlzcGxheV9j
bG9jay5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kYWwvZGMvZ3B1L2Rpc3BsYXlf
Y2xvY2suYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGFsL2RjL2dwdS9kaXNwbGF5X2Nsb2NrLmMK
aW5kZXggNDkyOWNkMi4uYmNjMGE1MSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9k
YWwvZGMvZ3B1L2Rpc3BsYXlfY2xvY2suYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2RhbC9k
Yy9ncHUvZGlzcGxheV9jbG9jay5jCkBAIC0xMTgsNyArMTE4LDcgQEAgYm9vbCBkYWxfZGlzcGxh
eV9jbG9ja19nZXRfbWluX2Nsb2Nrc19zdGF0ZSgKIAllbnVtIGNsb2Nrc19zdGF0ZSAqY2xvY2tz
X3N0YXRlKQogewogCWlmICghZGlzcF9jbGstPmZ1bmNzLT5nZXRfbWluX2Nsb2Nrc19zdGF0ZSkK
LQkJZmFsc2U7CisJCXJldHVybiBmYWxzZTsKIAogCSpjbG9ja3Nfc3RhdGUgPSBkaXNwX2Nsay0+
ZnVuY3MtPmdldF9taW5fY2xvY2tzX3N0YXRlKGRpc3BfY2xrKTsKIAlyZXR1cm4gdHJ1ZTsKLS0g
CjIuNS41CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
