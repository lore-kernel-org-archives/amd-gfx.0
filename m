From: Colin King <colin.king@canonical.com>
Subject: [PATCH][next] drm/amdgpu: fix off-by-one comparison on a WARN_ON
 message
Date: Fri, 28 Jun 2019 15:08:01 +0100
Message-ID: <20190628140801.31937-1-colin.king@canonical.com>
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
To: Hawking Zhang <Hawking.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

RnJvbTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4KClRoZSBXQVJO
X09OIGlzIGN1cnJlbnRseSB0aHJvd2luZyBhIHdhcm5pbmcgd2hlbiBpIGlzIDY1IG9yIGhpZ2hl
ciB3aGljaAppcyBvZmYgYnkgb25lLiBJdCBzaG91bGQgYmUgNjQgb3IgaGlnaGVyICg2NCBxdWV1
ZXMgZnJvbSAwLi42MyBpbmNsdXNpdmUpLApzbyBmaXggdGhpcyBvZmYtYnktb25lIGNvbXBhcmlz
b24uCgpGaXhlczogODQ5YWNhOWY5YzAzICgiZHJtL2FtZGdwdTogTW92ZSBjb21tb24gY29kZSB0
byBhbWRncHVfZ2Z4LmMiKQpTaWduZWQtb2ZmLWJ5OiBDb2xpbiBJYW4gS2luZyA8Y29saW4ua2lu
Z0BjYW5vbmljYWwuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9n
ZnguYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigt
KQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZnguYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZnguYwppbmRleCA3NDA2NmUxNDY2
ZjcuLmM4ZDEwNmM1OWUyNyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2dmeC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZngu
YwpAQCAtNTAxLDcgKzUwMSw3IEBAIGludCBhbWRncHVfZ2Z4X2VuYWJsZV9rY3Eoc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYpCiAJCS8qIFRoaXMgc2l0dWF0aW9uIG1heSBiZSBoaXQgaW4gdGhl
IGZ1dHVyZSBpZiBhIG5ldyBIVwogCQkgKiBnZW5lcmF0aW9uIGV4cG9zZXMgbW9yZSB0aGFuIDY0
IHF1ZXVlcy4gSWYgc28sIHRoZQogCQkgKiBkZWZpbml0aW9uIG9mIHF1ZXVlX21hc2sgbmVlZHMg
dXBkYXRpbmcgKi8KLQkJaWYgKFdBUk5fT04oaSA+IChzaXplb2YocXVldWVfbWFzaykqOCkpKSB7
CisJCWlmIChXQVJOX09OKGkgPj0gKHNpemVvZihxdWV1ZV9tYXNrKSo4KSkpIHsKIAkJCURSTV9F
UlJPUigiSW52YWxpZCBLQ1EgZW5hYmxlZDogJWRcbiIsIGkpOwogCQkJYnJlYWs7CiAJCX0KLS0g
CjIuMjAuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
ZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs
