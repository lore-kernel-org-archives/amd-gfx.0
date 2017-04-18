From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH libdrm 0/2] amdgpu: add amdgpu_cs_wait_fences
Date: Tue, 18 Apr 2017 10:35:58 -0400
Message-ID: <CADnq5_Pffzi=33s=AVUe0AATS2Q32yJ-mSHcZsmR5idsKXYSaw@mail.gmail.com>
References: <20170413144756.30734-1-nhaehnle@gmail.com>
 <c1e20407-0b2c-19fb-5922-71cfb44eccbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <c1e20407-0b2c-19fb-5922-71cfb44eccbb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gVHVlLCBBcHIgMTgsIDIwMTcgYXQgNjoxMSBBTSwgTmljb2xhaSBIw6RobmxlIDxuaGFlaG5s
ZUBnbWFpbC5jb20+IHdyb3RlOgo+IFBvc3QtRWFzdGVyIHBpbmcgLSBhbnlib2R5IHdhbnQgdG8g
Z2l2ZSB0aGVpciBSLWI/CgpGb3IgdGhlIHNlcmllczoKUmV2aWV3ZWQtYnk6IEFsZXggRGV1Y2hl
ciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KCj4KPiBUaGFua3MsCj4gTmljb2xhaQo+Cj4g
T24gMTMuMDQuMjAxNyAxNjo0NywgTmljb2xhaSBIw6RobmxlIHdyb3RlOgo+Pgo+PiBIaSBhbGws
Cj4+Cj4+IFRoZXNlIGNoYW5nZXMgZXhwb3NlIGEgZnVuY3Rpb24gdG8gY2FsbCB0aGUgV0FJVF9G
RU5DRVMgaW9jdGwgZm9yCj4+IHdhaXRpbmcgb24gbXVsdGlwbGUgZmVuY2VzIGF0IHRoZSBzYW1l
IHRpbWUuIFRoaXMgaXMgdXNlZnVsIGZvcgo+PiBWdWxrYW4uCj4+Cj4+IFRoZXkgYXJlIG1vc3Rs
eSBjaGFuZ2VzIHRoYXQgaGF2ZSBiZWVuIGluIHRoZSBhbWRncHUtcHJvIGxpYmRybQo+PiBmb3Ig
YSBsb25nIHRpbWUuIEkndmUgdGFrZW4gdGhlIGxpYmVydHkgdG8gY2xlYW4gdGhlbSB1cCBhIGJp
dAo+PiBhbmQgYWRkIHNvbWUgbWlzc2luZyBiaXRzLgo+Pgo+PiBQbGVhc2UgcmV2aWV3IQo+PiBU
aGFua3MsCj4+IE5pY29sYWkKPj4KPgo+Cj4gLS0KPiBMZXJuZSwgd2llIGRpZSBXZWx0IHdpcmts
aWNoIGlzdCwKPiBBYmVyIHZlcmdpc3MgbmllbWFscywgd2llIHNpZSBzZWluIHNvbGx0ZS4KPgo+
IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1kLWdm
eCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeApfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
