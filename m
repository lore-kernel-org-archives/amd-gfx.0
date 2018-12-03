From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
Subject: [PATCH 3/3] drm/amdgpu: fix NULL fence handling in
 amdgpu_cs_fence_to_handle_ioctl
Date: Mon,  3 Dec 2018 14:07:59 +0100
Message-ID: <20181203130759.10226-3-christian.koenig@amd.com>
References: <20181203130759.10226-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20181203130759.10226-1-christian.koenig@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

V2hlbiB0aGUgZmVuY2UgaXMgYWxyZWFkeSBzaWduYWxlZCBpdCBpcyBwZXJmZWN0bHkgbm9ybWFs
IHRvIGdldCBhIE5VTEwKZmVuY2UgaGVyZS4gQnV0IHNpbmNlIHdlIGNhbid0IGV4cG9ydCB0aGF0
IHdlIG5lZWQgdG8gdXNlIGEgc3R1YiBmZW5jZS4KClNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBL
w7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfY3MuYyB8IDMgKysrCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25z
KCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYwppbmRleCAwMjRkZmJkODdm
MTEuLmZlNmJlYzIwNzVjNCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2NzLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMK
QEAgLTE0MjEsNiArMTQyMSw5IEBAIGludCBhbWRncHVfY3NfZmVuY2VfdG9faGFuZGxlX2lvY3Rs
KHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsIHZvaWQgKmRhdGEsCiAJaWYgKElTX0VSUihmZW5jZSkp
CiAJCXJldHVybiBQVFJfRVJSKGZlbmNlKTsKIAorCWlmICghZmVuY2UpCisJCWZlbmNlID0gZG1h
X2ZlbmNlX2dldF9zdHViKCk7CisKIAlzd2l0Y2ggKGluZm8tPmluLndoYXQpIHsKIAljYXNlIEFN
REdQVV9GRU5DRV9UT19IQU5ETEVfR0VUX1NZTkNPQko6CiAJCXIgPSBkcm1fc3luY29ial9jcmVh
dGUoJnN5bmNvYmosIDAsIGZlbmNlKTsKLS0gCjIuMTQuMQoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2
ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
