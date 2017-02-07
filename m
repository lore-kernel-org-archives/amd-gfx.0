From: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 16/20] drm/amdgpu:RUNTIME flag should clr later
Date: Tue, 7 Feb 2017 14:11:14 +0800
Message-ID: <1486447878-20521-16-git-send-email-Monk.Liu@amd.com>
References: <1486447878-20521-1-git-send-email-Monk.Liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1486447878-20521-1-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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

dGhpcyBmbGFnIHdpbGwgZ2V0IGNsZWFyZWQgYnkgcmVxdWVzdCBncHUgYWNjZXNzCgpDaGFuZ2Ut
SWQ6IEllNDg0YmIwMTQxNDIwMDU1MzcwZTAxOWRjZDhjMTEwZmIzNGY4YTFiClNpZ25lZC1vZmYt
Ynk6IE1vbmsgTGl1IDxNb25rLkxpdUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L214Z3B1X3ZpLmMgfCA1ICsrLS0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L214Z3B1X3ZpLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9teGdwdV92aS5jCmlu
ZGV4IDUzZmE1OTBjLi42NGQyZmQwIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9teGdwdV92aS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L214Z3B1X3Zp
LmMKQEAgLTUwNyw5ICs1MDcsOCBAQCBzdGF0aWMgdm9pZCB4Z3B1X3ZpX21haWxib3hfZmxyX3dv
cmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQogCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
ID0gY29udGFpbmVyX29mKHZpcnQsIHN0cnVjdCBhbWRncHVfZGV2aWNlLCB2aXJ0KTsKIAogCS8q
IHdhaXQgdW50aWwgUkNWX01TRyBiZWNvbWUgMyAqLwotCWlmICgheGdwdV92aV9wb2xsX21zZyhh
ZGV2LCBJREhfRkxSX05PVElGSUNBVElPTl9DTVBMKSkKLQkJYWRldi0+dmlydC5jYXBzICY9IH5B
TURHUFVfU1JJT1ZfQ0FQU19SVU5USU1FOwotCWVsc2UgeworCWlmICh4Z3B1X3ZpX3BvbGxfbXNn
KGFkZXYsIElESF9GTFJfTk9USUZJQ0FUSU9OX0NNUEwpKQorCXsKIAkJcHJfZXJyKCJmYWlsZWQg
dG8gcmVjaWV2ZSBGTFJfQ01QTFxuIik7CiAJCXJldHVybjsKIAl9Ci0tIAoyLjcuNAoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
