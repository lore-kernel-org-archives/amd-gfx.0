From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 04/13] drm/amd/display: Fix brace style in
 amdgpu_dm_update_connector_after_detect()
Date: Tue, 17 Oct 2017 12:19:03 -0400
Message-ID: <20171017161912.11357-5-tom.stdenis@amd.com>
References: <20171017161912.11357-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171017161912.11357-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogVG9tIFN0IERlbmlzIDx0b20uc3RkZW5pc0BhbWQuY29tPgotLS0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgfCA0ICsrLS0K
IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKaW5kZXgg
MGUxMDU0OGRmZDFmLi4zYTkyN2EyNGVhMGMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwpAQCAtODk4LDkgKzg5OCw5IEBAIGFtZGdw
dV9kbV91cGRhdGVfY29ubmVjdG9yX2FmdGVyX2RldGVjdChzdHJ1Y3QgYW1kZ3B1X2RtX2Nvbm5l
Y3RvciAqYWNvbm5lY3RvcikKIAkJCQkJCQljb25uZWN0b3IpOwogCiAJCWFjb25uZWN0b3ItPmRj
X3NpbmsgPSBzaW5rOwotCQlpZiAoc2luay0+ZGNfZWRpZC5sZW5ndGggPT0gMCkKKwkJaWYgKHNp
bmstPmRjX2VkaWQubGVuZ3RoID09IDApIHsKIAkJCWFjb25uZWN0b3ItPmVkaWQgPSBOVUxMOwot
CQllbHNlIHsKKwkJfSBlbHNlIHsKIAkJCWFjb25uZWN0b3ItPmVkaWQgPQogCQkJCShzdHJ1Y3Qg
ZWRpZCAqKSBzaW5rLT5kY19lZGlkLnJhd19lZGlkOwogCi0tIAoyLjEyLjAKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
