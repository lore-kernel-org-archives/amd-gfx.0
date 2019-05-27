From: Emily Deng <Emily.Deng-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: Don't need to call csb_vram_unpin
Date: Mon, 27 May 2019 16:41:27 +0800
Message-ID: <1558946487-18034-1-git-send-email-Emily.Deng@amd.com>
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
Cc: Emily Deng <Emily.Deng-5C7GfCeVMHo@public.gmane.org>

QXMgaXQgd2lsbCBkZXN0cm95IGNsZWFyX3N0YXRlX29iaiwgYW5kIGFsc28gd2lsbAp1bnBpbiBp
dCBpbiB0aGUgZ2Z4X3Y5XzBfc3dfZmluaSwgc28gZG9uJ3QgbmVlZCB0bwpjYWxsIGNzYl92cmFt
IHVucGluIGluIGdmeF92OV8wX2h3X2ZpbmksIG9yIGl0IHdpbGwKaGF2ZSB1bnBpbiB3YXJuaW5n
LgoKdjI6IEZvciBzdXNwZW5kLCBzdGlsbCBuZWVkIHRvIGRvIHVucGluCgpTaWduZWQtb2ZmLWJ5
OiBFbWlseSBEZW5nIDxFbWlseS5EZW5nQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ2Z4X3Y5XzAuYyB8IDMgKystCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ2Z4X3Y5XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMKaW5k
ZXggNWViNzBlOC4uNWIxZmY0OCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ2Z4X3Y5XzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5j
CkBAIC0zMzk1LDcgKzMzOTUsOCBAQCBzdGF0aWMgaW50IGdmeF92OV8wX2h3X2Zpbmkodm9pZCAq
aGFuZGxlKQogCWdmeF92OV8wX2NwX2VuYWJsZShhZGV2LCBmYWxzZSk7CiAJYWRldi0+Z2Z4LnJs
Yy5mdW5jcy0+c3RvcChhZGV2KTsKIAotCWdmeF92OV8wX2NzYl92cmFtX3VucGluKGFkZXYpOwor
CWlmIChhZGV2LT5pbl9zdXNwZW5kKQorCQlnZnhfdjlfMF9jc2JfdnJhbV91bnBpbihhZGV2KTsK
IAogCXJldHVybiAwOwogfQotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeA==
