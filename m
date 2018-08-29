From: Chunming Zhou <david1.zhou@amd.com>
Subject: [PATCH 1/5] drm: fix syncobj null_fence_enable_signaling
Date: Wed, 29 Aug 2018 18:44:30 +0800
Message-ID: <20180829104434.13265-1-david1.zhou@amd.com>
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
To: dri-devel@lists.freedesktop.org
Cc: Jason Ekstrand <jason@jlekstrand.net>, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

VGhhdCBpcyBjZXJ0YWlubHkgdG90YWxseSBub25zZW5zZS4gZG1hX2ZlbmNlX2VuYWJsZV9zd19z
aWduYWxpbmcoKQppcyB0aGUgZnVuY3Rpb24gd2hvIGlzIGNhbGxpbmcgdGhpcyBjYWxsYmFjay4K
ClNpZ25lZC1vZmYtYnk6IENodW5taW5nIFpob3UgPGRhdmlkMS56aG91QGFtZC5jb20+CkNjOiBK
YXNvbiBFa3N0cmFuZCA8amFzb25Aamxla3N0cmFuZC5uZXQ+ClJldmlld2VkLWJ5OiBDaHJpc3Rp
YW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkFja2VkLWJ5OiBEYW5pZWwgVmV0
dGVyIDxkYW5pZWxAZmZ3bGwuY2g+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2RybV9zeW5jb2JqLmMg
fCAxIC0KIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2RybV9zeW5jb2JqLmMgYi9kcml2ZXJzL2dwdS9kcm0vZHJtX3N5bmNvYmouYwpp
bmRleCAzYTg4MzdjNDk2MzkuLmQxN2VkNzVhYzdlMiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2RybV9zeW5jb2JqLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2RybV9zeW5jb2JqLmMKQEAg
LTE4NCw3ICsxODQsNiBAQCBzdGF0aWMgY29uc3QgY2hhciAqZHJtX3N5bmNvYmpfbnVsbF9mZW5j
ZV9nZXRfbmFtZShzdHJ1Y3QgZG1hX2ZlbmNlICpmZW5jZSkKIAogc3RhdGljIGJvb2wgZHJtX3N5
bmNvYmpfbnVsbF9mZW5jZV9lbmFibGVfc2lnbmFsaW5nKHN0cnVjdCBkbWFfZmVuY2UgKmZlbmNl
KQogewotICAgIGRtYV9mZW5jZV9lbmFibGVfc3dfc2lnbmFsaW5nKGZlbmNlKTsKICAgICByZXR1
cm4gIWRtYV9mZW5jZV9pc19zaWduYWxlZChmZW5jZSk7CiB9CiAKLS0gCjIuMTcuMQoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxp
bmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
