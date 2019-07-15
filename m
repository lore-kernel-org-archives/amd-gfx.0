From: <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 82/87] drm/amd/display: Add SMU version field to
 clk_mgr_internal
Date: Mon, 15 Jul 2019 17:20:44 -0400
Message-ID: <20190715212049.4584-83-sunpeng.li@amd.com>
References: <20190715212049.4584-1-sunpeng.li@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190715212049.4584-1-sunpeng.li-5C7GfCeVMHo@public.gmane.org>
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
Cc: Leo Li <sunpeng.li-5C7GfCeVMHo@public.gmane.org>, Yongqiang Sun <yongqiang.sun-5C7GfCeVMHo@public.gmane.org>, Fatemeh Darbehani <fatemeh.darbehani-5C7GfCeVMHo@public.gmane.org>

RnJvbTogRmF0ZW1laCBEYXJiZWhhbmkgPGZhdGVtZWguZGFyYmVoYW5pQGFtZC5jb20+CgpGb3Ig
c29tZSBwbGF0Zm9ybXMsIHdlIG5lZWQgdG8ga25vdyBTTVUgdmVyc2lvbiBmb3IgZHJpdmVyL1NN
VQpjb21wYXRpYmlsaXR5LiBUaGlzIGNoYW5nZSBhZGRzIHRoYXQgZmllbGQuCgpDaGFuZ2UtSWQ6
IEkyNTg2MTYxZmI2NDViZjBkMTZkMzBjOTE5NTRhODcxZjgzZTg3ZWRmClNpZ25lZC1vZmYtYnk6
IEZhdGVtZWggRGFyYmVoYW5pIDxmYXRlbWVoLmRhcmJlaGFuaUBhbWQuY29tPgpSZXZpZXdlZC1i
eTogWW9uZ3FpYW5nIFN1biA8eW9uZ3FpYW5nLnN1bkBhbWQuY29tPgpBY2tlZC1ieTogTGVvIExp
IDxzdW5wZW5nLmxpQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2luYy9ody9jbGtfbWdyX2ludGVybmFsLmggfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9pbmMv
aHcvY2xrX21ncl9pbnRlcm5hbC5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2lu
Yy9ody9jbGtfbWdyX2ludGVybmFsLmgKaW5kZXggM2MxMDUxMjRkY2RkLi40YjU1MDVmYTk4MGMg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9pbmMvaHcvY2xrX21n
cl9pbnRlcm5hbC5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9pbmMvaHcv
Y2xrX21ncl9pbnRlcm5hbC5oCkBAIC0xOTEsNiArMTkxLDcgQEAgc3RydWN0IHN0YXRlX2RlcGVu
ZGVudF9jbG9ja3MgewogCiBzdHJ1Y3QgY2xrX21ncl9pbnRlcm5hbCB7CiAJc3RydWN0IGNsa19t
Z3IgYmFzZTsKKwlpbnQgc211X3ZlcjsKIAlzdHJ1Y3QgcHBfc211X2Z1bmNzICpwcF9zbXU7CiAJ
c3RydWN0IGNsa19tZ3JfaW50ZXJuYWxfZnVuY3MgKmZ1bmNzOwogCi0tIAoyLjIyLjAKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
