From: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/v3d: Fix compilation error on kbuilt test robot.
Date: Fri, 26 Oct 2018 10:43:14 -0400
Message-ID: <1540564994-20109-1-git-send-email-andrey.grodzovsky@amd.com>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org
Cc: Alexander.Deucher-5C7GfCeVMHo@public.gmane.org, Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogQW5kcmV5IEdyb2R6b3Zza3kgPGFuZHJleS5ncm9kem92c2t5QGFtZC5j
b20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL3YzZC92M2Rfc2NoZWQuYyB8IDIgKy0KIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS92M2QvdjNkX3NjaGVkLmMgYi9kcml2ZXJzL2dwdS9kcm0vdjNkL3YzZF9zY2hl
ZC5jCmluZGV4IDI3M2QwZmIuLjgwYjY0MWYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS92
M2QvdjNkX3NjaGVkLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL3YzZC92M2Rfc2NoZWQuYwpAQCAt
MjIyLDcgKzIyMiw3IEBAIHYzZF9zY2hlZF9pbml0KHN0cnVjdCB2M2RfZGV2ICp2M2QpCiAJCQkg
ICAgICZ2M2Rfc2NoZWRfb3BzLAogCQkJICAgICBod19qb2JzX2xpbWl0LCBqb2JfaGFuZ19saW1p
dCwKIAkJCSAgICAgbXNlY3NfdG9famlmZmllcyhoYW5nX2xpbWl0X21zKSwKLQkJCSAgICAgInYz
ZF9yZW5kZXIiLCB0cnVlKTsKKwkJCSAgICAgInYzZF9yZW5kZXIiKTsKIAlpZiAocmV0KSB7CiAJ
CWRldl9lcnIodjNkLT5kZXYsICJGYWlsZWQgdG8gY3JlYXRlIHJlbmRlciBzY2hlZHVsZXI6ICVk
LiIsCiAJCQlyZXQpOwotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
