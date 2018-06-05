From: Eric Anholt <eric@anholt.net>
Subject: [PATCH 3/3] drm/v3d: Add a note about locking of v3d_fence_create().
Date: Tue,  5 Jun 2018 12:03:02 -0700
Message-ID: <20180605190302.18279-3-eric@anholt.net>
References: <20180605190302.18279-1-eric@anholt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180605190302.18279-1-eric@anholt.net>
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
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

VGhpcyBpc24ndCB0aGUgZmlyc3QgdGltZSBJJ3ZlIGhhZCB0byBhcmd1ZSB0byBteXNlbGYgd2h5
IHRoZSAnKysnIHdhcwpzYWZlLgoKU2lnbmVkLW9mZi1ieTogRXJpYyBBbmhvbHQgPGVyaWNAYW5o
b2x0Lm5ldD4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vdjNkL3YzZF9mZW5jZS5jIHwgMyArKysKIDEg
ZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vdjNkL3YzZF9mZW5jZS5jIGIvZHJpdmVycy9ncHUvZHJtL3YzZC92M2RfZmVuY2UuYwppbmRl
eCBiZmUzMWE4OTY2OGIuLjYyNjVlOWFiNGExMyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L3YzZC92M2RfZmVuY2UuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vdjNkL3YzZF9mZW5jZS5jCkBA
IC0zLDYgKzMsOSBAQAogCiAjaW5jbHVkZSAidjNkX2Rydi5oIgogCisvKiBOb3RlIHRoYXQgVjNE
IGZlbmNlcyBhcmUgY3JlYXRlZCBkdXJpbmcgdjNkX2pvYl9ydW4oKSwgc28gd2UncmUKKyAqIGFs
cmVhZHkgaW1wbGljdGx5IGxvY2tlZC4KKyAqLwogc3RydWN0IGRtYV9mZW5jZSAqdjNkX2ZlbmNl
X2NyZWF0ZShzdHJ1Y3QgdjNkX2RldiAqdjNkLCBlbnVtIHYzZF9xdWV1ZSBxdWV1ZSkKIHsKIAlz
dHJ1Y3QgdjNkX2ZlbmNlICpmZW5jZTsKLS0gCjIuMTcuMAoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2
ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
