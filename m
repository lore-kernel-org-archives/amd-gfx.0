From: "Yuan, Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: remove special autoload handling for navi12
Date: Thu, 15 Aug 2019 08:43:41 +0000
Message-ID: <20190815084320.20015-1-xiaojie.yuan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Language: en-US
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Xiao, Jack" <Jack.Xiao-5C7GfCeVMHo@public.gmane.org>, "Yuan, Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>, "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

cy9yIGxpc3QgaW4gcmxjIGZpcm13YXJlIGlzIHJlYWR5LCBzbyByZW1vdmUgdGhlIHNwZWNpYWwg
YXV0b2xvYWQgaGFuZGxpbmcKClNpZ25lZC1vZmYtYnk6IFhpYW9qaWUgWXVhbiA8eGlhb2ppZS55
dWFuQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5j
IHwgMyArLS0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMKaW5kZXggYWFhNGNkZjhiY2Fl
Li40YjJkMmZkNzJkYzYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9wc3AuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMK
QEAgLTEwMzMsOCArMTAzMyw3IEBAIHN0YXRpYyBpbnQgcHNwX25wX2Z3X2xvYWQoc3RydWN0IHBz
cF9jb250ZXh0ICpwc3ApCiAJCQlyZXR1cm4gcmV0OwogCiAJCS8qIFN0YXJ0IHJsYyBhdXRvbG9h
ZCBhZnRlciBwc3AgcmVjaWV2ZWQgYWxsIHRoZSBnZnggZmlybXdhcmUgKi8KLQkJaWYgKHVjb2Rl
LT51Y29kZV9pZCA9PSBBTURHUFVfVUNPREVfSURfUkxDX1JFU1RPUkVfTElTVF9TUk1fTUVNIHx8
Ci0JCSAgICAoYWRldi0+YXNpY190eXBlID09IENISVBfTkFWSTEyICYmIHVjb2RlLT51Y29kZV9p
ZCA9PSBBTURHUFVfVUNPREVfSURfUkxDX0cpKSB7CisJCWlmICh1Y29kZS0+dWNvZGVfaWQgPT0g
QU1ER1BVX1VDT0RFX0lEX1JMQ19SRVNUT1JFX0xJU1RfU1JNX01FTSkgewogCQkJcmV0ID0gcHNw
X3JsY19hdXRvbG9hZChwc3ApOwogCQkJaWYgKHJldCkgewogCQkJCURSTV9FUlJPUigiRmFpbGVk
IHRvIHN0YXJ0IHJsYyBhdXRvbG9hZFxuIik7Ci0tIAoyLjIwLjEKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
