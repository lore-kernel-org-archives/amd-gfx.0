From: Le Ma <le.ma-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 10/10] drm/amdgpu: reduce redundant uvd context lost warning
 message
Date: Wed, 27 Nov 2019 17:15:29 +0800
Message-ID: <1574846129-4826-9-git-send-email-le.ma@amd.com>
References: <1574846129-4826-1-git-send-email-le.ma@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1574846129-4826-1-git-send-email-le.ma-5C7GfCeVMHo@public.gmane.org>
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
Cc: guchun.chen-5C7GfCeVMHo@public.gmane.org, tao.zhou1-5C7GfCeVMHo@public.gmane.org, Le Ma <le.ma-5C7GfCeVMHo@public.gmane.org>, alexander.deucher-5C7GfCeVMHo@public.gmane.org, dennis.li-5C7GfCeVMHo@public.gmane.org, hawking.zhang-5C7GfCeVMHo@public.gmane.org

TW92ZSB0aGUgcHJpbnQgb3V0IG9mIHV2ZCBpbnN0YW5jZSBsb29wIGluIGFtZGdwdV91dmRfc3Vz
cGVuZAoKQ2hhbmdlLUlkOiBJZmFkOTk3ZGViZDg0NzYzZTFiNTVkNjY4ZTE0NGI3Mjk1OThmMTE1
ZQpTaWduZWQtb2ZmLWJ5OiBMZSBNYSA8bGUubWFAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdXZkLmMgfCA1ICsrKystCiAxIGZpbGUgY2hhbmdlZCwgNCBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3V2ZC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3V2ZC5jCmluZGV4IGUzMjRiZmUuLmFjN2M3Nzk1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXZkLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3V2ZC5jCkBAIC0zNzcsMTIgKzM3NywxNSBAQCBpbnQgYW1kZ3B1X3V2ZF9z
dXNwZW5kKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCiAJCS8qIHJlLXdyaXRlIDAgc2lu
Y2UgZXJyX2V2ZW50X2F0aHViIHdpbGwgY29ycnVwdCBWQ1BVIGJ1ZmZlciAqLwogCQlpZiAoYW1k
Z3B1X3Jhc19pbnRyX3RyaWdnZXJlZCgpKSB7Ci0JCQlEUk1fV0FSTigiVVZEIFZDUFUgc3RhdGUg
bWF5IGxvc3QgZHVlIHRvIFJBUyBFUlJFVkVOVF9BVEhVQl9JTlRFUlJVUFRcbiIpOwogCQkJbWVt
c2V0KGFkZXYtPnV2ZC5pbnN0W2pdLnNhdmVkX2JvLCAwLCBzaXplKTsKIAkJfSBlbHNlIHsKIAkJ
CW1lbWNweV9mcm9taW8oYWRldi0+dXZkLmluc3Rbal0uc2F2ZWRfYm8sIHB0ciwgc2l6ZSk7CiAJ
CX0KIAl9CisKKwlpZiAoYW1kZ3B1X3Jhc19pbnRyX3RyaWdnZXJlZCgpKSB7CisJCURSTV9XQVJO
KCJVVkQgVkNQVSBzdGF0ZSBtYXkgbG9zdCBkdWUgdG8gUkFTIEVSUkVWRU5UX0FUSFVCX0lOVEVS
UlVQVFxuIik7CisKIAlyZXR1cm4gMDsKIH0KIAotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
