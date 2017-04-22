From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: [PATCH libdrm] amdgpu: Use the canonical form in branch predicate
Date: Sat, 22 Apr 2017 16:47:40 +1000
Message-ID: <20170422064740.2491-1-funfunctor@folklore1984.net>
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
Cc: emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

U3VnZ2VzdGVkLWJ5OiBFbWlsIFZlbGlrb3YgPGVtaWwubC52ZWxpa292QGdtYWlsLmNvbT4KU2ln
bmVkLW9mZi1ieTogRWR3YXJkIE8nQ2FsbGFnaGFuIDxmdW5mdW5jdG9yQGZvbGtsb3JlMTk4NC5u
ZXQ+Ci0tLQogYW1kZ3B1L2FtZGdwdV9jcy5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvYW1kZ3B1L2FtZGdwdV9jcy5j
IGIvYW1kZ3B1L2FtZGdwdV9jcy5jCmluZGV4IDA5OTNhNmQuLjg2OGViN2IgMTAwNjQ0Ci0tLSBh
L2FtZGdwdS9hbWRncHVfY3MuYworKysgYi9hbWRncHUvYW1kZ3B1X2NzLmMKQEAgLTU1OSw3ICs1
NTksNyBAQCBpbnQgYW1kZ3B1X2NzX3dhaXRfc2VtYXBob3JlKGFtZGdwdV9jb250ZXh0X2hhbmRs
ZSBjdHgsCiAJaWYgKHJpbmcgPj0gQU1ER1BVX0NTX01BWF9SSU5HUykKIAkJcmV0dXJuIC1FSU5W
QUw7CiAJLyogbXVzdCBzaWduYWwgZmlyc3QgKi8KLQlpZiAoTlVMTCA9PSBzZW0tPnNpZ25hbF9m
ZW5jZS5jb250ZXh0KQorCWlmICghc2VtLT5zaWduYWxfZmVuY2UuY29udGV4dCkKIAkJcmV0dXJu
IC1FSU5WQUw7CiAKIAlwdGhyZWFkX211dGV4X2xvY2soJmN0eC0+c2VxdWVuY2VfbXV0ZXgpOwot
LSAKMi45LjMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
