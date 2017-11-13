From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH libdrm 1/3] amdgpu: fix 32bit VA manager max address
Date: Mon, 13 Nov 2017 14:27:46 +0100
Message-ID: <20171113132748.16298-1-christian.koenig@amd.com>
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

VGhlIHJhbmdlIGlzIGV4Y2x1c2l2ZSBub3QgaW5jbHVzaXZlLgoKU2lnbmVkLW9mZi1ieTogQ2hy
aXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgotLS0KIGFtZGdwdS9hbWRn
cHVfZGV2aWNlLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVs
ZXRpb24oLSkKCmRpZmYgLS1naXQgYS9hbWRncHUvYW1kZ3B1X2RldmljZS5jIGIvYW1kZ3B1L2Ft
ZGdwdV9kZXZpY2UuYwppbmRleCAzNDRlODdlZC4uZmE0YWIwZTcgMTAwNjQ0Ci0tLSBhL2FtZGdw
dS9hbWRncHVfZGV2aWNlLmMKKysrIGIvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwpAQCAtMjcxLDcg
KzI3MSw3IEBAIGludCBhbWRncHVfZGV2aWNlX2luaXRpYWxpemUoaW50IGZkLAogCX0KIAogCXN0
YXJ0ID0gZGV2LT5kZXZfaW5mby52aXJ0dWFsX2FkZHJlc3Nfb2Zmc2V0OwotCW1heCA9IE1JTjIo
ZGV2LT5kZXZfaW5mby52aXJ0dWFsX2FkZHJlc3NfbWF4LCAweGZmZmZmZmZmKTsKKwltYXggPSBN
SU4yKGRldi0+ZGV2X2luZm8udmlydHVhbF9hZGRyZXNzX21heCwgMHgxMDAwMDAwMDBVTEwpOwog
CWFtZGdwdV92YW1ncl9pbml0KCZkZXYtPnZhbWdyXzMyLCBzdGFydCwgbWF4LAogCQkJICBkZXYt
PmRldl9pbmZvLnZpcnR1YWxfYWRkcmVzc19hbGlnbm1lbnQpOwogCi0tIAoyLjExLjAKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
