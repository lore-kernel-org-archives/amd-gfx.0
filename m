From: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 05/14] drm/amd/amdgpu: enable PG_EN bit in powergating UVD
Date: Thu, 28 Jul 2016 10:19:03 -0400
Message-ID: <20160728141912.18140-6-tom.stdenis@amd.com>
References: <20160728141912.18140-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20160728141912.18140-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>

RW5hYmxlIHRoZSBQR19FTiBiaXQganVzdCBiZWZvcmUgdGhlIFNNVSB3b3VsZCBiZSB0YXNrZWQK
d2l0aCB0aGUgUEcgdHJhbnNpdGlvbi4KClNpZ25lZC1vZmYtYnk6IFRvbSBTdCBEZW5pcyA8dG9t
LnN0ZGVuaXNAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRfdjZf
MC5jIHwgMiArKwogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3V2ZF92Nl8wLmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS91dmRfdjZfMC5jCmluZGV4IDdmMmI1ZGUyOWY2Ny4uMzkxNDU3ZjFlYWZkIDEw
MDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRfdjZfMC5jCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3V2ZF92Nl8wLmMKQEAgLTk5Nyw2ICs5OTcsOCBAQCBz
dGF0aWMgaW50IHV2ZF92Nl8wX3NldF9wb3dlcmdhdGluZ19zdGF0ZSh2b2lkICpoYW5kbGUsCiAJ
aWYgKCEoYWRldi0+cGdfZmxhZ3MgJiBBTURfUEdfU1VQUE9SVF9VVkQpKQogCQlyZXR1cm4gMDsK
IAorCVdSRUczMihtbVVWRF9QT1dFUl9TVEFUVVMsIFVWRF9QT1dFUl9TVEFUVVNfX1VWRF9QR19F
Tl9NQVNLKTsKKwogCWlmIChzdGF0ZSA9PSBBTURfUEdfU1RBVEVfR0FURSkgewogCQl1dmRfdjZf
MF9zdG9wKGFkZXYpOwogCQlyZXR1cm4gMDsKLS0gCjIuOS4yCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
