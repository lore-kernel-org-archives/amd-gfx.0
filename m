From: Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 3/4] drm/amdgpu: only allow error injection to UMC IP block
Date: Thu, 18 Jul 2019 16:20:13 +0800
Message-ID: <1563438014-29690-3-git-send-email-Hawking.Zhang@amd.com>
References: <1563438014-29690-1-git-send-email-Hawking.Zhang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1563438014-29690-1-git-send-email-Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
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
Cc: Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

ZXJyb3IgaW5qZWN0aW9uIHRvIG90aGVyIElQIGJsb2NrcyAoZXhjZXB0IFVNQykgd2lsbCBiZSBl
bmFibGVkCnVudGlsIFJBUyBmZWF0dXJlIHN0YWJsaXplIG9uIHRob3NlIElQIGJsb2NrcwoKU2ln
bmVkLW9mZi1ieTogSGF3a2luZyBaaGFuZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPgotLS0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYyB8IDYgKysrKysrCiAxIGZpbGUg
Y2hhbmdlZCwgNiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3Jhcy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3Jhcy5jCmluZGV4IGJkYTkwMjUuLjVlZTczZjUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfcmFzLmMKQEAgLTYyNyw2ICs2MjcsMTIgQEAgaW50IGFtZGdwdV9yYXNfZXJyb3Jf
aW5qZWN0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCWlmICghb2JqKQogCQlyZXR1cm4g
LUVJTlZBTDsKIAorCWlmIChibG9ja19pbmZvLmJsb2NrX2lkICE9IFRBX1JBU19CTE9DS19fVU1D
KSB7CisJCURSTV9JTkZPKCIlcyBlcnJvciBpbmplY3Rpb24gaXMgbm90IHN1cHBvcnRlZCB5ZXRc
biIsCisJCQkgcmFzX2Jsb2NrX3N0cihpbmZvLT5oZWFkLmJsb2NrKSk7CisJCXJldHVybiAtRUlO
VkFMOworCX0KKwogCXJldCA9IHBzcF9yYXNfdHJpZ2dlcl9lcnJvcigmYWRldi0+cHNwLCAmYmxv
Y2tfaW5mbyk7CiAJaWYgKHJldCkKIAkJRFJNX0VSUk9SKCJSQVMgRVJST1I6IGluamVjdCAlcyBl
cnJvciBmYWlsZWQgcmV0ICVkXG4iLAotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeA==
