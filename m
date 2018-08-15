From: Emily Deng <Emily.Deng-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: MC_VM_FB_OFFSET is pf only register.
Date: Wed, 15 Aug 2018 17:48:28 +0800
Message-ID: <1534326508-17477-2-git-send-email-Emily.Deng@amd.com>
References: <1534326508-17477-1-git-send-email-Emily.Deng@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1534326508-17477-1-git-send-email-Emily.Deng-5C7GfCeVMHo@public.gmane.org>
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

U2lnbmVkLW9mZi1ieTogRW1pbHkgRGVuZyA8RW1pbHkuRGVuZ0BhbWQuY29tPgotLS0KIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMgfCA1ICsrKystCiAxIGZpbGUgY2hhbmdl
ZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2dtY192OV8wLmMKaW5kZXggYjYwZWQyOC4uNTJiMTNlNiAxMDA2NDQKLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nbWNfdjlfMC5jCkBAIC02OTMsNyArNjkzLDEwIEBAIHN0YXRpYyB2b2lkIGdtY192OV8w
X3ZyYW1fZ3R0X2xvY2F0aW9uKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCWFtZGdwdV9k
ZXZpY2VfdnJhbV9sb2NhdGlvbihhZGV2LCAmYWRldi0+Z21jLCBiYXNlKTsKIAlhbWRncHVfZGV2
aWNlX2dhcnRfbG9jYXRpb24oYWRldiwgbWMpOwogCS8qIGJhc2Ugb2Zmc2V0IG9mIHZyYW0gcGFn
ZXMgKi8KLQlhZGV2LT52bV9tYW5hZ2VyLnZyYW1fYmFzZV9vZmZzZXQgPSBnZnhodWJfdjFfMF9n
ZXRfbWNfZmJfb2Zmc2V0KGFkZXYpOworCWlmICghYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKQorCQlh
ZGV2LT52bV9tYW5hZ2VyLnZyYW1fYmFzZV9vZmZzZXQgPSBnZnhodWJfdjFfMF9nZXRfbWNfZmJf
b2Zmc2V0KGFkZXYpOworCWVsc2UKKwkJYWRldi0+dm1fbWFuYWdlci52cmFtX2Jhc2Vfb2Zmc2V0
ID0gMDsKIH0KIAogLyoqCi0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
