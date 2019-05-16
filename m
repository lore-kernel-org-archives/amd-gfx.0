From: Yintian Tao <yttao-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: don't read DF register for SRIOV
Date: Thu, 16 May 2019 20:10:51 +0800
Message-ID: <1558008651-21099-1-git-send-email-yttao@amd.com>
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
Cc: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, Yintian Tao <yttao-5C7GfCeVMHo@public.gmane.org>

VW5kZXIgU1JJT1YsIHJlYWRpbmcgREYgcmVnaXN0ZXIgaGFzIGNoYW5jZSB0byBsZWFkIHRvCkFF
UiBlcnJvciBpbiBob3N0IHNpZGUsIGp1c3Qgc2tpcCByZWFkaW5nIGl0LgoKU2lnbmVkLW9mZi1i
eTogTW9uayBMaXUgPE1vbmsuTGl1QGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IFlpbnRpYW4gVGFv
IDx5dHRhb0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8w
LmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYwppbmRleCBhNDE3NzYzLi5iNWJmOWVk
IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMKQEAgLTgzNyw3ICs4MzcsNyBA
QCBzdGF0aWMgaW50IGdtY192OV8wX21jX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYp
CiAKIAlpZiAoYW1kZ3B1X2VtdV9tb2RlICE9IDEpCiAJCWFkZXYtPmdtYy52cmFtX3dpZHRoID0g
YW1kZ3B1X2F0b21maXJtd2FyZV9nZXRfdnJhbV93aWR0aChhZGV2KTsKLQlpZiAoIWFkZXYtPmdt
Yy52cmFtX3dpZHRoKSB7CisJaWYgKCFhZGV2LT5nbWMudnJhbV93aWR0aCAmJiAhYW1kZ3B1X3Ny
aW92X3ZmKGFkZXYpKSB7CiAJCS8qIGhibSBtZW1vcnkgY2hhbm5lbCBzaXplICovCiAJCWlmIChh
ZGV2LT5mbGFncyAmIEFNRF9JU19BUFUpCiAJCQljaGFuc2l6ZSA9IDY0OwotLSAKMi43LjQKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
