From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 7/9] drm/amdgpu: Throttle visible VRAM moves separately
Date: Mon, 26 Jun 2017 18:44:30 +0900
Message-ID: <c132d211-bb7c-1e7d-617a-6f128343a581@daenzer.net>
References: <1498239580-17360-1-git-send-email-john@fastquake.com>
 <1498239580-17360-8-git-send-email-john@fastquake.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1498239580-17360-8-git-send-email-john-xq/Ko7C6e2Bl57MIdRCFDg@public.gmane.org>
Content-Language: en-CA
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
To: John Brooks <john-xq/Ko7C6e2Bl57MIdRCFDg@public.gmane.org>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjQvMDYvMTcgMDI6MzkgQU0sIEpvaG4gQnJvb2tzIHdyb3RlOgo+IFRoZSBCTyBtb3ZlIHRo
cm90dGxpbmcgY29kZSBpcyBkZXNpZ25lZCB0byBhbGxvdyBWUkFNIHRvIGZpbGwgcXVpY2tseSBp
ZiBpdAo+IGlzIHJlbGF0aXZlbHkgZW1wdHkuIEhvd2V2ZXIsIHRoaXMgZG9lcyBub3QgdGFrZSBp
bnRvIGFjY291bnQgc2l0dWF0aW9ucwo+IHdoZXJlIHRoZSB2aXNpYmxlIFZSQU0gaXMgc21hbGxl
ciB0aGFuIHRvdGFsIFZSQU0sIGFuZCB0b3RhbCBWUkFNIG1heSBub3QKPiBiZSBjbG9zZSB0byBm
dWxsIGJ1dCB0aGUgdmlzaWJsZSBWUkFNIHNlZ21lbnQgaXMgdW5kZXIgcHJlc3N1cmUuIEluIHN1
Y2gKPiBzaXR1YXRpb25zLCB2aXNpYmxlIFZSQU0gd291bGQgZXhwZXJpZW5jZSB1bnJlc3RyaWN0
ZWQgc3dhcHBpbmcgYW5kCj4gcGVyZm9ybWFuY2Ugd291bGQgZHJvcC4KPiAKPiBBZGQgYSBzZXBh
cmF0ZSBjb3VudGVyIHNwZWNpZmljYWxseSBmb3IgbW92ZXMgaW52b2x2aW5nIHZpc2libGUgVlJB
TSwgYW5kCj4gY2hlY2sgaXQgYmVmb3JlIG1vdmluZyBCT3MgdGhlcmUuCj4gCj4gRml4ZXM6IDk1
ODQ0ZDIwYWUwMiAoZHJtL2FtZGdwdTogdGhyb3R0bGUgYnVmZmVyIG1pZ3JhdGlvbnMgYXQgQ1Mg
dXNpbmcgYSBmaXhlZCBNQnBzIGxpbWl0ICh2MikpCj4gU2lnbmVkLW9mZi1ieTogSm9obiBCcm9v
a3MgPGpvaG5AZmFzdHF1YWtlLmNvbT4KClNvbWV0aGluZyBsaWtlIHRoaXMgcGF0Y2ggaXMgZGVm
aW5pdGVseSBuZWVkZWQsIGdvb2QgY2F0Y2guCgpIb3dldmVyLCBhcyBpcyBvbmUgaXNzdWUgaXMg
dGhhdCBpdCBpbmN1cnMgQ1BVIG92ZXJoZWFkIGV2ZW4gd2hlbiBhbGwgb2YKVlJBTSBpcyBDUFUg
dmlzaWJsZS4gQ2FuIHRoYXQgYmUgYXZvaWRlZCBzb21laG93PwoKCi0tIApFYXJ0aGxpbmcgTWlj
aGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgaHR0cDovL3d3dy5hbWQu
Y29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBN
ZXNhIGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
