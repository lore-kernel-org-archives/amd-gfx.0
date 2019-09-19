From: "Zhou1, Tao" <Tao.Zhou1-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 07/21] drm/amdgpu: add common mmhub member for adev
Date: Thu, 19 Sep 2019 07:12:44 +0000
Message-ID: <20190919071115.16552-8-tao.zhou1@amd.com>
References: <20190919071115.16552-1-tao.zhou1@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190919071115.16552-1-tao.zhou1-5C7GfCeVMHo@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Chen,
 Guchun" <Guchun.Chen-5C7GfCeVMHo@public.gmane.org>, "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
Cc: "Zhou1, Tao" <Tao.Zhou1-5C7GfCeVMHo@public.gmane.org>

cHV0IG1taHViX2Z1bmNzIGFuZCByYXNfaWYgcG9pbnRlciBpbnRvIG1taHViIHN0cnVjdAoKU2ln
bmVkLW9mZi1ieTogVGFvIFpob3UgPHRhby56aG91MUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oICAgICAgIHwgMyArKysKIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9tbWh1Yi5oIHwgNSArKysrKwogMiBmaWxlcyBjaGFuZ2VkLCA4IGlu
c2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHUuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oCmluZGV4IDZmZjAyYmI2
MDE0MC4uOTU5NGVhZWJjZmQxIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHUuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaApAQCAt
ODc3LDYgKzg3Nyw5IEBAIHN0cnVjdCBhbWRncHVfZGV2aWNlIHsKIAkvKiBuYmlvICovCiAJc3Ry
dWN0IGFtZGdwdV9uYmlvCQluYmlvOwogCisJLyogbW1odWIgKi8KKwlzdHJ1Y3QgYW1kZ3B1X21t
aHViCQltbWh1YjsKKwogCS8qIGdmeCAqLwogCXN0cnVjdCBhbWRncHVfZ2Z4CQlnZng7CiAKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9tbWh1Yi5oIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X21taHViLmgKaW5kZXggNjg1ZTU0ZTU4NzAw
Li5hNzMzODk4YzdkNTUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9tbWh1Yi5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9tbWh1
Yi5oCkBAIC0yOCw2ICsyOCwxMSBAQCBzdHJ1Y3QgYW1kZ3B1X21taHViX2Z1bmNzIHsKIAkJCQkJ
dm9pZCAqcmFzX2Vycm9yX3N0YXR1cyk7CiB9OwogCitzdHJ1Y3QgYW1kZ3B1X21taHViIHsKKwlz
dHJ1Y3QgcmFzX2NvbW1vbl9pZiAqcmFzX2lmOworCWNvbnN0IHN0cnVjdCBhbWRncHVfbW1odWJf
ZnVuY3MgKmZ1bmNzOworfTsKKwogaW50IGFtZGdwdV9tbWh1Yl9yYXNfbGF0ZV9pbml0KHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2KTsKIAogI2VuZGlmCi0tIAoyLjE3LjEKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
