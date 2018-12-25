From: Emily Deng <Emily.Deng-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] Revert "drm/amdgpu: WARN once if amdgpu_bo_unpin is called
 for an unpinned BO"
Date: Tue, 25 Dec 2018 13:47:20 +0800
Message-ID: <1545716840-22778-1-git-send-email-Emily.Deng@amd.com>
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
Cc: Emily Deng <Emily.Deng-5C7GfCeVMHo@public.gmane.org>

VGhpcyByZXZlcnRzIGNvbW1pdCA4ODcwZmY3ZmU0MzlhYTlkN2E1NDI1NzljNDUwOGVhNTBjMGY1
YjZlLgoKU2lnbmVkLW9mZi1ieTogRW1pbHkgRGVuZyA8RW1pbHkuRGVuZ0BhbWQuY29tPgotLS0K
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYyB8IDIgKy0KIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYwppbmRleCA1MmZjNmJhLi45NTllMjQ0IDEwMDY0
NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCkBAIC05NDksNyArOTQ5
LDcgQEAgaW50IGFtZGdwdV9ib191bnBpbihzdHJ1Y3QgYW1kZ3B1X2JvICpibykKIAlzdHJ1Y3Qg
dHRtX29wZXJhdGlvbl9jdHggY3R4ID0geyBmYWxzZSwgZmFsc2UgfTsKIAlpbnQgciwgaTsKIAot
CWlmIChXQVJOX09OX09OQ0UoIWJvLT5waW5fY291bnQpKSB7CisJaWYgKCFiby0+cGluX2NvdW50
KSB7CiAJCWRldl93YXJuKGFkZXYtPmRldiwgIiVwIHVucGluIG5vdCBuZWNlc3NhcnlcbiIsIGJv
KTsKIAkJcmV0dXJuIDA7CiAJfQotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
