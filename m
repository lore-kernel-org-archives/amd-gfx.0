From: Bas Nieuwenhuizen <bas-dldO88ZXqoXqqjsSq9zF6IRWq/SkRNHw@public.gmane.org>
Subject: Re: [PATCH 1/3] drm/amdgpu: fix a typo
Date: Tue, 27 Jun 2017 22:50:56 +0200
Message-ID: <CAP+8YyGouX0AeBxj+UNmb1Q7iwAzt0Z_hx__hf1Bb=YqC55J_A@mail.gmail.com>
References: <1498099356-31332-1-git-send-email-AlexBin.Xie@amd.com>
 <5ff65f82-9d15-4606-7e25-e4f75c172aed@vodafone.de>
 <DM5PR12MB1257B1FCC981D29A6D4045CDF2DB0@DM5PR12MB1257.namprd12.prod.outlook.com>
 <CAAxE2A7ic2YLmnkzM0Faa3bO9-GwWRTHRc0EUVej5UU7Yhs4Qg@mail.gmail.com>
 <efc2289a-382d-8443-8419-da2d0cadfd77@amd.com>
 <e23f64c3-6abf-ff65-2300-5c44d242f4df@amd.com>
 <CAAxE2A61KqM9gr=Zoo5PHFNb8gWp74RG9KOs=efWzf1dMKBwSA@mail.gmail.com>
 <7134d81f-a60f-7093-d2a3-70edde23cdb2@amd.com>
 <3436ae97-39b1-4a3f-bb73-2991adad5715@vodafone.de>
 <594CBEBC.5010703@amd.com> <0d847baf-8296-f3ce-7a8d-8823f33e392e@vodafone.de>
 <594CD8E0.3080702@amd.com> <594CDA92.1060809@amd.com>
 <CAPM=9tzXrih9qpkOY+OGC1TF8nD0ZmwNnxXiRbMtcO7tR1-m1Q@mail.gmail.com>
 <5950CFA0.90906@amd.com>
 <CAPM=9tw-E39oQ1gRPJs3oZBniALzgoa53ErF-trgxiN8Z9xyww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAPM=9tw-E39oQ1gRPJs3oZBniALzgoa53ErF-trgxiN8Z9xyww-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, axie <axie-5C7GfCeVMHo@public.gmane.org>, "Xie, AlexBin" <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>

