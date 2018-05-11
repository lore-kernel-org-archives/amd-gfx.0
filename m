From: Junwei Zhang <Jerry.Zhang@amd.com>
Subject: [PATCH 1/2] drm/ttm: remove priority hard code when initializing ttm
 bo
Date: Fri, 11 May 2018 12:57:59 +0800
Message-ID: <1526014680-4644-1-git-send-email-Jerry.Zhang@amd.com>
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
Cc: Junwei Zhang <Jerry.Zhang@amd.com>, christian.koenig@amd.com
List-Id: amd-gfx.lists.freedesktop.org

VGhlbiBwcmlvcml0eSBjb3VsZCBiZSBzZXQgYmVmb3JlIGluaXRpYWxpemF0aW9uLgpCeSBkZWZh
dWx0LCBpdCByZXF1aXJlcyB0byBremFsbG9jIHR0bSBiby4gSW4gZmFjdCwgd2UgYWx3YXlzIGRv
IHNvLgoKU2lnbmVkLW9mZi1ieTogSnVud2VpIFpoYW5nIDxKZXJyeS5aaGFuZ0BhbWQuY29tPgot
LS0KIGRyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvLmMgfCAxIC0KIDEgZmlsZSBjaGFuZ2VkLCAx
IGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm8uYyBi
L2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvLmMKaW5kZXggOThlMDZmOC4uY2JhNTAxNSAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm8uYworKysgYi9kcml2ZXJzL2dwdS9k
cm0vdHRtL3R0bV9iby5jCkBAIC0xMTc1LDcgKzExNzUsNiBAQCBpbnQgdHRtX2JvX2luaXRfcmVz
ZXJ2ZWQoc3RydWN0IHR0bV9ib19kZXZpY2UgKmJkZXYsCiAJcmVzZXJ2YXRpb25fb2JqZWN0X2lu
aXQoJmJvLT50dG1fcmVzdik7CiAJYXRvbWljX2luYygmYm8tPmJkZXYtPmdsb2ItPmJvX2NvdW50
KTsKIAlkcm1fdm1hX25vZGVfcmVzZXQoJmJvLT52bWFfbm9kZSk7Ci0JYm8tPnByaW9yaXR5ID0g
MDsKIAogCS8qCiAJICogRm9yIHR0bV9ib190eXBlX2RldmljZSBidWZmZXJzLCBhbGxvY2F0ZQot
LSAKMS45LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
