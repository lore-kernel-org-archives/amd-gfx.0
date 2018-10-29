From: Samuel Pitoiset <samuel.pitoiset-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] drm/amdgpu: print an error when the parser can't be
 initialized
Date: Mon, 29 Oct 2018 12:23:06 +0100
Message-ID: <20181029112306.1709-1-samuel.pitoiset@gmail.com>
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
Cc: Samuel Pitoiset <samuel.pitoiset-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

U2ltaWxhciB0byBvdGhlciBlcnJvciBtZXNzYWdlcywgbWlnaHQgaGVscCBmb3IgdHJhY2tpbmcg
ZG93bgppc3N1ZXMuCgpTaWduZWQtb2ZmLWJ5OiBTYW11ZWwgUGl0b2lzZXQgPHNhbXVlbC5waXRv
aXNldEBnbWFpbC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Nz
LmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jCmluZGV4IDg4MzYxODZlYjVlZi4u
YzhhYTljYzBiZWQ4IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfY3MuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYwpAQCAt
MTI4NSw3ICsxMjg1LDcgQEAgaW50IGFtZGdwdV9jc19pb2N0bChzdHJ1Y3QgZHJtX2RldmljZSAq
ZGV2LCB2b2lkICpkYXRhLCBzdHJ1Y3QgZHJtX2ZpbGUgKmZpbHApCiAKIAlyID0gYW1kZ3B1X2Nz
X3BhcnNlcl9pbml0KCZwYXJzZXIsIGRhdGEpOwogCWlmIChyKSB7Ci0JCURSTV9FUlJPUigiRmFp
bGVkIHRvIGluaXRpYWxpemUgcGFyc2VyICFcbiIpOworCQlEUk1fRVJST1IoIkZhaWxlZCB0byBp
bml0aWFsaXplIHBhcnNlciAlZCFcbiIsIHIpOwogCQlnb3RvIG91dDsKIAl9CiAKLS0gCjIuMTku
MQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
