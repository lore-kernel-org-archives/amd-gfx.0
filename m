From: Shaoyun Liu <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: Double the timeout count on emulation mode
Date: Wed,  7 Feb 2018 14:53:19 -0500
Message-ID: <1518033199-29350-1-git-send-email-Shaoyun.Liu@amd.com>
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
Cc: Shaoyun Liu <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>

Q2hhbmdlLUlkOiBJZjczZDllNWYxZjJmOTk4ZDkyN2Y1MDZjYTRiN2E5NjFkYjM2ODcxNgpTaWdu
ZWQtb2ZmLWJ5OiBTaGFveXVuIExpdSA8U2hhb3l1bi5MaXVAYW1kLmNvbT4KLS0tCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgfCAyICsrCiAxIGZpbGUgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rl
dmljZS5jCmluZGV4IGY2ZWMzNmYuLjc5Njg5NDQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZGV2aWNlLmMKQEAgLTE4MTMsNiArMTgxMyw4IEBAIGludCBhbWRncHVfZGV2
aWNlX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJYWRldi0+ZmxhZ3MgPSBmbGFn
czsKIAlhZGV2LT5hc2ljX3R5cGUgPSBmbGFncyAmIEFNRF9BU0lDX01BU0s7CiAJYWRldi0+dXNl
Y190aW1lb3V0ID0gQU1ER1BVX01BWF9VU0VDX1RJTUVPVVQ7CisJaWYgKGFtZGdwdV9lbXVfbW9k
ZSA9PSAxKQorCQlhZGV2LT51c2VjX3RpbWVvdXQgKj0gMjsKIAlhZGV2LT5nbWMuZ2FydF9zaXpl
ID0gNTEyICogMTAyNCAqIDEwMjQ7CiAJYWRldi0+YWNjZWxfd29ya2luZyA9IGZhbHNlOwogCWFk
ZXYtPm51bV9yaW5ncyA9IDA7Ci0tIAoxLjkuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
