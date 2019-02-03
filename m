From: =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
Subject: [PATCH 4/6] drm/udl: Use drm_dev_unregister()
Date: Sun,  3 Feb 2019 16:41:58 +0100
Message-ID: <20190203154200.61479-5-noralf@tronnes.org>
References: <20190203154200.61479-1-noralf@tronnes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190203154200.61479-1-noralf@tronnes.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: dri-devel@lists.freedesktop.org
Cc: oleksandr_andrushchenko@epam.com, intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, airlied@redhat.com, sean@poorly.run, christian.koenig@amd.com
List-Id: amd-gfx.lists.freedesktop.org

ZHJtX2Rldl91bnBsdWcoKSBoYXMgYmVlbiBzdHJpcHBlZCBkb3duIGFuZCBpcyBnb2luZyBhd2F5
LiBPcGVuIGNvZGUgaXRzCjIgcmVtYWluaW5nIGZ1bmN0aW9uIGNhbGxzLgoKQ2M6IERhdmUgQWly
bGllIDxhaXJsaWVkQHJlZGhhdC5jb20+CkNjOiBTZWFuIFBhdWwgPHNlYW5AcG9vcmx5LnJ1bj4K
U2lnbmVkLW9mZi1ieTogTm9yYWxmIFRyw7hubmVzIDxub3JhbGZAdHJvbm5lcy5vcmc+Ci0tLQog
ZHJpdmVycy9ncHUvZHJtL3VkbC91ZGxfZHJ2LmMgfCAzICsrLQogMSBmaWxlIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS91ZGwvdWRsX2Rydi5jIGIvZHJpdmVycy9ncHUvZHJtL3VkbC91ZGxfZHJ2LmMKaW5kZXggMjJj
ZDJkMTNlMjcyLi4wNjNlOGUxZTI2NDEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS91ZGwv
dWRsX2Rydi5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS91ZGwvdWRsX2Rydi5jCkBAIC0xMDYsNyAr
MTA2LDggQEAgc3RhdGljIHZvaWQgdWRsX3VzYl9kaXNjb25uZWN0KHN0cnVjdCB1c2JfaW50ZXJm
YWNlICppbnRlcmZhY2UpCiAJZHJtX2ttc19oZWxwZXJfcG9sbF9kaXNhYmxlKGRldik7CiAJdWRs
X2ZiZGV2X3VucGx1ZyhkZXYpOwogCXVkbF9kcm9wX3VzYihkZXYpOwotCWRybV9kZXZfdW5wbHVn
KGRldik7CisJZHJtX2Rldl91bnJlZ2lzdGVyKGRldik7CisJZHJtX2Rldl9wdXQoZGV2KTsKIH0K
IAogLyoKLS0gCjIuMjAuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJp
LWRldmVsCg==
