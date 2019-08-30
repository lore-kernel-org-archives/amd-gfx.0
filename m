From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 2/3] drm/edid: don't log errors on absent CEA SAD blocks
Date: Fri, 30 Aug 2019 18:15:41 +0200
Message-ID: <20190830181541.7d2be23d@endymion>
References: <20190830181423.4f31a28f@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190830181423.4f31a28f@endymion>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: "David (ChunMing) Zhou" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Sean Paul <sean-p7yTbzM4H96eqtR555YLDQ@public.gmane.org>, Maarten Lankhorst <maarten.lankhorst-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Leo Li <sunpeng.li-5C7GfCeVMHo@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, Christian =?UTF-8?B?S8O2?= =?UTF-8?B?bmln?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

SXQgaXMgZmluZSBmb3IgZGlzcGxheXMgd2l0aG91dCBhdWRpbyBmdW5jdGlvbmFsaXR5IHRvIG5v
dCBwcm92aWRlCmFueSBTQUQgYmxvY2sgaW4gdGhlaXIgRURJRC4gRG8gbm90IGxvZyBhbiBlcnJv
ciBpbiB0aGF0IGNhc2UsCmp1c3QgcmV0dXJuIHF1aWV0bHkuCgpJbnNwaXJlZCBieSBhIHNpbWls
YXIgZml4IHRvIHRoZSBhbWRncHUgZHJpdmVyIGluIHRoZSBjb250ZXh0IG9mIGJ1ZwpmZG8jMTA3
ODI1OgpodHRwczovL2J1Z3MuZnJlZWRlc2t0b3Aub3JnL3Nob3dfYnVnLmNnaT9pZD0xMDc4MjUK
ClNpZ25lZC1vZmYtYnk6IEplYW4gRGVsdmFyZSA8amRlbHZhcmVAc3VzZS5kZT4KQ2M6IEFsZXgg
RGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6ICJDaHJpc3RpYW4gS8O2bmln
IiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogIkRhdmlkIChDaHVuTWluZykgWmhvdSIg
PERhdmlkMS5aaG91QGFtZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+
CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+Ci0tLQogZHJpdmVycy9ncHUvZHJt
L3JhZGVvbi9yYWRlb25fYXVkaW8uYyB8ICAgIDQgKystLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCi0tLSBsaW51eC01LjIub3JpZy9kcml2ZXJzL2dw
dS9kcm0vcmFkZW9uL3JhZGVvbl9hdWRpby5jCTIwMTktMDgtMzAgMTg6MDQ6MTUuMTI1MDU2Njk3
ICswMjAwCisrKyBsaW51eC01LjIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fYXVkaW8u
YwkyMDE5LTA4LTMwIDE4OjA0OjM1LjA3ODMxMTM0NyArMDIwMApAQCAtMzY3LDEwICszNjcsMTAg
QEAgc3RhdGljIHZvaWQgcmFkZW9uX2F1ZGlvX3dyaXRlX3NhZF9yZWdzKAogCQlyZXR1cm47CiAK
IAlzYWRfY291bnQgPSBkcm1fZWRpZF90b19zYWQocmFkZW9uX2Nvbm5lY3Rvcl9lZGlkKGNvbm5l
Y3RvciksICZzYWRzKTsKLQlpZiAoc2FkX2NvdW50IDw9IDApIHsKKwlpZiAoc2FkX2NvdW50IDwg
MCkKIAkJRFJNX0VSUk9SKCJDb3VsZG4ndCByZWFkIFNBRHM6ICVkXG4iLCBzYWRfY291bnQpOwor
CWlmIChzYWRfY291bnQgPD0gMCkKIAkJcmV0dXJuOwotCX0KIAlCVUdfT04oIXNhZHMpOwogCiAJ
aWYgKHJhZGVvbl9lbmNvZGVyLT5hdWRpbyAmJiByYWRlb25fZW5jb2Rlci0+YXVkaW8tPndyaXRl
X3NhZF9yZWdzKQoKLS0gCkplYW4gRGVsdmFyZQpTVVNFIEwzIFN1cHBvcnQKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
