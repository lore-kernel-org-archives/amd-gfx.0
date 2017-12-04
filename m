From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
Subject: [PATCH 1/2] drm/ttm: swap consecutive allocated cached pages
Date: Mon,  4 Dec 2017 12:42:23 +0100
Message-ID: <20171204114224.27712-1-christian.koenig@amd.com>
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
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, Hongbo.He@amd.com
List-Id: amd-gfx.lists.freedesktop.org

V2hlbiB3ZSBkZXRlY3QgY29uc2VjdXRpdmUgYWxsb2NhdGlvbiBvZiBwYWdlcyBzd2FwIHRoZW0g
dG8gYXZvaWQKYWNjaWRlbnRhbGx5IGZyZWVpbmcgdGhlbSBhcyBodWdlIHBhZ2UuCgpTaWduZWQt
b2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Ci0tLQog
ZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fcGFnZV9hbGxvYy5jIHwgOCArKysrKysrKwogMSBmaWxl
IGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS90
dG0vdHRtX3BhZ2VfYWxsb2MuYyBiL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX3BhZ2VfYWxsb2Mu
YwppbmRleCBjODJkOTRjYmJhYmMuLjYwNDAxMzUwYTAxYSAxMDA2NDQKLS0tIGEvZHJpdmVycy9n
cHUvZHJtL3R0bS90dG1fcGFnZV9hbGxvYy5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRt
X3BhZ2VfYWxsb2MuYwpAQCAtOTIxLDYgKzkyMSwxNCBAQCBzdGF0aWMgaW50IHR0bV9nZXRfcGFn
ZXMoc3RydWN0IHBhZ2UgKipwYWdlcywgdW5zaWduZWQgbnBhZ2VzLCBpbnQgZmxhZ3MsCiAJCQkJ
cmV0dXJuIC1FTk9NRU07CiAJCQl9CiAKKwkJCS8qIFN3YXAgdGhlIHBhZ2VzIGlmIHdlIGRldGVj
dCBjb25zZWN1dGl2ZSBvcmRlciAqLworCQkJaWYgKGkgJiYgcGFnZXNbaSAtIDFdID09IHAgLSAx
KSB7CisJCQkJc3RydWN0IHBhZ2UgKnRtcCA9IHA7CisKKwkJCQlwID0gcGFnZXNbaSAtIDFdOwor
CQkJCXBhZ2VzW2kgLSAxXSA9IHRtcDsKKwkJCX0KKwogCQkJcGFnZXNbaSsrXSA9IHA7CiAJCQkt
LW5wYWdlczsKIAkJfQotLSAKMi4xMS4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9kcmktZGV2ZWwK
