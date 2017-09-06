From: =?UTF-8?q?Christian=20K=C3=B6nig?= <deathsimple@vodafone.de>
Subject: [PATCH 1/3] drm/ttm: allow mapping BOs while they are still on the
 swap list
Date: Wed,  6 Sep 2017 17:51:32 +0200
Message-ID: <1504713094-2455-1-git-send-email-deathsimple@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
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
List-Id: amd-gfx.lists.freedesktop.org

RnJvbTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKV2l0aCBz
aGFyZWQgcmVzZXJ2YXRpb24gb2JqZWN0cyBpdCBpcyBwb3NzaWJsZSB0aGF0IHdlIHdhbnQgdG8g
dGVtcG9yYXJ5CmttYXAgYW4gQk8gd2hpbGUgaXQgaXMgc3RpbGwgb24gdGhlIHN3YXAgbGlzdC4K
ClNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNv
bT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9ib191dGlsLmMgfCAxIC0KIDEgZmlsZSBj
aGFuZ2VkLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3R0bS90
dG1fYm9fdXRpbC5jIGIvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm9fdXRpbC5jCmluZGV4IGM5
MzRhZDUuLjc4Y2I5OWIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvX3V0
aWwuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9ib191dGlsLmMKQEAgLTU4Nyw3ICs1
ODcsNiBAQCBpbnQgdHRtX2JvX2ttYXAoc3RydWN0IHR0bV9idWZmZXJfb2JqZWN0ICpibywKIAl1
bnNpZ25lZCBsb25nIG9mZnNldCwgc2l6ZTsKIAlpbnQgcmV0OwogCi0JQlVHX09OKCFsaXN0X2Vt
cHR5KCZiby0+c3dhcCkpOwogCW1hcC0+dmlydHVhbCA9IE5VTEw7CiAJbWFwLT5ibyA9IGJvOwog
CWlmIChudW1fcGFnZXMgPiBiby0+bnVtX3BhZ2VzKQotLSAKMi43LjQKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QK
ZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
