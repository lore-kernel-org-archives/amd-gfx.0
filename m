From: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 8/8] amdgpu: use sync file for shared semaphores (v2.1)
Date: Wed, 12 Apr 2017 12:31:24 +1000
Message-ID: <CAPM=9tx8oG7QzLHr91Z0MXpba81BPYfW5vw_u7Ci6Tjqw7vpFw@mail.gmail.com>
References: <20170411032220.21101-1-airlied@gmail.com>
 <20170411032220.21101-9-airlied@gmail.com>
 <20170411124217.GC7895@nuc-i3427.alporthouse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170411124217.GC7895-aII6DKEyn0pWYbfKqPwjAkR8Iwp7RQ6xAL8bYrjMMd8@public.gmane.org>
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
To: Chris Wilson <chris-Y6uKTt2uX1cEflXRtASbqLVCufUGDwFn@public.gmane.org>, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Jason Ekstrand <jason.ekstrand-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

T24gMTEgQXByaWwgMjAxNyBhdCAyMjo0MiwgQ2hyaXMgV2lsc29uIDxjaHJpc0BjaHJpcy13aWxz
b24uY28udWs+IHdyb3RlOgo+IE9uIFR1ZSwgQXByIDExLCAyMDE3IGF0IDAxOjIyOjIwUE0gKzEw
MDAsIERhdmUgQWlybGllIHdyb3RlOgo+PiArc3RhdGljIGludCBhbWRncHVfc2VtX2xvb2t1cF9h
bmRfc3luYyhzdHJ1Y3QgYW1kZ3B1X2NzX3BhcnNlciAqcCwKPj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgdWludDMyX3QgaGFuZGxlKQo+PiArewo+PiArICAgICBpbnQgcjsK
Pj4gKyAgICAgc3RydWN0IGRtYV9mZW5jZSAqb2xkX2ZlbmNlOwo+PiArCj4+ICsgICAgIHIgPSBk
cm1fc3luY29ial9zd2FwX2ZlbmNlcyhwLT5maWxwLCBoYW5kbGUsIE5VTEwsICZvbGRfZmVuY2Up
Owo+PiArICAgICBpZiAocikKPj4gKyAgICAgICAgICAgICByZXR1cm4gcjsKPgo+IEknbSBhIGJp
dCBwdXp6bGVkIG92ZXIgdGhpcyBpbnRlcmZhY2UgYXMgdGhpcyBtZWFucyB0aGF0IGFsbAo+IGlu
LXNlbWFwaG9yZXMgYXJlIG5vdCByZXVzYWJsZS4gVGhhdCBzZWVtcyBhIGJpdCBvZGQgYXMgaXQg
bWVhbnMKPiB1c2Vyc3BhY2UgY2FuJ3QgdXNlIHRoZSByZXN1bHRzIGZyb20gb25lIGVuZ2luZSBv
biB0d28rIHBhcmFsbGVsCj4gZW5naW5lcy4gU2VhcmNoaW5nIGtyb25vcyBmb3IgVmtTZW1hcGhv
cmUKPiBodHRwczovL3d3dy5raHJvbm9zLm9yZy9yZWdpc3RyeS92dWxrYW4vc3BlY3MvMS4wL21h
bi9odG1sL1ZrU2VtYXBob3JlLmh0bWwKPiBpc24ndCBlbmxpZ2h0ZW5pbmcuLi4KCllvdSBuZWVk
IHRvIGxvb2sgaW4gdGhlIHZ1bGthbiBzcGVjIGl0c2VsZi4KCkJ1dCB5ZXMgdGhpcyBpcyB0aGUg
c2VtYW50aWNzLCB2dWxrYW4gc2VtYXBob3JlcyBhcmUgZXhwbGljaXRseSAxOjEgb2JqZWN0cy4K
Ck9uZSB3YWl0IG11c3QgaGF2ZSBvbmUgc2lnbmFsLiBJdCdzIGEgc2VtYXBob3JlIG5vdCBhIGZl
bmNlLCBzbyB5b3UgY2FuJ3QKaGF2ZSBtdWx0aXBsZSBlbmdpbmVzIGdldHRpbmcgdGhlIHJlc3Vs
dHMgZnJvbSBvbmUgc2VtYXBob3JlLgoKRGF2ZS4KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
