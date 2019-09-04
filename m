From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH v2 2/3] drm/radeon: be quiet when no SAD block is found
Date: Wed, 4 Sep 2019 11:13:37 +0200
Message-ID: <20190904111337.77d4cb7c@endymion>
References: <20190904111152.266d5176@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190904111152.266d5176@endymion>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@linux.ie>, David@freedesktop.org, ChunMing <Zhou@freedesktop.org>, "  <David1.Zhou@amd.com>, Harry Wentland <harry.wentland@amd.com>, Leo  Li  <sunpeng.li@amd.com>, Maarten Lankhorst   <maarten.lankhorst@linux.intel.com>, Maxime Ripard   <maxime.ripard@bootlin.com>, Sean Paul <sean@poorly.run>, Ville  =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,  Christian =?UTF-8?B?S8O2?= =?UTF-8?B?bmln?= <christian.koenig@amd.com>"@freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

SXQgaXMgZmluZSBmb3IgZGlzcGxheXMgd2l0aG91dCBhdWRpbyBmdW5jdGlvbmFsaXR5IHRvIG5v
dCBwcm92aWRlCmFueSBTQUQgYmxvY2sgaW4gdGhlaXIgRURJRC4gRG8gbm90IGxvZyBhbiBlcnJv
ciBpbiB0aGF0IGNhc2UsCmp1c3QgcmV0dXJuIHF1aWV0bHkuCgpJbnNwaXJlZCBieSBhIHNpbWls
YXIgZml4IHRvIHRoZSBhbWRncHUgZHJpdmVyIGluIHRoZSBjb250ZXh0IG9mIGJ1ZwpmZG8jMTA3
ODI1OgpodHRwczovL2J1Z3MuZnJlZWRlc2t0b3Aub3JnL3Nob3dfYnVnLmNnaT9pZD0xMDc4MjUK
ClNpZ25lZC1vZmYtYnk6IEplYW4gRGVsdmFyZSA8amRlbHZhcmVAc3VzZS5kZT4KQ2M6IEFsZXgg
RGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6ICJDaHJpc3RpYW4gS8O2bmln
IiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogIkRhdmlkIChDaHVuTWluZykgWmhvdSIg
PERhdmlkMS5aaG91QGFtZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+
CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+Ci0tLQpDaGFuZ2VzIHNpbmNlIHYx
OgogKiBGaXhlZCBzdWJqZWN0CgogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fYXVkaW8u
YyB8ICAgIDQgKystLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkKCi0tLSBsaW51eC01LjIub3JpZy9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9h
dWRpby5jCTIwMTktMDgtMzAgMTg6MDQ6MTUuMTI1MDU2Njk3ICswMjAwCisrKyBsaW51eC01LjIv
ZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fYXVkaW8uYwkyMDE5LTA4LTMwIDE4OjA0OjM1
LjA3ODMxMTM0NyArMDIwMApAQCAtMzY3LDEwICszNjcsMTAgQEAgc3RhdGljIHZvaWQgcmFkZW9u
X2F1ZGlvX3dyaXRlX3NhZF9yZWdzKAogCQlyZXR1cm47CiAKIAlzYWRfY291bnQgPSBkcm1fZWRp
ZF90b19zYWQocmFkZW9uX2Nvbm5lY3Rvcl9lZGlkKGNvbm5lY3RvciksICZzYWRzKTsKLQlpZiAo
c2FkX2NvdW50IDw9IDApIHsKKwlpZiAoc2FkX2NvdW50IDwgMCkKIAkJRFJNX0VSUk9SKCJDb3Vs
ZG4ndCByZWFkIFNBRHM6ICVkXG4iLCBzYWRfY291bnQpOworCWlmIChzYWRfY291bnQgPD0gMCkK
IAkJcmV0dXJuOwotCX0KIAlCVUdfT04oIXNhZHMpOwogCiAJaWYgKHJhZGVvbl9lbmNvZGVyLT5h
dWRpbyAmJiByYWRlb25fZW5jb2Rlci0+YXVkaW8tPndyaXRlX3NhZF9yZWdzKQoKLS0gCkplYW4g
RGVsdmFyZQpTVVNFIEwzIFN1cHBvcnQKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vZHJpLWRldmVs
