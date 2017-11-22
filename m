From: Roger He <Hongbo.He@amd.com>
Subject: [PATCH 4/5] drm/ttm: free one in huge pool even shrink request less
 than one element
Date: Wed, 22 Nov 2017 16:06:36 +0800
Message-ID: <1511337997-26698-4-git-send-email-Hongbo.He@amd.com>
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

Q2hhbmdlLUlkOiBJZDhiZDRkMWVjZmY5ZjNhYjE0MzU1ZTJkYmQxYzU5YjlmZTgyNGUwMQpTaWdu
ZWQtb2ZmLWJ5OiBSb2dlciBIZSA8SG9uZ2JvLkhlQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUv
ZHJtL3R0bS90dG1fcGFnZV9hbGxvYy5jIHwgNiArKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCA0IGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L3R0bS90dG1fcGFnZV9hbGxvYy5jIGIvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fcGFnZV9hbGxv
Yy5jCmluZGV4IDM0M2RiMGIuLjgyZDQwYzYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS90
dG0vdHRtX3BhZ2VfYWxsb2MuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9wYWdlX2Fs
bG9jLmMKQEAgLTQ0NCwxMSArNDQ0LDEzIEBAIHR0bV9wb29sX3Nocmlua19zY2FuKHN0cnVjdCBz
aHJpbmtlciAqc2hyaW5rLCBzdHJ1Y3Qgc2hyaW5rX2NvbnRyb2wgKnNjKQogCQlwb29sID0gJl9t
YW5hZ2VyLT5wb29sc1soaSArIHBvb2xfb2Zmc2V0KSVOVU1fUE9PTFNdOwogCQkvKiBPSyB0byB1
c2Ugc3RhdGljIGJ1ZmZlciBzaW5jZSBnbG9iYWwgbXV0ZXggaXMgaGVsZC4gKi8KIAkJbnJfZnJl
ZV9wb29sID0gKG5yX2ZyZWUgPj4gcG9vbC0+b3JkZXIpOwotCQlpZiAobnJfZnJlZV9wb29sID09
IDApCi0JCQljb250aW51ZTsKKwkJaWYgKCFucl9mcmVlX3Bvb2wgJiYgcG9vbC0+b3JkZXIpCisJ
CQlucl9mcmVlX3Bvb2wgPSAxOwogCiAJCXNocmlua19wYWdlcyA9IHR0bV9wYWdlX3Bvb2xfZnJl
ZShwb29sLCBucl9mcmVlX3Bvb2wsIHRydWUpOwogCQlmcmVlZCArPSAoKG5yX2ZyZWVfcG9vbCAt
IHNocmlua19wYWdlcykgPDwgcG9vbC0+b3JkZXIpOworCQlpZiAoZnJlZWQgPj0gc2MtPm5yX3Rv
X3NjYW4pCisJCQlicmVhazsKIAl9CiAJbXV0ZXhfdW5sb2NrKCZsb2NrKTsKIAlyZXR1cm4gZnJl
ZWQ7Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRl
dmVsCg==
