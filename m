From: Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH xf86-video-amdgpu 09/19] Remove error handling on xnfcalloc()
Date: Wed,  4 Apr 2018 15:29:44 +0100
Message-ID: <20180404142954.31360-10-emil.l.velikov@gmail.com>
References: <20180404142954.31360-1-emil.l.velikov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180404142954.31360-1-emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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

RnJvbTogRW1pbCBWZWxpa292IDxlbWlsLnZlbGlrb3ZAY29sbGFib3JhLmNvbT4KClRoZSBmdW5j
dGlvbiAiY2Fubm90IGZhaWwiLCB0aHVzIHdlJ2xsIG5ldmVyIGhpdCB0aGUgZXJyb3IgcGF0aC4K
ClNpZ25lZC1vZmYtYnk6IEVtaWwgVmVsaWtvdiA8ZW1pbC52ZWxpa292QGNvbGxhYm9yYS5jb20+
Ci0tLQogc3JjL2FtZGdwdV9wcm9iZS5jIHwgMiAtLQogMSBmaWxlIGNoYW5nZWQsIDIgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvc3JjL2FtZGdwdV9wcm9iZS5jIGIvc3JjL2FtZGdwdV9wcm9i
ZS5jCmluZGV4IDhhMTYwNjAuLjg4NDI4NjggMTAwNjQ0Ci0tLSBhL3NyYy9hbWRncHVfcHJvYmUu
YworKysgYi9zcmMvYW1kZ3B1X3Byb2JlLmMKQEAgLTIzMiw4ICsyMzIsNiBAQCBhbWRncHVfcHJv
YmUoU2NybkluZm9QdHIgcFNjcm4sIGludCBlbnRpdHlfbnVtLAogCiAJaWYgKCFwUHJpdi0+cHRy
KSB7CiAJCXBQcml2LT5wdHIgPSB4bmZjYWxsb2Moc2l6ZW9mKEFNREdQVUVudFJlYyksIDEpOwot
CQlpZiAoIXBQcml2LT5wdHIpCi0JCQlnb3RvIGVycm9yOwogCiAJCWlmICghYW1kZ3B1X2Rldmlj
ZV9zZXR1cChwU2NybiwgcGNpX2RldiwgZGV2LCBwUHJpdi0+cHRyKSkKIAkJCWdvdG8gZXJyb3I7
Ci0tIAoyLjE2LjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
