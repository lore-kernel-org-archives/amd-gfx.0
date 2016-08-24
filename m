From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: throttle buffer migrations at CS using a
 fixed MBps limit
Date: Wed, 24 Aug 2016 11:46:11 +0200
Message-ID: <CAAxE2A4C=7_0xGCORj9+Hx7bnOe9UOoSoB086ws+OEwTgjBKfQ@mail.gmail.com>
References: <1471990776-22816-1-git-send-email-maraeo@gmail.com>
 <2cabcd3d-1ae1-a109-9410-fe91b7b3e301@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <2cabcd3d-1ae1-a109-9410-fe91b7b3e301-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gV2VkLCBBdWcgMjQsIDIwMTYgYXQgMTA6MDUgQU0sIENocmlzdGlhbiBLw7ZuaWcKPGRlYXRo
c2ltcGxlQHZvZGFmb25lLmRlPiB3cm90ZToKPj4gKyAgICAgICAgICAgICAgIHN0cnVjdCBtdXRl
eCAgICAgICAgICAgIGxvY2s7Cj4KPiBJIGhhdmVuJ3QgY29tcGxldGVseSBjaGVja2VkIHRoZSBj
b2RlLCBidXQgaXQgbG9va2VkIGxpa2UgeW91IGp1c3QgbWFkZSBhCj4gYnVuY2ggb2YgY2FsY3Vs
YXRpb25zIHdoaWxlIGhvbGRpbmcgdGhlIGxvY2sgKGUuZy4gbm8gc2xlZXBpbmcpLgo+Cj4gU28g
aXQgbWlnaHQgYmUgbW9yZSBhcHByb3ByaWF0ZSB0byB1c2UgYSBzcGlubG9jayBoZXJlIChsZXNz
IG92ZXJoZWFkKS4KPgo+IEFwYXJ0IGZyb20gdGhhdCB0aGlzIGxvb2tzIHJlYWxseSBnb29kIHRv
IG1lLCBwYXRjaCBpcyBBY2tlZC1ieTogQ2hyaXN0aWFuCj4gS8O2bmlnIDxjaHJpc3RpYW4ua29l
bmlnQGFtZC5jb20+Lgo+Cj4gQlRXIFJlZ2FyZGluZyBWUkFNIGZyYWdtZW50YXRpb246IENvdWxk
IGl0IGJlIHRoYXQgbW9zdCBhbGlnbiByZXN0cmljdGlvbnMKPiBNZXNhIGZvcndhcmRzIHRvIHRo
ZSBrZXJuZWwgYmVjYW1lIG5vbnNlbnNlIHdpdGggVk0gc3VwcG9ydD8KPgo+IEkgbWVhbiBmb3Ig
dGlsbGluZyB0aGUgbWVtb3J5IG11c3QgYmUgYWxpZ25lZCBpbiB0aGUgVk0sIGJ1dCBub3QgcGh5
c2ljYWxseQo+IGFueSBtb3JlLiBEb2Vzbid0IGl0PwoKSSB0aGluayBhbGwgYWxsb2NhdGlvbnMg
bXVzdCBiZSBib3RoIHBoeXNpY2FsbHkgYW5kIFZNIGFsaWduZWQuIEkKdGhpbmsgdGhhdCBwaHlz
aWNhbCBhbGlnbm1lbnQgaXMgcmVxdWlyZWQgYmVjYXVzZSB0aWxlIG1vZGVzIGV4cGVjdCBhCmNl
cnRhaW4gbWFwcGluZyBvZiB0aWxlcyB0byBtZW1vcnkgY2hhbm5lbHMuCgpNYXJlawpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
