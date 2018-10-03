From: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/5] drm/amdgpu: Don't reallocate ucode bo when suspend
Date: Wed, 3 Oct 2018 19:09:56 +0800
Message-ID: <1538565000-30532-2-git-send-email-Rex.Zhu@amd.com>
References: <1538565000-30532-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1538565000-30532-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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
Cc: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

ZHJpdmVyIGRvbid0IHJlbGVhc2UgdGhlIHVjb2RlIG1lbW9yeSB3aGVuIHN1c3BlbmQuIHNvIGRv
bid0Cm5lZWQgdG8gYWxsb2NhdGUgYm8gd2hlbiByZXN1bWUgYmFjay4KClNpZ25lZC1vZmYtYnk6
IFJleCBaaHUgPFJleC5aaHVAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdWNvZGUuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV91Y29kZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Vjb2RlLmMK
aW5kZXggOTg3ODIxMi4uYWRmZWI5MyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3Vjb2RlLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3Vjb2RlLmMKQEAgLTQzNCw3ICs0MzQsNyBAQCBpbnQgYW1kZ3B1X3Vjb2RlX2luaXRfYm8o
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJCXJldHVybiAwOwogCX0KIAotCWlmICghYWRl
di0+aW5fZ3B1X3Jlc2V0KSB7CisJaWYgKCFhZGV2LT5pbl9ncHVfcmVzZXQgJiYgIWFkZXYtPmlu
X3N1c3BlbmQpIHsKIAkJZXJyID0gYW1kZ3B1X2JvX2NyZWF0ZV9rZXJuZWwoYWRldiwgYWRldi0+
ZmlybXdhcmUuZndfc2l6ZSwgUEFHRV9TSVpFLAogCQkJCQlhbWRncHVfc3Jpb3ZfdmYoYWRldikg
PyBBTURHUFVfR0VNX0RPTUFJTl9WUkFNIDogQU1ER1BVX0dFTV9ET01BSU5fR1RULAogCQkJCQkm
YWRldi0+ZmlybXdhcmUuZndfYnVmLAotLSAKMS45LjEKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeAo=
