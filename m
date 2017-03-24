From: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 12/18] drm/amdgpu: block size of multiple level vmpt prefers
 one page
Date: Fri, 24 Mar 2017 11:16:51 +0800
Message-ID: <1490325417-26745-13-git-send-email-David1.Zhou@amd.com>
References: <1490325417-26745-1-git-send-email-David1.Zhou@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1490325417-26745-1-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Christian.Koenig-5C7GfCeVMHo@public.gmane.org, Alexander.Deucher-5C7GfCeVMHo@public.gmane.org
Cc: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>

bXVsdGlwbGUgbGV2ZWwgdm1wdCB3aWxsIGNvdmVyIGJpZ2dlciB2YSBzcGFjZSwgaWYgdm1wdCBp
cyA0IGxldmVscywKb25lIGhpZ2hlc3QgcGRlIHdpbGwgY292ZXIgMVRCLCBzbyBpbmNyZWFzZSB2
bSBzaXplIHRvIDFUQi4KCkNoYW5nZS1JZDogSWVhZjg0NGE4YjM2NDg5MmE1YTNmM2U0M2UxNjkw
Yjk1NzliNDBiODUKU2lnbmVkLW9mZi1ieTogQ2h1bm1pbmcgWmhvdSA8RGF2aWQxLlpob3VAYW1k
LmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMgfCA0ICsr
LS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jCmluZGV4IGQ3NGE0MDYuLmY3N2IwZWUg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYworKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMKQEAgLTgyLDggKzgyLDgg
QEAKIHVuc2lnbmVkIGFtZGdwdV9pcF9ibG9ja19tYXNrID0gMHhmZmZmZmZmZjsKIGludCBhbWRn
cHVfYmFwbSA9IC0xOwogaW50IGFtZGdwdV9kZWVwX2NvbG9yID0gMDsKLWludCBhbWRncHVfdm1f
c2l6ZSA9IDY0OwotaW50IGFtZGdwdV92bV9ibG9ja19zaXplID0gLTE7CitpbnQgYW1kZ3B1X3Zt
X3NpemUgPSAxMDI0OworaW50IGFtZGdwdV92bV9ibG9ja19zaXplID0gOTsKIGludCBhbWRncHVf
dm1fZmF1bHRfc3RvcCA9IDA7CiBpbnQgYW1kZ3B1X3ZtX2RlYnVnID0gMDsKIGludCBhbWRncHVf
dnJhbV9wYWdlX3NwbGl0ID0gMTAyNDsKLS0gCjEuOS4xCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
