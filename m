From: Chris Wilson <chris-Y6uKTt2uX1cEflXRtASbqLVCufUGDwFn@public.gmane.org>
Subject: Re: [PATCH 1/4] sync_file: add a mutex to protect fence and callback
 members.
Date: Tue, 14 Mar 2017 09:29:09 +0000
Message-ID: <20170314092909.GE2118@nuc-i3427.alporthouse.com>
References: <20170314005054.7487-1-airlied@gmail.com>
 <20170314005054.7487-3-airlied@gmail.com>
 <20170314084521.njkzr2fotknuafyj@phenom.ffwll.local>
 <2cba21f6-731b-d112-f882-bef66a9b96c9@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2cba21f6-731b-d112-f882-bef66a9b96c9-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: Christian =?iso-8859-1?Q?K=F6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>

T24gVHVlLCBNYXIgMTQsIDIwMTcgYXQgMTA6MTM6MzdBTSArMDEwMCwgQ2hyaXN0aWFuIEvDtm5p
ZyB3cm90ZToKPiBBbSAxNC4wMy4yMDE3IHVtIDA5OjQ1IHNjaHJpZWIgRGFuaWVsIFZldHRlcjoK
PiA+T24gVHVlLCBNYXIgMTQsIDIwMTcgYXQgMTA6NTA6NTFBTSArMTAwMCwgRGF2ZSBBaXJsaWUg
d3JvdGU6Cj4gPj5Gcm9tOiBEYXZlIEFpcmxpZSA8YWlybGllZEByZWRoYXQuY29tPgo+ID4+Cj4g
Pj5UaGlzIGlzbid0IG5lZWRlZCBjdXJyZW50bHksIGJ1dCB0byByZXVzZSBzeW5jIGZpbGUgZm9y
IFZ1bGthbgo+ID4+cGVybWFuZW50IHNoYXJlZCBzZW1hcGhvcmUgc2VtYW50aWNzLCB3ZSBuZWVk
IHRvIGJlIGFibGUgdG8gc3dhcAo+ID4+dGhlIGZlbmNlIGJhY2tpbmcgYSBzeW5jIGZpbGUuIFRo
aXMgcGF0Y2ggYWRkcyBhIG11dGV4IHRvIHRoZQo+ID4+c3luYyBmaWxlIGFuZCB1c2VzIHRvIHBy
b3RlY3QgYWNjZXNzZXMgdG8gdGhlIGZlbmNlIGFuZCBjYiBtZW1iZXJzLgo+ID4+Cj4gPj5TaWdu
ZWQtb2ZmLWJ5OiBEYXZlIEFpcmxpZSA8YWlybGllZEByZWRoYXQuY29tPgo+ID5XZSd2ZSBnb25l
IHRvIHByZXR0eSBncmVhdCBsZW5ndGhzIHRvIHJjdS1wcm90ZWN0IGFsbCB0aGUgZmVuY2Ugc3R1
ZmYsIHNvCj4gPnRoYXQgYSBwZWVrLW9ubHkgaXMgZW50aXJlbHkgbG9ja2xlc3MuIENhbiB3ZSBo
YXogdGhlIHNhbWUgZm9yIHRoaXMgcGxzPwo+IAo+IFllcywganVzdCB3YW50ZWQgdG8gc3VnZ2Vz
dCB0aGUgc2FtZSB0aGluZy4KPiAKPiBCYXNpY2FsbHkgeW91IGp1c3QgbmVlZCB0aGUgZm9sbG93
aW5nIHRvIHJldHJpZXZlIHRoZSBmZW5jZToKPiAKPiB3aGlsZSAoc3luY19maWxlLT5mZW5jZSAm
JiAhKGZlbmNlID0gZmVuY2VfZ2V0X3JjdShzeW5jX2ZpbGUtPmZlbmNlKSk7CgpXZSBldmVuIGhh
dmUgYSBoZWxwZXIgZm9yIHRoYXQ6CgoJZmVuY2UgPSBkbWFfZmVuY2VfZ2V0X3JjdV9zYWZlKCZz
eW5jX2ZpbGUtPmZlbmNlKTsKCihTdGlsbCBnb2luZyB0byBzdWdnZXN0IHVzaW5nIGEgcmVzZXJ2
YXRpb25fb2JqZWN0IHJhdGhlciB0aGFuIGFuCmV4Y2x1c2l2ZS1vbmx5IGltcGxlbWVudGF0aW9u
LikKLUNocmlzCgotLSAKQ2hyaXMgV2lsc29uLCBJbnRlbCBPcGVuIFNvdXJjZSBUZWNobm9sb2d5
IENlbnRyZQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
