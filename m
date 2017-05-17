From: Colin King <colin.king@canonical.com>
Subject: [PATCH] drm/amd/powerplay: ensure loop does not wraparound on
 decrement
Date: Wed, 17 May 2017 19:13:46 +0100
Message-ID: <20170517181346.11715-1-colin.king@canonical.com>
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
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>, Rex Zhu <Rex.Zhu@amd.com>, Eric Huang <JinHuiEric.Huang@amd.com>, Huang Rui <ray.huang@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

RnJvbTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4KClRoZSBjdXJy
ZW50IGZvciBsb29wIGRlY3JlbWVudHMgaSB3aGVuIGl0IGlzIHplcm8gYW5kIHRoaXMgY2F1c2Vz
CmEgd3JhcC1hcm91bmQgYmFjayB0byB+MCBiZWNhdXNlIGkgaXMgdW5zaWduZWQuIEluIHRoZSB1
bmxpa2VseSBldmVudAp0aGF0IG1hc2sgaXMgMCwgdGhlIGxvb3Agd2lsbCBydW4gZm9yZXZlci4g
Rml4IHRoaXMgc28gd2UgY2FuJ3QgbG9vcApmb3JldmVyLgoKRGV0ZWN0ZWQgYnkgQ292ZXJpdHlT
Y2FuLCBDSUQjMTQzNTQ2OSAoIlVuc2lnbmVkIGNvbXBhcmVkIGFnYWluc3QgMCIpCgpTaWduZWQt
b2ZmLWJ5OiBDb2xpbiBJYW4gS2luZyA8Y29saW4ua2luZ0BjYW5vbmljYWwuY29tPgotLS0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMF9od21nci5jIHwgMiArLQog
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3IvdmVnYTEwX2h3bWdyLmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci92ZWdhMTBfaHdtZ3IuYwppbmRleCBh
ZDMwZjVkM2ExMGQuLmQ5MmM5YjliMTViZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wb3dlcnBsYXkvaHdtZ3IvdmVnYTEwX2h3bWdyLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wb3dlcnBsYXkvaHdtZ3IvdmVnYTEwX2h3bWdyLmMKQEAgLTQxOTksNyArNDE5OSw3IEBAIHN0
YXRpYyBpbnQgdmVnYTEwX2ZvcmNlX2Nsb2NrX2xldmVsKHN0cnVjdCBwcF9od21nciAqaHdtZ3Is
CiAJCX0KIAkJZGF0YS0+c21jX3N0YXRlX3RhYmxlLmdmeF9ib290X2xldmVsID0gaTsKIAotCQlm
b3IgKGkgPSAzMTsgaSA+PSAwOyBpLS0pIHsKKwkJZm9yIChpID0gMzI7IC0taTsgKSB7CiAJCQlp
ZiAobWFzayAmICgxIDw8IGkpKQogCQkJCWJyZWFrOwogCQl9Ci0tIAoyLjExLjAKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5n
IGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
