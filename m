From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
Subject: [PATCH] drm/ttm: drop the spin in delayed delete if the trylock
 doesn't work
Date: Thu, 21 Dec 2017 19:05:46 +0100
Message-ID: <20171221180546.1281-1-christian.koenig@amd.com>
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
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

VGhvbWFzIGFjdHVhbGx5IG5vdGljZWQgdGhhdCwgYnV0IEkgZGlkbid0IHJlYWxpemVkIHdoYXQg
aGUgbWVhbnQgdW50aWwKbm93LgoKU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hy
aXN0aWFuLmtvZW5pZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvLmMg
fCAyICsrCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL3R0bS90dG1fYm8uYyBiL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvLmMK
aW5kZXggNjBiYjVjMTJiNTY4Li44NGRmYTIzNjhhNzIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1
L2RybS90dG0vdHRtX2JvLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm8uYwpAQCAt
NTkyLDYgKzU5Miw4IEBAIHN0YXRpYyBib29sIHR0bV9ib19kZWxheWVkX2RlbGV0ZShzdHJ1Y3Qg
dHRtX2JvX2RldmljZSAqYmRldiwgYm9vbCByZW1vdmVfYWxsKQogCiAJCX0gZWxzZSBpZiAocmVz
ZXJ2YXRpb25fb2JqZWN0X3RyeWxvY2soYm8tPnJlc3YpKSB7CiAJCQl0dG1fYm9fY2xlYW51cF9y
ZWZzKGJvLCBmYWxzZSwgIXJlbW92ZV9hbGwsIHRydWUpOworCQl9IGVsc2UgeworCQkJc3Bpbl91
bmxvY2soJmdsb2ItPmxydV9sb2NrKTsKIAkJfQogCiAJCWtyZWZfcHV0KCZiby0+bGlzdF9rcmVm
LCB0dG1fYm9fcmVsZWFzZV9saXN0KTsKLS0gCjIuMTEuMAoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2
ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
