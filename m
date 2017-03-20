From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 086/100] drm/amdgpu/dce_virtual: bypass DPM for vf
Date: Mon, 20 Mar 2017 16:30:21 -0400
Message-ID: <1490041835-11255-72-git-send-email-alexander.deucher@amd.com>
References: <1490041835-11255-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1490041835-11255-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Xiangliang Yu <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>, Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>

RnJvbTogWGlhbmdsaWFuZyBZdSA8WGlhbmdsaWFuZy5ZdUBhbWQuY29tPgoKSWYgZW5hYmxlIERQ
TSBmb3IgVkYsIGFsd2F5cyBnZXQgbG90IG9mIHdhcm5fc2xvd19wYXRjaF9udWxsIGluCmRtZXNn
IGFuZCB2ZiBkb2Vzbid0IHN1cHBvcnQgRFBNLgoKU2lnbmVkLW9mZi1ieTogWGlhbmdsaWFuZyBZ
dSA8WGlhbmdsaWFuZy5ZdUBhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBNb25rIExpdSA8TW9uay5M
aXVAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJA
YW1kLmNvbT4KQWNrZWQtYnk6IENocmlzdGlhbiBLw4PCtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0Bh
bWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFt
ZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZGNlX3ZpcnR1YWwuYyB8IDMg
KysrCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZGNlX3ZpcnR1YWwuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2RjZV92aXJ0dWFsLmMKaW5kZXggNWVlMTM5Yy4uOGJiOWNmZCAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZGNlX3ZpcnR1YWwuYworKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9kY2VfdmlydHVhbC5jCkBAIC0yMDQsNiArMjA0LDkgQEAgc3RhdGlj
IHZvaWQgZGNlX3ZpcnR1YWxfY3J0Y19kcG1zKHN0cnVjdCBkcm1fY3J0YyAqY3J0YywgaW50IG1v
ZGUpCiAJc3RydWN0IGFtZGdwdV9jcnRjICphbWRncHVfY3J0YyA9IHRvX2FtZGdwdV9jcnRjKGNy
dGMpOwogCXVuc2lnbmVkIHR5cGU7CiAKKwlpZiAoYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKQorCQly
ZXR1cm47CisKIAlzd2l0Y2ggKG1vZGUpIHsKIAljYXNlIERSTV9NT0RFX0RQTVNfT046CiAJCWFt
ZGdwdV9jcnRjLT5lbmFibGVkID0gdHJ1ZTsKLS0gCjIuNS41CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
