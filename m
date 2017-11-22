From: Roger He <Hongbo.He-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/3] drm/ttm: add set_pages_wb for handling page order more
 than zero
Date: Wed, 22 Nov 2017 19:44:27 +0800
Message-ID: <1511351069-4757-1-git-send-email-Hongbo.He@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Roger He <Hongbo.He-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJZGY1Y2NiNTc5ZDI2NGIzNDMxOTlkOGI4MzQ0YmRkZWVjMmMwMDE5ZgpTaWdu
ZWQtb2ZmLWJ5OiBSb2dlciBIZSA8SG9uZ2JvLkhlQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUv
ZHJtL3R0bS90dG1fcGFnZV9hbGxvYy5jIHwgMTEgKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2Vk
LCAxMSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1f
cGFnZV9hbGxvYy5jIGIvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fcGFnZV9hbGxvYy5jCmluZGV4
IGE4YjJiZmEuLmNkYmI3MzEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX3Bh
Z2VfYWxsb2MuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9wYWdlX2FsbG9jLmMKQEAg
LTIyMyw2ICsyMjMsMTcgQEAgc3RhdGljIHN0cnVjdCBrb2JqX3R5cGUgdHRtX3Bvb2xfa29ial90
eXBlID0gewogc3RhdGljIHN0cnVjdCB0dG1fcG9vbF9tYW5hZ2VyICpfbWFuYWdlcjsKIAogI2lm
bmRlZiBDT05GSUdfWDg2CitzdGF0aWMgaW50IHNldF9wYWdlc193YihzdHJ1Y3QgcGFnZSAqcGFn
ZSwgaW50IG51bXBhZ2VzKQoreworI2lmIElTX0VOQUJMRUQoQ09ORklHX0FHUCkKKwlpbnQgaTsK
KworCWZvciAoaSA9IDA7IGkgPCBudW1wYWdlczsgaSsrKQorCQl1bm1hcF9wYWdlX2Zyb21fYWdw
KHBhZ2UrKyk7CisjZW5kaWYKKwlyZXR1cm4gMDsKK30KKwogc3RhdGljIGludCBzZXRfcGFnZXNf
YXJyYXlfd2Ioc3RydWN0IHBhZ2UgKipwYWdlcywgaW50IGFkZHJpbmFycmF5KQogewogI2lmIElT
X0VOQUJMRUQoQ09ORklHX0FHUCkKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
