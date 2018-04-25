From: Emily Deng <Emily.Deng-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/2] drm/amdgpu/sriov: Need to set in_gpu_reset flag to back
 after gpu reset
Date: Wed, 25 Apr 2018 14:38:13 +0800
Message-ID: <1524638293-31882-1-git-send-email-Emily.Deng@amd.com>
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

QWZ0ZXIgaG9zdCBvcyByZXNldCBncHUgcmVzZXQsIG5lZWQgdG8gc2V0IGZsYWcgaW5fZ3B1X3Jl
c2V0IHRvCnplcm8uCgpTaWduZWQtb2ZmLWJ5OiBFbWlseSBEZW5nIDxFbWlseS5EZW5nQGFtZC5j
b20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbXhncHVfYWkuYyB8IDQgKysrLQog
MSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L214Z3B1X2FpLmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9teGdwdV9haS5jCmluZGV4IDQ5MzM0ODYuLjA3OGY3MGYgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L214Z3B1X2FpLmMKKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvbXhncHVfYWkuYwpAQCAtMjYwLDggKzI2MCwxMCBAQCBzdGF0aWMg
dm9pZCB4Z3B1X2FpX21haWxib3hfZmxyX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQog
CX0gd2hpbGUgKHRpbWVvdXQgPiAxKTsKIAogZmxyX2RvbmU6Ci0JaWYgKGxvY2tlZCkKKwlpZiAo
bG9ja2VkKSB7CisJCWFkZXYtPmluX2dwdV9yZXNldCA9IDA7CiAJCW11dGV4X3VubG9jaygmYWRl
di0+bG9ja19yZXNldCk7CisJfQogCiAJLyogVHJpZ2dlciByZWNvdmVyeSBmb3Igd29ybGQgc3dp
dGNoIGZhaWx1cmUgaWYgbm8gVERSICovCiAJaWYgKGFtZGdwdV9sb2NrdXBfdGltZW91dCA9PSAw
KQotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
