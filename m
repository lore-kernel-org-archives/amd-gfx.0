From: Roger He <Hongbo.He@amd.com>
Subject: [PATCH 2/4] drm/ttm: use NUM_PAGES_TO_ALLOC always
Date: Tue, 21 Nov 2017 17:32:20 +0800
Message-ID: <1511256742-5601-3-git-send-email-Hongbo.He@amd.com>
References: <1511256742-5601-1-git-send-email-Hongbo.He@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1511256742-5601-1-git-send-email-Hongbo.He@amd.com>
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
Cc: Roger He <Hongbo.He@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

Q2hhbmdlLUlkOiBJZGU5NmExY2NhZDliYjQ0YjBiYjBkODBlMTIzYzJkODEwYmE2MThlZApTaWdu
ZWQtb2ZmLWJ5OiBSb2dlciBIZSA8SG9uZ2JvLkhlQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUv
ZHJtL3R0bS90dG1fcGFnZV9hbGxvYy5jIHwgMyArLS0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vdHRt
L3R0bV9wYWdlX2FsbG9jLmMgYi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9wYWdlX2FsbG9jLmMK
aW5kZXggMmI4M2M1Mi4uMjdiMjQwMiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3R0bS90
dG1fcGFnZV9hbGxvYy5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX3BhZ2VfYWxsb2Mu
YwpAQCAtNTIwLDggKzUyMCw3IEBAIHN0YXRpYyBpbnQgdHRtX2FsbG9jX25ld19wYWdlcyhzdHJ1
Y3QgbGlzdF9oZWFkICpwYWdlcywgZ2ZwX3QgZ2ZwX2ZsYWdzLAogCWludCByID0gMDsKIAl1bnNp
Z25lZCBpLCBqLCBjcGFnZXM7CiAJdW5zaWduZWQgbnBhZ2VzID0gMSA8PCBvcmRlcjsKLQl1bnNp
Z25lZCBtYXhfY3BhZ2VzID0gbWluKGNvdW50LAotCQkJKHVuc2lnbmVkKShQQUdFX1NJWkUvc2l6
ZW9mKHN0cnVjdCBwYWdlICopKSk7CisJdW5zaWduZWQgbWF4X2NwYWdlcyA9IG1pbihjb3VudCwg
KHVuc2lnbmVkKU5VTV9QQUdFU19UT19BTExPQyk7CiAKIAkvKiBhbGxvY2F0ZSBhcnJheSBmb3Ig
cGFnZSBjYWNoaW5nIGNoYW5nZSAqLwogCWNhY2hpbmdfYXJyYXkgPSBrbWFsbG9jKG1heF9jcGFn
ZXMqc2l6ZW9mKHN0cnVjdCBwYWdlICopLCBHRlBfS0VSTkVMKTsKLS0gCjIuNy40CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGlu
ZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