T24gVHVlLCBKdW4gMjcsIDIwMTcgYXQgMTA6NDAgUE0sIERhdmUgQWlybGllIDxhaXJsaWVkQGdt
YWlsLmNvbT4gd3JvdGU6Cj4gT24gMjYgSnVuZSAyMDE3IGF0IDE5OjEwLCB6aG91Y20xIDxkYXZp
ZDEuemhvdUBhbWQuY29tPiB3cm90ZToKPj4KPj4KPj4gT24gMjAxN+W5tDA25pyIMjbml6UgMDM6
NDgsIERhdmUgQWlybGllIHdyb3RlOgo+Pj4+Cj4+Pj4gRG8geW91IG5vdCB1c2UgYm8gbGlzdCBh
dCBhbGwgaW4gbWVzYT8gcmFkdiBhcyB3ZWxsPwo+Pj4KPj4+IEN1cnJlbnRseSByYWR2IGlzIGNy
ZWF0aW5nIGEgYm8gbGlzdCBwZXIgY29tbWFuZCBzdWJtaXNzaW9uLiByYWR2IGRvZXMKPj4+IG5v
dCB1c2UgYW4gb2ZmbG9hZCB0aHJlYWQgdG8gZG8gY29tbWFuZCBzdWJtaXNzaW9uLCBhcyBpdCBz
ZWVtcyBwcmV0dHkKPj4+IHVuLXZ1bGthbiB0byB1c2UgYSB0aHJlYWQgZm9yIHRoZSBxdWV1ZSBz
dWJtaXNzaW9uIHRocmVhZCB0aGUgZ2FtZQo+Pj4gdXNlcy4KPj4+Cj4+PiBJIGhhdmUgY29uc2lk
ZXJlZCBpbnZlc3RpZ2F0aW5nIHRoaXMsIGJ1dCB3aXRoIHZ1bGthbiBpdCdzIHByb2JhYmx5Cj4+
PiBvcHRpbWlzaW5nIGZvciB0aGUgc2luZ2xlIHRocmVhZGVkIGNhc2Ugd2hpY2ggaXNuJ3Qgd2hl
cmUgYXBwcyBzaG91bGQKPj4+IHJlYWxseSBiZS4KPj4+Cj4+PiBBdCB0aGUgbW9tZW50IHdlIHJl
Z2VuZXJhdGUgdGhlIGJvIGxpc3Qgb24gZXZlcnkgQ1MgaW9jdGwsIHdlIHByb2JhYmx5Cj4+PiBj
YW4gZG8gYSBsb3QgYmV0dGVyLCBJIGtub3cgQmFzIGhhcyBsb29rZWQgaW50byB0aGlzIGFyZWEg
YSBiaXQgbW9yZQo+Pj4gdGhhbiBJLgo+Pgo+PiBUaGFua3MgRGF2ZSBmb3IgaW5wdXR0aW5nLgo+
Pgo+PiBDb3VsZCBJIGFzayBtb3JlIGFib3V0IHJhZHY/IEhvdyBkb2VzIHJhZHYgbWFrZSBibyBs
aXN0IGZvciBldmVyeSBjcyBpb2N0bD8KPj4gQWRkaW5nIGZpbHRlciBpbiBldmVyeSBvcGVyYXRp
b24sIGFueSByZWxhdGVkIGJvIHdpbGwgYmUgYWRkIHRvIGJvIGxpc3QKPj4gZHVyaW5nIG1ha2Ug
Y29tbWFuZCBzdWJtaXNzaW9uPwo+Cj4gV2hlbiB3ZSBjcmVhdGUgY29tbWFuZCBidWZmZXJzIHdl
IGFkZCBlYWNoIGJvIHRvIGEgbGlzdCBmb3IgaXQsIGJ1dCB3ZQo+IGRvbid0IGNhbGwgdGhlIGtl
cm5lbCBpb2N0bC4KPgo+IFdoZW4gd2UgZ2V0IGEgUXVldWVTdWJtaXQsIHdlIHVzdWFsbHkgc3Vi
bWl0IHR3byBJQnMgdG8gdGhlIGtlcm5lbCwKPiBvbmUgd2l0aCBzb21lIGNhY2hlIGZsdXNoZXMg
YW5kIG9uZSB3aXRoIHRoZSBtYWluIElCIGluIGl0LCBob3dldmVyIGFzCj4gd2UgaGF2ZSB0byBn
aXZlIHRoZSBrZXJuZWwgb25lIGJvIGxpc3Qgd2UgaGF2ZSB0byBjb21iaW5lIHRoZSB0d28KPiBs
aXN0cyAoZXZlbiBpZiB0aGUgY2FjaGUgZmx1c2ggbGlzdCBvbmx5IGhhcyBvbmUgaWIgaW4gaXQs
IGl0c2VsZiksIHNvCj4gd2UgY2FuJ3QgY2FsbCBjcmVhdGUgYm8gbGlzdCBlYXJseSwgd2UgaGF2
ZSB0byBkbyBpdCBqdXN0IGJlZm9yZQo+IGNvbW1hbmQgc3VibWlzc2lvbi4gSG93ZXZlciBJIGRv
bid0IHRoaW5rIHdlJ3ZlIGhhZCBhbnkgcHJvYmxlbXMgd2l0aAo+IHRoaXMgYmVpbmcgb3VyIHNs
b3cgcGF0aCB5ZXQsIGJ1dCB0aGlzIG1heSBjaGFuZ2UgaW4gdGhlIGZ1dHVyZS4KClllYWguIElJ
UkMgdGhlIGJvIGxpc3QgY3JlYXRlIGlzIHR5cGljYWxseSA8IDEwJSBvZiBvdXIga2VybmVsIHRp
bWUgZm9yIHJhZHYuCj4KPiBEYXZlLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
