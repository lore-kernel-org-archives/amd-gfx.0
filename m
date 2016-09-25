From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH] drm/amdgpu: clear ring pointer in amdgpu_device on teardown
Date: Sun, 25 Sep 2016 23:34:47 +0300
Message-ID: <1474835690-2621-2-git-send-email-notasas@gmail.com>
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

VGhpcyBpcyBpbiBzeW1tZXRyeSB0byBzZXR1cCBkb25lIGluIGFtZGdwdV9yaW5nX2luaXQuCgpT
aWduZWQtb2ZmLWJ5OiBHcmF6dnlkYXMgSWdub3RhcyA8bm90YXNhc0BnbWFpbC5jb20+Ci0tLQog
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3JpbmcuYyB8IDIgKysKIDEgZmlsZSBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfcmluZy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3JpbmcuYwppbmRleCA3NzdmMTFiLi5lMWZhODczIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9yaW5nLmMKQEAgLTI2NCw2ICsyNjQsOCBAQCB2b2lkIGFtZGdwdV9yaW5nX2Zp
bmkoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nKQogCQkJICAgICAgKHZvaWQgKiopJnJpbmctPnJp
bmcpOwogCiAJYW1kZ3B1X2RlYnVnZnNfcmluZ19maW5pKHJpbmcpOworCisJcmluZy0+YWRldi0+
cmluZ3NbcmluZy0+aWR4XSA9IE5VTEw7CiB9CiAKIC8qCi0tIAoyLjcuNAoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlz
dApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
