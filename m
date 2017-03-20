From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 037/100] drm/amdgpu: add tiling flags for GFX9
Date: Mon, 20 Mar 2017 16:29:32 -0400
Message-ID: <1490041835-11255-23-git-send-email-alexander.deucher@amd.com>
References: <1490041835-11255-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1490041835-11255-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

U2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgot
LS0KIGluY2x1ZGUvdWFwaS9kcm0vYW1kZ3B1X2RybS5oIHwgNCArKysrCiAxIGZpbGUgY2hhbmdl
ZCwgNCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL2RybS9hbWRncHVf
ZHJtLmggYi9pbmNsdWRlL3VhcGkvZHJtL2FtZGdwdV9kcm0uaAppbmRleCA3Y2ZkYmQ4Li4yODli
MTI5IDEwMDY0NAotLS0gYS9pbmNsdWRlL3VhcGkvZHJtL2FtZGdwdV9kcm0uaAorKysgYi9pbmNs
dWRlL3VhcGkvZHJtL2FtZGdwdV9kcm0uaApAQCAtMjI4LDcgKzIyOCwxMSBAQCBzdHJ1Y3QgZHJt
X2FtZGdwdV9nZW1fdXNlcnB0ciB7CiAjZGVmaW5lIEFNREdQVV9USUxJTkdfTUFDUk9fVElMRV9B
U1BFQ1RfTUFTSwkJMHgzCiAjZGVmaW5lIEFNREdQVV9USUxJTkdfTlVNX0JBTktTX1NISUZUCQkJ
MjEKICNkZWZpbmUgQU1ER1BVX1RJTElOR19OVU1fQkFOS1NfTUFTSwkJCTB4MworLyogVGlsaW5n
IGZsYWdzIGZvciBHRlg5LiAqLworI2RlZmluZSBBTURHUFVfVElMSU5HX1NXSVpaTEVfTU9ERV9T
SElGVAkJMAorI2RlZmluZSBBTURHUFVfVElMSU5HX1NXSVpaTEVfTU9ERV9NQVNLCQkJMHgxZgog
CisvKiBTZXQvR2V0IGhlbHBlcnMgZm9yIHRpbGluZyBmbGFncy4gKi8KICNkZWZpbmUgQU1ER1BV
X1RJTElOR19TRVQoZmllbGQsIHZhbHVlKSBcCiAJKCgodmFsdWUpICYgQU1ER1BVX1RJTElOR18j
I2ZpZWxkIyNfTUFTSykgPDwgQU1ER1BVX1RJTElOR18jI2ZpZWxkIyNfU0hJRlQpCiAjZGVmaW5l
IEFNREdQVV9USUxJTkdfR0VUKHZhbHVlLCBmaWVsZCkgXAotLSAKMi41LjUKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
