From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] drm/amd/display: remove some unneeded code
Date: Mon, 6 Nov 2017 14:44:22 +0300
Message-ID: <20171106114422.sd5zoah6k6eaww4e@mwanda>
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
To: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Cc: Charlene Liu <charlene.liu-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Dmytro Laktyushkin <Dmytro.Laktyushkin-5C7GfCeVMHo@public.gmane.org>, Vitaly Prosyak <vitaly.prosyak-5C7GfCeVMHo@public.gmane.org>, Yongqiang Sun <yongqiang.sun-5C7GfCeVMHo@public.gmane.org>, Tony Cheng <tony.cheng-5C7GfCeVMHo@public.gmane.org>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

V2UgYXNzaWduICJ2X2luaXQgPSBhc2ljX2JsYW5rX3N0YXJ0OyIgYSBmZXcgbGluZXMgZWFybGll
ciBzbyB0aGVyZSBpcwpubyBuZWVkIHRvIGRvIGl0IGFnYWluIGluc2lkZSB0aGUgaWYgc3RhdGVt
ZW50cy4gIEFsc28gInZfaW5pdCIgaXMKdW5zaWduZWQgc28gaXQgY2FuJ3QgYmUgbGVzcyB0aGFu
IHplcm8uCgpTaWduZWQtb2ZmLWJ5OiBEYW4gQ2FycGVudGVyIDxkYW4uY2FycGVudGVyQG9yYWNs
ZS5jb20+CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjEw
L2RjbjEwX3RpbWluZ19nZW5lcmF0b3IuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9kY24xMC9kY24xMF90aW1pbmdfZ2VuZXJhdG9yLmMKaW5kZXggMTk5NDg2NWQ0MzUxLi5jNzMz
M2NkZjE4MDIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24x
MC9kY24xMF90aW1pbmdfZ2VuZXJhdG9yLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2RjL2RjbjEwL2RjbjEwX3RpbWluZ19nZW5lcmF0b3IuYwpAQCAtMjM2LDEzICsyMzYsMTAg
QEAgc3RhdGljIHZvaWQgdGduMTBfcHJvZ3JhbV90aW1pbmcoCiAJaWYgKHRnLT5kbGdfb3RnX3Bh
cmFtLnNpZ25hbCA9PSBTSUdOQUxfVFlQRV9ESVNQTEFZX1BPUlQgfHwKIAkJdGctPmRsZ19vdGdf
cGFyYW0uc2lnbmFsID09IFNJR05BTF9UWVBFX0RJU1BMQVlfUE9SVF9NU1QgfHwKIAkJdGctPmRs
Z19vdGdfcGFyYW0uc2lnbmFsID09IFNJR05BTF9UWVBFX0VEUCkgewotCQl2X2luaXQgPSBhc2lj
X2JsYW5rX3N0YXJ0OwogCQlzdGFydF9wb2ludCA9IDE7CiAJCWlmIChwYXRjaGVkX2NydGNfdGlt
aW5nLmZsYWdzLklOVEVSTEFDRSA9PSAxKQogCQkJZmllbGRfbnVtID0gMTsKIAl9Ci0JaWYgKHZf
aW5pdCA8IDApCi0JCXZfaW5pdCA9IDA7CiAJdl9mcDIgPSAwOwogCWlmICh0Zy0+ZGxnX290Z19w
YXJhbS52c3RhcnR1cF9zdGFydCA+IGFzaWNfYmxhbmtfZW5kKQogCQl2X2ZwMiA9IHRnLT5kbGdf
b3RnX3BhcmFtLnZzdGFydHVwX3N0YXJ0ID4gYXNpY19ibGFua19lbmQ7Cl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
