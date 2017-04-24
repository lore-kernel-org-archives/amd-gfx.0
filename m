From: =?UTF-8?Q?Nicolai_H=c3=a4hnle?= <nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH libdrm] amdgpu: Use the canonical form in branch predicate
Date: Mon, 24 Apr 2017 14:36:33 +0200
Message-ID: <47b5d013-d325-36e9-ae4e-5b80ebcdd72c@gmail.com>
References: <20170422064740.2491-1-funfunctor@folklore1984.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170422064740.2491-1-funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
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
To: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

T24gMjIuMDQuMjAxNyAwODo0NywgRWR3YXJkIE8nQ2FsbGFnaGFuIHdyb3RlOgo+IFN1Z2dlc3Rl
ZC1ieTogRW1pbCBWZWxpa292IDxlbWlsLmwudmVsaWtvdkBnbWFpbC5jb20+Cj4gU2lnbmVkLW9m
Zi1ieTogRWR3YXJkIE8nQ2FsbGFnaGFuIDxmdW5mdW5jdG9yQGZvbGtsb3JlMTk4NC5uZXQ+CgpS
ZXZpZXdlZC1ieTogTmljb2xhaSBIw6RobmxlIDxuaWNvbGFpLmhhZWhubGVAYW1kLmNvbT4KCj4g
LS0tCj4gIGFtZGdwdS9hbWRncHVfY3MuYyB8IDIgKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvYW1kZ3B1L2FtZGdwdV9j
cy5jIGIvYW1kZ3B1L2FtZGdwdV9jcy5jCj4gaW5kZXggMDk5M2E2ZC4uODY4ZWI3YiAxMDA2NDQK
PiAtLS0gYS9hbWRncHUvYW1kZ3B1X2NzLmMKPiArKysgYi9hbWRncHUvYW1kZ3B1X2NzLmMKPiBA
QCAtNTU5LDcgKzU1OSw3IEBAIGludCBhbWRncHVfY3Nfd2FpdF9zZW1hcGhvcmUoYW1kZ3B1X2Nv
bnRleHRfaGFuZGxlIGN0eCwKPiAgCWlmIChyaW5nID49IEFNREdQVV9DU19NQVhfUklOR1MpCj4g
IAkJcmV0dXJuIC1FSU5WQUw7Cj4gIAkvKiBtdXN0IHNpZ25hbCBmaXJzdCAqLwo+IC0JaWYgKE5V
TEwgPT0gc2VtLT5zaWduYWxfZmVuY2UuY29udGV4dCkKPiArCWlmICghc2VtLT5zaWduYWxfZmVu
Y2UuY29udGV4dCkKPiAgCQlyZXR1cm4gLUVJTlZBTDsKPgo+ICAJcHRocmVhZF9tdXRleF9sb2Nr
KCZjdHgtPnNlcXVlbmNlX211dGV4KTsKPgoKCi0tIApMZXJuZSwgd2llIGRpZSBXZWx0IHdpcmts
aWNoIGlzdCwKQWJlciB2ZXJnaXNzIG5pZW1hbHMsIHdpZSBzaWUgc2VpbiBzb2xsdGUuCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
