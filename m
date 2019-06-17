From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 062/459] drm/amdgpu: add structures for buffer
 allocate/release for rlc autoload
Date: Mon, 17 Jun 2019 14:10:23 -0500
Message-ID: <20190617191700.17899-51-alexander.deucher@amd.com>
References: <20190617191700.17899-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190617191700.17899-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, "Le.Ma" <Le.Ma-5C7GfCeVMHo@public.gmane.org>, Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

RnJvbTogIkxlLk1hIiA8TGUuTWFAYW1kLmNvbT4KCkFsbG9jYXRlIGEgdmlzaWJsZSBmcmFtZWJ1
ZmZlciB0byBzdG9yZSBhbGwgZ2Z4aXAgdWNvZGVzIGFzIHRoZSBmb3JtYXQgb2YgVE9DLgoKU2ln
bmVkLW9mZi1ieTogTGUuTWEgPExlLk1hQGFtZC5jb20+ClJldmlld2VkLWJ5OiBBbGV4IERldWNo
ZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+ClJldmlld2VkLWJ5OiBIYXdraW5nIFpoYW5n
IDxIYXdraW5nLlpoYW5nQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxl
eGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfcmxjLmggfCA1ICsrKysrCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspCgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3JsYy5oIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3JsYy5oCmluZGV4IDQ5YThhYjUyMTEzYi4u
ZmY0M2ZhOWExNGE5IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfcmxjLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3JsYy5oCkBA
IC04NSw2ICs4NSwxMSBAQCBzdHJ1Y3QgYW1kZ3B1X3JsYyB7CiAJdTggKnNhdmVfcmVzdG9yZV9s
aXN0X3NybTsKIAogCWJvb2wgaXNfcmxjX3YyXzE7CisKKwkvKiBmb3IgcmxjIGF1dG9sb2FkICov
CisJc3RydWN0IGFtZGdwdV9ibwkqcmxjX2F1dG9sb2FkX2JvOworCXU2NAkJCXJsY19hdXRvbG9h
ZF9ncHVfYWRkcjsKKwl2b2lkCQkJKnJsY19hdXRvbG9hZF9wdHI7CiB9OwogCiB2b2lkIGFtZGdw
dV9nZnhfcmxjX2VudGVyX3NhZmVfbW9kZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7Ci0t
IAoyLjIwLjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
