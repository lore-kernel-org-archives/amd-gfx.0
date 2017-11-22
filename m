From: Roger He <Hongbo.He@amd.com>
Subject: [PATCH 2/5] drm/ttm: add set_pages_wb for handling page order more
 than zero
Date: Wed, 22 Nov 2017 16:06:34 +0800
Message-ID: <1511337997-26698-2-git-send-email-Hongbo.He@amd.com>
References: <1511337997-26698-1-git-send-email-Hongbo.He@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1511337997-26698-1-git-send-email-Hongbo.He@amd.com>
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
Cc: Roger He <Hongbo.He@amd.com>, Christian.Koenig@amd.com
List-Id: amd-gfx.lists.freedesktop.org

Q2hhbmdlLUlkOiBJZGY1Y2NiNTc5ZDI2NGIzNDMxOTlkOGI4MzQ0YmRkZWVjMmMwMDE5ZgpTaWdu
ZWQtb2ZmLWJ5OiBSb2dlciBIZSA8SG9uZ2JvLkhlQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUv
ZHJtL3R0bS90dG1fcGFnZV9hbGxvYy5jIHwgMTEgKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2Vk
LCAxMSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1f
cGFnZV9hbGxvYy5jIGIvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fcGFnZV9hbGxvYy5jCmluZGV4
IDJkYjU1MWYuLmZhYmIwODIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX3Bh
Z2VfYWxsb2MuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9wYWdlX2FsbG9jLmMKQEAg
LTIyNiw2ICsyMjYsMTcgQEAgc3RhdGljIHN0cnVjdCBrb2JqX3R5cGUgdHRtX3Bvb2xfa29ial90
eXBlID0gewogc3RhdGljIHN0cnVjdCB0dG1fcG9vbF9tYW5hZ2VyICpfbWFuYWdlcjsKIAogI2lm
bmRlZiBDT05GSUdfWDg2CitzdGF0aWMgaW50IHNldF9wYWdlc193YihzdHJ1Y3QgcGFnZSAqcGFn
ZSwgaW50IG51bXBhZ2VzKQoreworI2lmIElTX0VOQUJMRUQoQ09ORklHX0FHUCkKKwlpbnQgaTsK
KworCWZvciAoaSA9IDA7IGkgPCBudW1wYWdlczsgaSsrKQorCQl1bm1hcF9wYWdlX2Zyb21fYWdw
KHBhZ2UrKyk7CisjZW5kaWYKKwlyZXR1cm4gMDsKK30KKwogc3RhdGljIGludCBzZXRfcGFnZXNf
YXJyYXlfd2Ioc3RydWN0IHBhZ2UgKipwYWdlcywgaW50IGFkZHJpbmFycmF5KQogewogI2lmIElT
X0VOQUJMRUQoQ09ORklHX0FHUCkKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9kcmktZGV2ZWwK
