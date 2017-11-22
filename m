From: Roger He <Hongbo.He@amd.com>
Subject: [PATCH 5/5] drm/ttm: delete set_pages_array_wb since no one use it
 anymore
Date: Wed, 22 Nov 2017 17:17:14 +0800
Message-ID: <1511342234-18570-5-git-send-email-Hongbo.He@amd.com>
References: <1511342234-18570-1-git-send-email-Hongbo.He@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1511342234-18570-1-git-send-email-Hongbo.He@amd.com>
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
Cc: Roger He <Hongbo.He@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

Q2hhbmdlLUlkOiBJOWZhNDVhZjQ0N2MzYzc4ZDBiN2IyYjg5NTgwODFlNTg0YzU2MDEyMApTaWdu
ZWQtb2ZmLWJ5OiBSb2dlciBIZSA8SG9uZ2JvLkhlQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUv
ZHJtL3R0bS90dG1fcGFnZV9hbGxvYy5jIHwgMTEgLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2Vk
LCAxMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9w
YWdlX2FsbG9jLmMgYi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9wYWdlX2FsbG9jLmMKaW5kZXgg
YTcxMGQ5ZS4uMzg4YzViMSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fcGFn
ZV9hbGxvYy5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX3BhZ2VfYWxsb2MuYwpAQCAt
MjM3LDE3ICsyMzcsNiBAQCBzdGF0aWMgaW50IHNldF9wYWdlc193YihzdHJ1Y3QgcGFnZSAqcGFn
ZSwgaW50IG51bXBhZ2VzKQogCXJldHVybiAwOwogfQogCi1zdGF0aWMgaW50IHNldF9wYWdlc19h
cnJheV93YihzdHJ1Y3QgcGFnZSAqKnBhZ2VzLCBpbnQgYWRkcmluYXJyYXkpCi17Ci0jaWYgSVNf
RU5BQkxFRChDT05GSUdfQUdQKQotCWludCBpOwotCi0JZm9yIChpID0gMDsgaSA8IGFkZHJpbmFy
cmF5OyBpKyspCi0JCXVubWFwX3BhZ2VfZnJvbV9hZ3AocGFnZXNbaV0pOwotI2VuZGlmCi0JcmV0
dXJuIDA7Ci19Ci0KIHN0YXRpYyBpbnQgc2V0X3BhZ2VzX2FycmF5X3djKHN0cnVjdCBwYWdlICoq
cGFnZXMsIGludCBhZGRyaW5hcnJheSkKIHsKICNpZiBJU19FTkFCTEVEKENPTkZJR19BR1ApCi0t
IAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
ZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
