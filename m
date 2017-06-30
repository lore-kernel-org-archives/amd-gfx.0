From: Shaoyun Liu <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/3] drm/amdgpu: Add wrap function for fence driver to expose
 cpu and gpu address
Date: Fri, 30 Jun 2017 11:53:57 -0400
Message-ID: <1498838037-15565-1-git-send-email-Shaoyun.Liu@amd.com>
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

Q2hhbmdlLUlkOiBJNWM2MjY3MjUzYmZlNTUwN2E4ODJhYWFhMWE0ODJjZjM3ODg1Mjk0NgpTaWdu
ZWQtb2ZmLWJ5OiBTaGFveXVuIExpdSA8U2hhb3l1bi5MaXVAYW1kLmNvbT4KLS0tCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5oIHwgOSArKysrKysrKysKIDEgZmlsZSBj
aGFuZ2VkLCA5IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfcmluZy5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3JpbmcuaAppbmRleCBiYzhkZWM5Li4zZjBiYmM0IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9yaW5nLmgKQEAgLTIxMSw1ICsyMTEsMTQgQEAgc3RhdGljIGlubGluZSB2b2lk
IGFtZGdwdV9yaW5nX2NsZWFyX3Jpbmcoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nKQogCQlyaW5n
LT5yaW5nW2krK10gPSByaW5nLT5mdW5jcy0+bm9wOwogCiB9CitzdGF0aWMgaW5saW5lIHVpbnQ2
NF90IGFtZGdwdV9mZW5jZV9kcnZfZ3B1X2FkZHIoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nKQor
eworCXJldHVybiByaW5nLT5mZW5jZV9kcnYuZ3B1X2FkZHI7Cit9CisKK3N0YXRpYyBpbmxpbmUg
dm9sYXRpbGUgdm9pZCAqIGFtZGdwdV9mZW5jZV9kcnZfY3B1X2FkZHIoc3RydWN0IGFtZGdwdV9y
aW5nICpyaW5nKQoreworCXJldHVybiByaW5nLT5mZW5jZV9kcnYuY3B1X2FkZHI7Cit9CiAKICNl
bmRpZgotLSAKMS45LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
