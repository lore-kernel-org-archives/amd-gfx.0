From: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/7] drm/ttm:fix incorrect calculate on shrink_pages
Date: Tue, 12 Dec 2017 17:46:39 +0800
Message-ID: <1513072005-3477-1-git-send-email-Monk.Liu@amd.com>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>

c2hyaW5rX3BhZ2VzIGlzIGluIHVuaXQgb2YgT3JkZXIgYWZ0ZXIgdHRtX3BhZ2VfcG9vbF9mcmVl
LApidXQgaXQgaXMgdXNlZCBieSBucl9mcmVlIGluIG5leHQgcm91bmQgc28gbmVlZCBjaGFuZ2UK
aXQgaW50byBuYXRpdmUgcGFnZSB1bml0CgpDaGFuZ2UtSWQ6IEkzM2I3N2FjMTYxNmUyNGIxYjg4
MWVlZTU0YzNiZDczNDJjZmE5YWI4ClNpZ25lZC1vZmYtYnk6IE1vbmsgTGl1IDxNb25rLkxpdUBh
bWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS90dG0vdHRtX3BhZ2VfYWxsb2MuYyB8IDEgKwog
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL3R0bS90dG1fcGFnZV9hbGxvYy5jIGIvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fcGFnZV9h
bGxvYy5jCmluZGV4IDQ0MzQzYTIuLjcxOTQ1Y2MgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS90dG0vdHRtX3BhZ2VfYWxsb2MuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9wYWdl
X2FsbG9jLmMKQEAgLTQ1NSw2ICs0NTUsNyBAQCB0dG1fcG9vbF9zaHJpbmtfc2NhbihzdHJ1Y3Qg
c2hyaW5rZXIgKnNocmluaywgc3RydWN0IHNocmlua19jb250cm9sICpzYykKIAkJZnJlZWQgKz0g
KG5yX2ZyZWVfcG9vbCAtIHNocmlua19wYWdlcykgPDwgcG9vbC0+b3JkZXI7CiAJCWlmIChmcmVl
ZCA+PSBzYy0+bnJfdG9fc2NhbikKIAkJCWJyZWFrOworCQlzaHJpbmtfcGFnZXMgPDw9IHBvb2wt
Pm9yZGVyOwogCX0KIAltdXRleF91bmxvY2soJmxvY2spOwogCXJldHVybiBmcmVlZDsKLS0gCjIu
Ny40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
