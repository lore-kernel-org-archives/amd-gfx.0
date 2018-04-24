From: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/3] signals: Allow generation of SIGKILL to exiting task.
Date: Tue, 24 Apr 2018 11:30:34 -0400
Message-ID: <1524583836-12130-2-git-send-email-andrey.grodzovsky@amd.com>
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1524583836-12130-1-git-send-email-andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
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
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: David.Panariti-5C7GfCeVMHo@public.gmane.org, Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>, oleg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org, Alexander.Deucher-5C7GfCeVMHo@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Christian.Koenig-5C7GfCeVMHo@public.gmane.org

Q3VycmVudGx5IGNhbGxpbmcgd2FpdF9ldmVudF9raWxsYWJsZSBhcyBwYXJ0IG9mIGV4aXRpbmcg
cHJvY2Vzcwp3aWxsIHN0YWxsIGZvcmV2ZXIgc2luY2UgU0lHS0lMTCBnZW5lcmF0aW9uIGlzIHN1
cHByZXNlZCBieSBQRl9FWElUSU5HLgoKSW4gb3VyIHBhcnRpbGF1ciBjYXNlIEFNREdQVSBkcml2
ZXIgd2FudHMgdG8gZmx1c2ggYWxsIEdQVSBqb2JzIGluCmZsaWdodCBiZWZvcmUgc2h1dHRpbmcg
ZG93bi4gQnV0IGlmIHNvbWUgam9iIGhhbmdzIHRoZSBwaXBlIHdlIHN0aWxsIHdhbnQgdG8KYmUg
YWJsZSB0byBraWxsIGl0IGFuZCBhdm9pZCBhIHByb2Nlc3MgaW4gRCBzdGF0ZS4KClNpZ25lZC1v
ZmYtYnk6IEFuZHJleSBHcm9kem92c2t5IDxhbmRyZXkuZ3JvZHpvdnNreUBhbWQuY29tPgotLS0K
IGtlcm5lbC9zaWduYWwuYyB8IDQgKystLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9rZXJuZWwvc2lnbmFsLmMgYi9rZXJuZWwv
c2lnbmFsLmMKaW5kZXggYzZlNGM4My4uYzQ5YzcwNiAxMDA2NDQKLS0tIGEva2VybmVsL3NpZ25h
bC5jCisrKyBiL2tlcm5lbC9zaWduYWwuYwpAQCAtODg2LDEwICs4ODYsMTAgQEAgc3RhdGljIGlu
bGluZSBpbnQgd2FudHNfc2lnbmFsKGludCBzaWcsIHN0cnVjdCB0YXNrX3N0cnVjdCAqcCkKIHsK
IAlpZiAoc2lnaXNtZW1iZXIoJnAtPmJsb2NrZWQsIHNpZykpCiAJCXJldHVybiAwOwotCWlmIChw
LT5mbGFncyAmIFBGX0VYSVRJTkcpCi0JCXJldHVybiAwOwogCWlmIChzaWcgPT0gU0lHS0lMTCkK
IAkJcmV0dXJuIDE7CisJaWYgKHAtPmZsYWdzICYgUEZfRVhJVElORykKKwkJcmV0dXJuIDA7CiAJ
aWYgKHRhc2tfaXNfc3RvcHBlZF9vcl90cmFjZWQocCkpCiAJCXJldHVybiAwOwogCXJldHVybiB0
YXNrX2N1cnIocCkgfHwgIXNpZ25hbF9wZW5kaW5nKHApOwotLSAKMi43LjQKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
