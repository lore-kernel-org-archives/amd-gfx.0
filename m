From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] drm/amdgpu: fix a NULL check in debugfs init
Date: Wed, 26 Sep 2018 13:41:33 +0300
Message-ID: <20180926104133.GB14535@mwanda>
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
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>, "David (ChunMing) Zhou" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

VGhlIGRlYnVnZnNfY3JlYXRlX2ZpbGUoKSByZXR1cm5zIGVycm9yIHBvaW50ZXJzIGlmIERFQlVH
RlMgaXNuJ3QKZW5hYmxlZC4gIEJ1dCBoZXJlLCB3ZSBrbm93IHRoYXQgaXQgaXMgZW5hYmxlZCBz
byBpdCByZXR1cm5zIE5VTEwgb24KZXJyb3Igd2hpY2ggY291bGQgbGVhZCB0byBhIE5VTEwgZGVy
ZWZlcmVuY2UgYSBmZXcgbGluZXMgbGF0ZXIuCgpTaWduZWQtb2ZmLWJ5OiBEYW4gQ2FycGVudGVy
IDxkYW4uY2FycGVudGVyQG9yYWNsZS5jb20+Ci0tLQpJZiBzb21lb25lIHdhbnRlZCB0byBkZWxl
dGUgdGhlIGVycm9yIGhhbmRsaW5nIGFzIHdlbGwgdGhhdCB3b3VsZCBhbHNvCmJlIGZpbmUsIGJ1
dCBJIGRlY2lkZWQgbm90IHRvIGJvdGhlciB3aXRoIHRoYXQuCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmMKaW5kZXggZjVmYjkzNzk1YTY5Li4wZDgwNmRmZDVl
ZWIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2Zz
LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuYwpAQCAt
ODMyLDEyICs4MzIsMTIgQEAgaW50IGFtZGdwdV9kZWJ1Z2ZzX3JlZ3NfaW5pdChzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldikKIAkJZW50ID0gZGVidWdmc19jcmVhdGVfZmlsZShkZWJ1Z2ZzX3Jl
Z3NfbmFtZXNbaV0sCiAJCQkJCSAgU19JRlJFRyB8IFNfSVJVR08sIHJvb3QsCiAJCQkJCSAgYWRl
diwgZGVidWdmc19yZWdzW2ldKTsKLQkJaWYgKElTX0VSUihlbnQpKSB7CisJCWlmICghZW50KSB7
CiAJCQlmb3IgKGogPSAwOyBqIDwgaTsgaisrKSB7CiAJCQkJZGVidWdmc19yZW1vdmUoYWRldi0+
ZGVidWdmc19yZWdzW2ldKTsKIAkJCQlhZGV2LT5kZWJ1Z2ZzX3JlZ3NbaV0gPSBOVUxMOwogCQkJ
fQotCQkJcmV0dXJuIFBUUl9FUlIoZW50KTsKKwkJCXJldHVybiAtRU5PTUVNOwogCQl9CiAKIAkJ
aWYgKCFpKQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
