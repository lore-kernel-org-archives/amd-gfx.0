From: "Huang, Ray" <Ray.Huang@amd.com>
Subject: [PATCH 02/14] drm/amdgpu: add UAPI for creating secure contexts (v2)
Date: Wed, 11 Sep 2019 11:50:08 +0000
Message-ID: <1568202584-14471-3-git-send-email-ray.huang@amd.com>
References: <1568202584-14471-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1568202584-14471-1-git-send-email-ray.huang@amd.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, "Liu,
 Aaron" <Aaron.Liu@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

RnJvbTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgoKQWRkIGEgZmxh
ZyBmb3Igd2hlbiBhbGxvY2F0aW5nIGEgY29udGV4dCB0byBmbGFnIGl0IGFzCnNlY3VyZS4gIFRo
ZSBrZXJuZWwgZHJpdmVyIHdpbGwgdXNlIHRoaXMgZmxhZyB0byBkZXRlcm1pbmUKd2hldGhlciBh
IHJlbmRlcmluZyBjb250ZXh0IGlzIHNlY3VyZSBvciBub3Qgc28gdGhhdCB0aGUKZW5naW5lIGNh
biBiZSB0cmFuc2l0aW9uZWQgYmV0d2VlbiBzZWN1cmUgb3IgdW5zZWN1cmUKb3IgdGhlIHdvcmsg
Y2FuIGJlIHN1Ym1pdHRlZCB0byBhIHNlY3VyZSBxdWV1ZSBkZXBlbmRpbmcKb24gdGhlIElQLgoK
djI6IHRoZSBmbGFnIHdpbGwgYmUgdXNlZCBmb3Igc2VjdXJpdHksIHNvIHJlbW92ZSB0aGUgY29t
bWVudCAoUmF5KQoKU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hl
ckBhbWQuY29tPgpSZXZpZXdlZC1ieTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KU2ln
bmVkLW9mZi1ieTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KLS0tCiBpbmNsdWRlL3Vh
cGkvZHJtL2FtZGdwdV9kcm0uaCB8IDQgKysrLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9kcm0vYW1kZ3B1
X2RybS5oIGIvaW5jbHVkZS91YXBpL2RybS9hbWRncHVfZHJtLmgKaW5kZXggZjkwYjQ1My4uN2Fh
YjRlMSAxMDA2NDQKLS0tIGEvaW5jbHVkZS91YXBpL2RybS9hbWRncHVfZHJtLmgKKysrIGIvaW5j
bHVkZS91YXBpL2RybS9hbWRncHVfZHJtLmgKQEAgLTIwNyw2ICsyMDcsOSBAQCB1bmlvbiBkcm1f
YW1kZ3B1X2JvX2xpc3QgewogI2RlZmluZSBBTURHUFVfQ1RYX09QX1FVRVJZX1NUQVRFCTMKICNk
ZWZpbmUgQU1ER1BVX0NUWF9PUF9RVUVSWV9TVEFURTIJNAogCisvKiBGbGFnIHRoZSBjb250ZXh0
IGFzIHNlY3VyZSAqLworI2RlZmluZSBBTURHUFVfQ1RYX0FMTE9DX0ZMQUdTX1NFQ1VSRQkoMSA8
PCAwKQorCiAvKiBHUFUgcmVzZXQgc3RhdHVzICovCiAjZGVmaW5lIEFNREdQVV9DVFhfTk9fUkVT
RVQJCTAKIC8qIHRoaXMgdGhlIGNvbnRleHQgY2F1c2VkIGl0ICovCkBAIC0yNDEsNyArMjQ0LDYg
QEAgdW5pb24gZHJtX2FtZGdwdV9ib19saXN0IHsKIHN0cnVjdCBkcm1fYW1kZ3B1X2N0eF9pbiB7
CiAJLyoqIEFNREdQVV9DVFhfT1BfKiAqLwogCV9fdTMyCW9wOwotCS8qKiBGb3IgZnV0dXJlIHVz
ZSwgbm8gZmxhZ3MgZGVmaW5lZCBzbyBmYXIgKi8KIAlfX3UzMglmbGFnczsKIAlfX3UzMgljdHhf
aWQ7CiAJLyoqIEFNREdQVV9DVFhfUFJJT1JJVFlfKiAqLwotLSAKMi43LjQKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxp
c3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbA==
