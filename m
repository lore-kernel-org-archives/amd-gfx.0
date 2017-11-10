From: Roger He <Hongbo.He-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amd/amdgpu: if visible VRAM allocation fail,
 fall back to invisible try again
Date: Fri, 10 Nov 2017 20:17:33 +0800
Message-ID: <1510316253-2874-1-git-send-email-Hongbo.He@amd.com>
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
Cc: Roger He <Hongbo.He-5C7GfCeVMHo@public.gmane.org>, Christian.Koenig-5C7GfCeVMHo@public.gmane.org

Q2hhbmdlLUlkOiBJYjMwZWZhNWYwMDdmY2UxMmE4NWE2NjcyMmE4YzlmNzY0OTZmMmRlYwpTaWdu
ZWQtb2ZmLWJ5OiBSb2dlciBIZSA8SG9uZ2JvLkhlQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jIHwgNSArKysrKwogMSBmaWxlIGNoYW5nZWQsIDUg
aW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9nZW0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYwppbmRl
eCBmYjcyZWRjLi5hMWVhYWJiIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZ2VtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dl
bS5jCkBAIC02Myw2ICs2MywxMSBAQCBpbnQgYW1kZ3B1X2dlbV9vYmplY3RfY3JlYXRlKHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2LCB1bnNpZ25lZCBsb25nIHNpemUsCiAJCQkgICAgIGZsYWdz
LCBOVUxMLCByZXN2LCAwLCAmYm8pOwogCWlmIChyKSB7CiAJCWlmIChyICE9IC1FUkVTVEFSVFNZ
UykgeworCQkJaWYgKGZsYWdzICYgQU1ER1BVX0dFTV9DUkVBVEVfQ1BVX0FDQ0VTU19SRVFVSVJF
RCkgeworCQkJCWZsYWdzICY9IH5BTURHUFVfR0VNX0NSRUFURV9DUFVfQUNDRVNTX1JFUVVJUkVE
OworCQkJCWdvdG8gcmV0cnk7CisJCQl9CisKIAkJCWlmIChpbml0aWFsX2RvbWFpbiA9PSBBTURH
UFVfR0VNX0RPTUFJTl9WUkFNKSB7CiAJCQkJaW5pdGlhbF9kb21haW4gfD0gQU1ER1BVX0dFTV9E
T01BSU5fR1RUOwogCQkJCWdvdG8gcmV0cnk7Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
