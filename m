From: Shaoyun Liu <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: Avoid get vram info from atom bios on emulation
 mode
Date: Tue,  6 Feb 2018 17:31:26 -0500
Message-ID: <1517956286-29399-1-git-send-email-Shaoyun.Liu@amd.com>
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
Cc: Shaoyun Liu <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJMTAwMzBlODNkNjNiMmMyN2JmZDE2YjY0MTc4ZTRmMDdjMTNhZGRmYQpTaWdu
ZWQtb2ZmLWJ5OiBTaGFveXVuIExpdSA8U2hhb3l1bi5MaXVAYW1kLmNvbT4KLS0tCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jIHwgMyArKy0KIDEgZmlsZSBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21j
X3Y5XzAuYwppbmRleCAwYTE4NjhiLi43ODVmYjc4IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2dtY192OV8wLmMKQEAgLTcwNyw3ICs3MDcsOCBAQCBzdGF0aWMgaW50IGdtY192OV8wX21jX2lu
aXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJaW50IGNoYW5zaXplLCBudW1jaGFuOwog
CWludCByOwogCi0JYWRldi0+Z21jLnZyYW1fd2lkdGggPSBhbWRncHVfYXRvbWZpcm13YXJlX2dl
dF92cmFtX3dpZHRoKGFkZXYpOworCWlmIChhbWRncHVfZW11X21vZGUgIT0gMSkKKwkJYWRldi0+
Z21jLnZyYW1fd2lkdGggPSBhbWRncHVfYXRvbWZpcm13YXJlX2dldF92cmFtX3dpZHRoKGFkZXYp
OwogCWlmICghYWRldi0+Z21jLnZyYW1fd2lkdGgpIHsKIAkJLyogaGJtIG1lbW9yeSBjaGFubmVs
IHNpemUgKi8KIAkJY2hhbnNpemUgPSAxMjg7Ci0tIAoxLjkuMQoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
