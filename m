From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH libdrm] amdgpu: fix high VA mask
Date: Mon, 22 Jan 2018 13:18:37 +0100
Message-ID: <20180122121837.1266-1-christian.koenig@amd.com>
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

VGhhdCBjb25zdGFudCBuZWVkcyB0byBiZSA2NGJpdHMuCgpGaXhlczogYW1kZ3B1OiB1c2UgdGhl
IGhpZ2ggVkEgcmFuZ2UgaWYgcG9zc2libGUgdjIKClNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBL
w7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KLS0tCiBhbWRncHUvYW1kZ3B1X2Rldmlj
ZS5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
CgpkaWZmIC0tZ2l0IGEvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyBiL2FtZGdwdS9hbWRncHVfZGV2
aWNlLmMKaW5kZXggYTBkMDE3MjcuLmYzNGUyN2E5IDEwMDY0NAotLS0gYS9hbWRncHUvYW1kZ3B1
X2RldmljZS5jCisrKyBiL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKQEAgLTI3Miw3ICsyNzIsNyBA
QCBpbnQgYW1kZ3B1X2RldmljZV9pbml0aWFsaXplKGludCBmZCwKIAkJbWF4ID0gZGV2LT5kZXZf
aW5mby52aXJ0dWFsX2FkZHJlc3NfbWF4OwogCX0KIAotCW1heCA9IE1JTjIobWF4LCAoc3RhcnQg
JiB+MHhmZmZmZmZmZikgKyAweDEwMDAwMDAwMFVMTCk7CisJbWF4ID0gTUlOMihtYXgsIChzdGFy
dCAmIH4weGZmZmZmZmZmVUxMKSArIDB4MTAwMDAwMDAwVUxMKTsKIAlhbWRncHVfdmFtZ3JfaW5p
dCgmZGV2LT52YW1ncl8zMiwgc3RhcnQsIG1heCwKIAkJCSAgZGV2LT5kZXZfaW5mby52aXJ0dWFs
X2FkZHJlc3NfYWxpZ25tZW50KTsKIAotLSAKMi4xNC4xCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
