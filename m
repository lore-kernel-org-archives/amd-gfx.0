From: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: Reverse the sequence of ctx_mgr_fini and vm_fini
 in amdgpu_driver_postclose_kms
Date: Mon, 22 Oct 2018 17:47:14 +0800
Message-ID: <1540201634-4291-1-git-send-email-Rex.Zhu@amd.com>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Emily.Deng-5C7GfCeVMHo@public.gmane.org
Cc: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

Y3NhIGJ1ZmZlciB3aWxsIGJlIGNyZWF0ZWQgcGVyIGN0eCwgd2hlbiBjdHggZmluaSwKdGhlIGNz
YSBidWZmZXIgYW5kIHZhIHdpbGwgYmUgcmVsZWFzZWQuIHNvIG5lZWQgdG8KZG8gY3R4X21nciBm
aW4gYmVmb3JlIHZtIGZpbmkuCgpTaWduZWQtb2ZmLWJ5OiBSZXggWmh1IDxSZXguWmh1QGFtZC5j
b20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jIHwgMiArLQog
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jCmluZGV4IDI3ZGU4NDguLmYyZWY5YTEgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMuYworKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMKQEAgLTEwNTQsOCArMTA1NCw4IEBA
IHZvaWQgYW1kZ3B1X2RyaXZlcl9wb3N0Y2xvc2Vfa21zKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYs
CiAJcGFzaWQgPSBmcHJpdi0+dm0ucGFzaWQ7CiAJcGQgPSBhbWRncHVfYm9fcmVmKGZwcml2LT52
bS5yb290LmJhc2UuYm8pOwogCi0JYW1kZ3B1X3ZtX2ZpbmkoYWRldiwgJmZwcml2LT52bSk7CiAJ
YW1kZ3B1X2N0eF9tZ3JfZmluaSgmZnByaXYtPmN0eF9tZ3IpOworCWFtZGdwdV92bV9maW5pKGFk
ZXYsICZmcHJpdi0+dm0pOwogCiAJaWYgKHBhc2lkKQogCQlhbWRncHVfcGFzaWRfZnJlZV9kZWxh
eWVkKHBkLT50Ym8ucmVzdiwgcGFzaWQpOwotLSAKMS45LjEKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
