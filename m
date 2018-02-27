From: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/6] drm/amdgpu: block till late_init_work done in dev_fini
Date: Tue, 27 Feb 2018 16:47:11 +0800
Message-ID: <1519721235-28552-3-git-send-email-Monk.Liu@amd.com>
References: <1519721235-28552-1-git-send-email-Monk.Liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1519721235-28552-1-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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

b3RoZXJ3aXNlIHBhZ2UgZmF1bHQgaGl0IGluIHRoZSB3b3JrIGlmIGRyaXZlcgpmaW5pc2hlZCB0
b28gcXVpY2sKCkNoYW5nZS1JZDogSTRmZDQ3Y2NkODM2NDQxYjFiM2Y0MjZkZWM1ZDM2NGQ5ZGYw
MmUyM2QKU2lnbmVkLW9mZi1ieTogTW9uayBMaXUgPE1vbmsuTGl1QGFtZC5jb20+Ci0tLQogZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIHwgNCArKystCiAxIGZpbGUg
Y2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCmluZGV4IDc1ZDE3MzMuLjMyNTFmODEgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYworKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKQEAgLTIwODksNyArMjA4
OSw5IEBAIHZvaWQgYW1kZ3B1X2RldmljZV9maW5pKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
KQogCQlhZGV2LT5maXJtd2FyZS5ncHVfaW5mb19mdyA9IE5VTEw7CiAJfQogCWFkZXYtPmFjY2Vs
X3dvcmtpbmcgPSBmYWxzZTsKLQljYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoJmFkZXYtPmxhdGVf
aW5pdF93b3JrKTsKKworCXdoaWxlIChjYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoJmFkZXYtPmxh
dGVfaW5pdF93b3JrKSkKKwkJbXNsZWVwKDEpOwogCS8qIGZyZWUgaTJjIGJ1c2VzICovCiAJaWYg
KCFhbWRncHVfZGV2aWNlX2hhc19kY19zdXBwb3J0KGFkZXYpKQogCQlhbWRncHVfaTJjX2Zpbmko
YWRldik7Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
