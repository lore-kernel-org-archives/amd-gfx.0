From: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 5/7] drm/amd/pp: Add powergate_gfx backend function on Raven
Date: Wed, 13 Jun 2018 19:18:04 +0800
Message-ID: <1528888686-18896-5-git-send-email-Rex.Zhu@amd.com>
References: <1528888686-18896-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1528888686-18896-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

UmF2ZW4gc3VwcG9ydCBnZnggb2ZmIGZlYXR1cmUgaW5zdGFuZCBvZiBnZnggcG93ZXJnYXRlLApz
byB1c2Ugc211MTBfZ2Z4X29mZl9jb250cm9sIGFzIHRoZSBwb3dlcmdhdGVfZ2Z4IGJhY2tlbmQg
ZnVuY3Rpb24uCgpTaWduZWQtb2ZmLWJ5OiBSZXggWmh1IDxSZXguWmh1QGFtZC5jb20+Ci0tLQog
ZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3Ivc211MTBfaHdtZ3IuYyB8IDEgKwog
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3Ivc211MTBfaHdtZ3IuYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvcG93ZXJwbGF5L2h3bWdyL3NtdTEwX2h3bWdyLmMKaW5kZXggMGY4MzUyYy4uMGJiZjExZCAx
MDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3Ivc211MTBfaHdt
Z3IuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci9zbXUxMF9od21n
ci5jCkBAIC0xMTg2LDYgKzExODYsNyBAQCBzdGF0aWMgdm9pZCBzbXUxMF9wb3dlcmdhdGVfdmNu
KHN0cnVjdCBwcF9od21nciAqaHdtZ3IsIGJvb2wgYmdhdGUpCiAJLnNtdXNfbm90aWZ5X3B3ZSA9
IHNtdTEwX3NtdXNfbm90aWZ5X3B3ZSwKIAkuZ2Z4X29mZl9jb250cm9sID0gc211MTBfZ2Z4X29m
Zl9jb250cm9sLAogCS5kaXNwbGF5X2Nsb2NrX3ZvbHRhZ2VfcmVxdWVzdCA9IHNtdTEwX2Rpc3Bs
YXlfY2xvY2tfdm9sdGFnZV9yZXF1ZXN0LAorCS5wb3dlcmdhdGVfZ2Z4ID0gc211MTBfZ2Z4X29m
Zl9jb250cm9sLAogfTsKIAogaW50IHNtdTEwX2luaXRfZnVuY3Rpb25fcG9pbnRlcnMoc3RydWN0
IHBwX2h3bWdyICpod21ncikKLS0gCjEuOS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
