From: Emily Deng <Emily.Deng-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: Fix null pointer amdgpu_device_fw_loading
Date: Thu, 18 Oct 2018 14:27:18 +0800
Message-ID: <1539844038-5496-1-git-send-email-Emily.Deng@amd.com>
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

TmVlZCB0byBjaGVjayBhZGV2LT5wb3dlcnBsYXkucHBfZnVuY3MuCgpTaWduZWQtb2ZmLWJ5OiBF
bWlseSBEZW5nIDxFbWlseS5EZW5nQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2RldmljZS5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rl
dmljZS5jCmluZGV4IDYxOGQ5ZTUuLmUyNmRmYzkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZGV2aWNlLmMKQEAgLTE2NTEsNyArMTY1MSw3IEBAIHN0YXRpYyBpbnQgYW1k
Z3B1X2RldmljZV9md19sb2FkaW5nKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCQl9CiAJ
fQogCi0JaWYgKGFkZXYtPnBvd2VycGxheS5wcF9mdW5jcy0+bG9hZF9maXJtd2FyZSkgeworCWlm
IChhZGV2LT5wb3dlcnBsYXkucHBfZnVuY3MgJiYgYWRldi0+cG93ZXJwbGF5LnBwX2Z1bmNzLT5s
b2FkX2Zpcm13YXJlKSB7CiAJCXIgPSBhZGV2LT5wb3dlcnBsYXkucHBfZnVuY3MtPmxvYWRfZmly
bXdhcmUoYWRldi0+cG93ZXJwbGF5LnBwX2hhbmRsZSk7CiAJCWlmIChyKSB7CiAJCQlwcl9lcnIo
ImZpcm13YXJlIGxvYWRpbmcgZmFpbGVkXG4iKTsKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
