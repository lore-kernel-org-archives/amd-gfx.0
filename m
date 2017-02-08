From: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 06/11] drm/amdgpu:RUNTIME flag should clr later
Date: Wed, 8 Feb 2017 17:26:54 +0800
Message-ID: <1486546019-31045-6-git-send-email-Monk.Liu@amd.com>
References: <1486546019-31045-1-git-send-email-Monk.Liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1486546019-31045-1-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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
YW1kZ3B1L214Z3B1X3ZpLmMgfCA0ICstLS0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9teGdwdV92aS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbXhncHVfdmkuYwppbmRl
eCA1ZjE1NmQzLi45OGNiY2Q5IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9teGdwdV92aS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L214Z3B1X3ZpLmMK
QEAgLTUwNSw5ICs1MDUsNyBAQCBzdGF0aWMgdm9pZCB4Z3B1X3ZpX21haWxib3hfZmxyX3dvcmso
c3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQogCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0g
Y29udGFpbmVyX29mKHZpcnQsIHN0cnVjdCBhbWRncHVfZGV2aWNlLCB2aXJ0KTsKIAogCS8qIHdh
aXQgdW50aWwgUkNWX01TRyBiZWNvbWUgMyAqLwotCWlmICgheGdwdV92aV9wb2xsX21zZyhhZGV2
LCBJREhfRkxSX05PVElGSUNBVElPTl9DTVBMKSkKLQkJYWRldi0+dmlydC5jYXBzICY9IH5BTURH
UFVfU1JJT1ZfQ0FQU19SVU5USU1FOwotCWVsc2UgeworCWlmICh4Z3B1X3ZpX3BvbGxfbXNnKGFk
ZXYsIElESF9GTFJfTk9USUZJQ0FUSU9OX0NNUEwpKSB7CiAJCXByX2VycigiZmFpbGVkIHRvIHJl
Y2lldmUgRkxSX0NNUExcbiIpOwogCQlyZXR1cm47CiAJfQotLSAKMi43LjQKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
