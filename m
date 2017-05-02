From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 2/3] drm: fourcc byteorder: add DRM_FORMAT_CPU_*
Date: Tue,  2 May 2017 15:34:03 +0200
Message-ID: <20170502133404.15354-3-kraxel@redhat.com>
References: <20170502133404.15354-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170502133404.15354-1-kraxel@redhat.com>
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
Cc: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>, open list <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org, Daniel Vetter <daniel.vetter@intel.com>, Gerd Hoffmann <kraxel@redhat.com>
List-Id: amd-gfx.lists.freedesktop.org

QWRkIGZvdXJjYyB2YXJpYW50cyBpbiBjcHUgYnl0ZSBvcmRlci4gIFdpdGggdGhlc2UgYXQgaGFu
ZCB3ZSBkb24ndApuZWVkICNpZmRlZnMgaW4gZHJpdmVycyB3YW50IHN1cHBvcnQgZnJhbWVidWZm
ZXJzIGluIGNwdSBlbmRpYW5lc3MuCgpTaWduZWQtb2ZmLWJ5OiBHZXJkIEhvZmZtYW5uIDxrcmF4
ZWxAcmVkaGF0LmNvbT4KLS0tCiBpbmNsdWRlL2RybS9kcm1fZm91cmNjLmggfCAxMiArKysrKysr
KysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9kcm0vZHJtX2ZvdXJjYy5oIGIvaW5jbHVkZS9kcm0vZHJtX2ZvdXJjYy5oCmluZGV4IDY5
NDJlODRiNmUuLmNhZTA1MTUzZTggMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvZHJtL2RybV9mb3VyY2Mu
aAorKysgYi9pbmNsdWRlL2RybS9kcm1fZm91cmNjLmgKQEAgLTI1LDYgKzI1LDE4IEBACiAjaW5j
bHVkZSA8bGludXgvdHlwZXMuaD4KICNpbmNsdWRlIDx1YXBpL2RybS9kcm1fZm91cmNjLmg+CiAK
Ky8qCisgKiBEUk0gZm9ybWF0cyBhcmUgbGl0dGxlIGVuZGlhbi4gIGRlZmluZSBjcHUgZW5kaWFu
IHZhcmlhbnRzIGhlcmUsIHRvCisgKiByZWR1Y2UgdGhlICNpZmRlZnMgbmVlZGVkIGluIGRyaXZl
cnMuCisgKi8KKyNpZmRlZiBfX0JJR19FTkRJQU4KKyMgZGVmaW5lIERSTV9GT1JNQVRfQ1BVX1hS
R0I4ODg4IERSTV9GT1JNQVRfQkdSWDg4ODgKKyMgZGVmaW5lIERSTV9GT1JNQVRfQ1BVX0FSR0I4
ODg4IERSTV9GT1JNQVRfQkdSQTg4ODgKKyNlbHNlCisjIGRlZmluZSBEUk1fRk9STUFUX0NQVV9Y
UkdCODg4OCBEUk1fRk9STUFUX1hSR0I4ODg4CisjIGRlZmluZSBEUk1fRk9STUFUX0NQVV9BUkdC
ODg4OCBEUk1fRk9STUFUX0FSR0I4ODg4CisjZW5kaWYKKwogc3RydWN0IGRybV9kZXZpY2U7CiBz
dHJ1Y3QgZHJtX21vZGVfZmJfY21kMjsKIAotLSAKMi45LjMKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRl
dmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
