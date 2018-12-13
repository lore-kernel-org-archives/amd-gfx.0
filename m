From: Xiangliang Yu <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/2] drm/amdgpu/psp: Fix to get wrong xgmi session id
Date: Thu, 13 Dec 2018 15:41:19 +0800
Message-ID: <1544686879-32537-1-git-send-email-Xiangliang.Yu@amd.com>
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
Cc: Xiangliang Yu <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>

eEdNSSBzZXNzaW9uIGlkIHNob3VsZCBnZXQgZnJvbSByZXNwb25zZSBidWZmZXIsIGNvcnJlY3Qg
aXQuCgpTaWduZWQtb2ZmLWJ5OiBYaWFuZ2xpYW5nIFl1IDxYaWFuZ2xpYW5nLll1QGFtZC5jb20+
Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jIHwgMyArKysKIDEg
ZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfcHNwLmMKaW5kZXggOGZhYjBkNi4uMmYxMjZlYTcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfcHNwLmMKQEAgLTE0Nyw2ICsxNDcsOSBAQCBwc3BfY21kX3N1Ym1pdF9i
dWYoc3RydWN0IHBzcF9jb250ZXh0ICpwc3AsCiAJCXJldHVybiAtRUlOVkFMOwogCX0KIAorCS8q
IGdldCB4R01JIHNlc3Npb24gaWQgZnJvbSByZXNwb25zZSBidWZmZXIgKi8KKwljbWQtPnJlc3Au
c2Vzc2lvbl9pZCA9IHBzcC0+Y21kX2J1Zl9tZW0tPnJlc3Auc2Vzc2lvbl9pZDsKKwogCWlmICh1
Y29kZSkgewogCQl1Y29kZS0+dG1yX21jX2FkZHJfbG8gPSBwc3AtPmNtZF9idWZfbWVtLT5yZXNw
LmZ3X2FkZHJfbG87CiAJCXVjb2RlLT50bXJfbWNfYWRkcl9oaSA9IHBzcC0+Y21kX2J1Zl9tZW0t
PnJlc3AuZndfYWRkcl9oaTsKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
