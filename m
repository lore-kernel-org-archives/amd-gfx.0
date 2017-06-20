From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: GART write flush error on SI w/ amdgpu
Date: Tue, 20 Jun 2017 15:56:35 +0200
Message-ID: <CAAxE2A6M4EV6T3jgxByOnSjabB+r3bnqXVULr3YC-2j8RqD87A@mail.gmail.com>
References: <c53a99e5-eea0-17d1-05e6-b6e66746d774@gmail.com>
 <CAAxE2A7Q=qdxtm6HXF3Py9dYpARvA6+Z4ENkWTCEA572SdNEqw@mail.gmail.com>
 <CAAxE2A7ZApX2aO1nJKwbqMWWjX4ZL6zTdtsCbEA946J2CmtjrQ@mail.gmail.com>
 <ed0120b2-f34e-6f95-379f-d038574ec346@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <ed0120b2-f34e-6f95-379f-d038574ec346-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: =?UTF-8?Q?Nicolai_H=C3=A4hnle?= <nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gVHVlLCBKdW4gMjAsIDIwMTcgYXQgMTo0OSBQTSwgTmljb2xhaSBIw6RobmxlIDxuaGFlaG5s
ZUBnbWFpbC5jb20+IHdyb3RlOgo+IE9uIDIwLjA2LjIwMTcgMTI6MzQsIE1hcmVrIE9sxaHDoWsg
d3JvdGU6Cj4+Cj4+IEJUVywgSSBub3RpY2VkIHRoZSBmbHVzaCBzZXF1ZW5jZSBpbiB0aGUga2Vy
bmVsIGlzIHdyb25nLiBUaGUgY29ycmVjdAo+PiBmbHVzaCBzZXF1ZW5jZSBzaG91bGQgYmU6Cj4+
Cj4+IDEpIEVWRU5UX1dSSVRFX0VPUCAtIENBQ0hFX0ZMVVNIX0FORF9JTlZfVFMgLSB3cml0ZSBh
IGR3b3JkIHRvIG1lbW9yeSwKPj4gYnV0IG5vIGZlbmNlL2ludGVycnVwdC4KPj4gMikgV0FJVF9S
RUdfTUVNIG9uIHRoZSBkd29yZCB0byB3YWl0IGZvciBpZGxlIGJlZm9yZSBTVVJGQUNFX1NZTkMu
Cj4+IDMpIFNVUkZBQ0VfU1lOQyAoVEMsIEskLCBJJCkKPj4gNCkgV3JpdGUgQ1BfQ09IRVJfQ05U
TDIuCj4+IDUpIEVWRU5UX1dSSVRFX0VPUCAtIEJPVFRPTV9PRl9QSVBFX1RTIC0gd3JpdGUgdGhl
IGZlbmNlIHdpdGggdGhlCj4+IGludGVycnVwdC4KPj4KPj4gV0FJVF9SRUdfTUVNIHdvdWxkbid0
IGJlIG5lZWRlZCBpZiB3ZSB3ZXJlIGFibGUgdG8gbWVyZ2UKPj4gQ0FDSEVfRkxVU0hfQU5EX0lO
ViwgU1VSRkFDRV9TWU5DLCBhbmQgQ1BfQ09IRVJfQ05UTDIgaW50byBvbmUgRU9QCj4+IGV2ZW50
Lgo+Pgo+PiBUaGUgbWFpbiBpc3N1ZSB3aXRoIHRoZSBjdXJyZW50IGZsdXNoIHNlcXVlbmNlIGlu
IHJhZGVvbiBhbmQgYW1kZ3B1IGlzCj4+IHRoYXQgaXQgZG9lc24ndCB3YWl0IGZvciBpZGxlIGJl
Zm9yZSB3cml0aW5nIENQX0NPSEVSX0NOVEwyIGFuZAo+PiBTVVJGQUNFX1NZTkMuIFNvIGZhciB3
ZSd2ZSBiZWVuIGFibGUgdG8gYXZvaWQgdGhlIGJ1ZyBieSB3YWl0aW5nIGZvcgo+PiBpZGxlIGlu
IHVzZXJzcGFjZSBJQnMuCj4KPgo+IFRoaXMgaXMgZ2Z4OS1vbmx5IHRob3VnaCwgcmlnaHQ/CgpO
bywgSSdtIG9ubHkgdGFsa2luZyBhYm91dCBTSS4KCk1hcmVrCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
