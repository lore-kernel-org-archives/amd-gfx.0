From: <Ken.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: Remove check which is not valid for certain VBIOS
Date: Wed, 8 Nov 2017 14:49:50 +0800
Message-ID: <1510123790-23412-1-git-send-email-Ken.Wang@amd.com>
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
Cc: Ken Wang <Ken.Wang-5C7GfCeVMHo@public.gmane.org>

RnJvbTogS2VuIFdhbmcgPEtlbi5XYW5nQGFtZC5jb20+CgpTaWduZWQtb2ZmLWJ5OiBLZW4gV2Fu
ZyA8S2VuLldhbmdAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfYmlvcy5jIHwgNiAtLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA2IGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9iaW9zLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYmlvcy5jCmluZGV4IGMyMWFkZjYuLjA1N2Ux
ZWMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9iaW9zLmMK
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Jpb3MuYwpAQCAtNTksMTIg
KzU5LDYgQEAgc3RhdGljIGJvb2wgY2hlY2tfYXRvbV9iaW9zKHVpbnQ4X3QgKmJpb3MsIHNpemVf
dCBzaXplKQogCQlyZXR1cm4gZmFsc2U7CiAJfQogCi0JdG1wID0gYmlvc1sweDE4XSB8IChiaW9z
WzB4MTldIDw8IDgpOwotCWlmIChiaW9zW3RtcCArIDB4MTRdICE9IDB4MCkgewotCQlEUk1fSU5G
TygiTm90IGFuIHg4NiBCSU9TIFJPTVxuIik7Ci0JCXJldHVybiBmYWxzZTsKLQl9Ci0KIAliaW9z
X2hlYWRlcl9zdGFydCA9IGJpb3NbMHg0OF0gfCAoYmlvc1sweDQ5XSA8PCA4KTsKIAlpZiAoIWJp
b3NfaGVhZGVyX3N0YXJ0KSB7CiAJCURSTV9JTkZPKCJDYW4ndCBsb2NhdGUgYmlvcyBoZWFkZXJc
biIpOwotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
