From: Guchun Chen <guchun.chen-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: add check to avoid array bound issue
Date: Thu, 8 Aug 2019 14:59:04 +0800
Message-ID: <20190808065904.22438-1-guchun.chen@amd.com>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Hawking.Zhang-5C7GfCeVMHo@public.gmane.org, Dennis.Li-5C7GfCeVMHo@public.gmane.org, Xinhui.Pan-5C7GfCeVMHo@public.gmane.org, Tao.Zhou1-5C7GfCeVMHo@public.gmane.org
Cc: Guchun Chen <guchun.chen-5C7GfCeVMHo@public.gmane.org>

U3ViX2Jsb2NrX2luZGV4IGNhbiBiZSBwYXNzZWQgZnJvbSB1c2VyIGxldmVsLCBzbwphZGQgb25l
IGNoZWNrIGJlZm9yZSBhY2Nlc3NpbmcgdGhlIGFycmF5IGZpcnN0IHRvCnByZXZlbnQgYXJyYXkg
aW5kZXggb3V0IG9mIGJvdW5kIHByb2JsZW0uCgpDaGFuZ2UtSWQ6IEk1NTZmYzU2MGI0NDIxNTg0
OGJhM2E5NWY3NTdmZWJkZjNkMGFmNDIyClNpZ25lZC1vZmYtYnk6IEd1Y2h1biBDaGVuIDxndWNo
dW4uY2hlbkBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8w
LmMgfCAzICsrKwogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9nZnhfdjlfMC5jCmluZGV4IDNlNDZjY2U2MDU1My4uNTljNzdiMDFjODhhIDEw
MDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMKQEAgLTU5NjAsNiArNTk2MCw5IEBA
IHN0YXRpYyBpbnQgZ2Z4X3Y5XzBfcmFzX2Vycm9yX2luamVjdChzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldiwKIAlpZiAoYWRldi0+YXNpY190eXBlICE9IENISVBfVkVHQTIwKQogCQlyZXR1cm4g
LUVJTlZBTDsKIAorCWlmIChpbmZvLT5oZWFkLnN1Yl9ibG9ja19pbmRleCA+PSBBUlJBWV9TSVpF
KHJhc19nZnhfc3ViYmxvY2tzKSkKKwkJcmV0dXJuIC1FSU5WQUw7CisKIAlpZiAoIXJhc19nZnhf
c3ViYmxvY2tzW2luZm8tPmhlYWQuc3ViX2Jsb2NrX2luZGV4XS5uYW1lKQogCQlyZXR1cm4gLUVQ
RVJNOwogCi0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eA==
