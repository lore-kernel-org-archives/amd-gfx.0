From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
Subject: [PATCH 4/6] drm/amdgpu: drop the backing store when DMA-buf imports
 are evicted
Date: Tue,  6 Mar 2018 15:43:45 +0100
Message-ID: <20180306144347.1702-4-christian.koenig@amd.com>
References: <20180306144347.1702-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180306144347.1702-1-christian.koenig@amd.com>
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
List-Id: amd-gfx.lists.freedesktop.org

SW5zdGVhZCBvZiBtb3ZpbmcgdGhpcyB0byB0aGUgU1lTVEVNIGRvbWFpbiBqdXN0IGRyb3AgdGhl
IGJhY2tpbmcgc3RvcmUKYW5kIGxldCB0aGUgcmVzdWx0aW5nIGFsbG9jYXRpb24gYmUgZnJlZWQu
CgpTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5j
b20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jIHwgNiArKysr
KysKIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdHRtLmMKaW5kZXggNDRhZTJjNjBjOWQ0Li5lZWJjOWY3N2I2MTEgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYworKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKQEAgLTIwMyw2ICsyMDMsMTIgQEAg
c3RhdGljIHZvaWQgYW1kZ3B1X2V2aWN0X2ZsYWdzKHN0cnVjdCB0dG1fYnVmZmVyX29iamVjdCAq
Ym8sCiAJCS5mbGFncyA9IFRUTV9QTF9NQVNLX0NBQ0hJTkcgfCBUVE1fUExfRkxBR19TWVNURU0K
IAl9OwogCisJaWYgKGJvLT50eXBlID09IHR0bV9ib190eXBlX3NnKSB7CisJCXBsYWNlbWVudC0+
bnVtX3BsYWNlbWVudCA9IDA7CisJCXBsYWNlbWVudC0+bnVtX2J1c3lfcGxhY2VtZW50ID0gMDsK
KwkJcmV0dXJuOworCX0KKwogCWlmICghYW1kZ3B1X3R0bV9ib19pc19hbWRncHVfYm8oYm8pKSB7
CiAJCXBsYWNlbWVudC0+cGxhY2VtZW50ID0gJnBsYWNlbWVudHM7CiAJCXBsYWNlbWVudC0+YnVz
eV9wbGFjZW1lbnQgPSAmcGxhY2VtZW50czsKLS0gCjIuMTQuMQoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmkt
ZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
