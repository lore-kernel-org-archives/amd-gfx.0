From: =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
Subject: [PATCH 3/6] drm/amd: Use drm_dev_unregister()
Date: Sun,  3 Feb 2019 16:41:57 +0100
Message-ID: <20190203154200.61479-4-noralf@tronnes.org>
References: <20190203154200.61479-1-noralf@tronnes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190203154200.61479-1-noralf@tronnes.org>
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
Cc: oleksandr_andrushchenko@epam.com, intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, airlied@redhat.com, sean@poorly.run, christian.koenig@amd.com
List-Id: amd-gfx.lists.freedesktop.org

ZHJtX2Rldl91bnBsdWcoKSBoYXMgYmVlbiBzdHJpcHBlZCBkb3duIGFuZCBpcyBnb2luZyBhd2F5
LiBPcGVuIGNvZGUgaXRzCjIgcmVtYWluaW5nIGZ1bmN0aW9uIGNhbGxzLgoKQ2M6IEFsZXggRGV1
Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6IENocmlzdGlhbiBLw7ZuaWcgPGNo
cmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6IERhdmlkIChDaHVuTWluZykgWmhvdSA8RGF2aWQx
Llpob3VAYW1kLmNvbT4KU2lnbmVkLW9mZi1ieTogTm9yYWxmIFRyw7hubmVzIDxub3JhbGZAdHJv
bm5lcy5vcmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jIHwg
MyArKy0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMKaW5kZXggYTFiYjM3NzMwODdiLi4x
MjY1ZmMwNzEyMGEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kcnYuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMKQEAg
LTk3MCw3ICs5NzAsOCBAQCBhbWRncHVfcGNpX3JlbW92ZShzdHJ1Y3QgcGNpX2RldiAqcGRldikK
IAlzdHJ1Y3QgZHJtX2RldmljZSAqZGV2ID0gcGNpX2dldF9kcnZkYXRhKHBkZXYpOwogCiAJRFJN
X0VSUk9SKCJEZXZpY2UgcmVtb3ZhbCBpcyBjdXJyZW50bHkgbm90IHN1cHBvcnRlZCBvdXRzaWRl
IG9mIGZiY29uXG4iKTsKLQlkcm1fZGV2X3VucGx1ZyhkZXYpOworCWRybV9kZXZfdW5yZWdpc3Rl
cihkZXYpOworCWRybV9kZXZfcHV0KGRldik7CiAJcGNpX2Rpc2FibGVfZGV2aWNlKHBkZXYpOwog
CXBjaV9zZXRfZHJ2ZGF0YShwZGV2LCBOVUxMKTsKIH0KLS0gCjIuMjAuMQoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlz
dApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
