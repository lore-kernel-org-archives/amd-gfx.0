From: zhoucm1 <zhoucm1-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/7] drm: add syncobj timeline support v8
Date: Thu, 18 Oct 2018 11:11:41 +0800
Message-ID: <b08b1f23-d8dc-a294-2176-5125075c9acc@amd.com>
References: <20181015085553.30656-1-david1.zhou@amd.com>
 <20181015085553.30656-2-david1.zhou@amd.com>
 <20181017080908.GK31561@phenom.ffwll.local>
 <2066a18d-8002-014b-ef3c-a6f6014bdb55@amd.com>
 <2f99da09-7bf7-d5e7-d7c1-fe2e4cf43b40@amd.com>
 <CAKMK7uGxptMKtz-4JzT9us3M2dsLGhTSVuAKduNH+VGCsCSsQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAKMK7uGxptMKtz-4JzT9us3M2dsLGhTSVuAKduNH+VGCsCSsQw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
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
To: Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Rakos,
 Daniel" <Daniel.Rakos-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Bas Nieuwenhuizen <bas-dldO88ZXqoXqqjsSq9zF6IRWq/SkRNHw@public.gmane.org>, Dave Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

CgpPbiAyMDE45bm0MTDmnIgxN+aXpSAxODoyNCwgRGFuaWVsIFZldHRlciB3cm90ZToKPiBPbiBX
ZWQsIE9jdCAxNywgMjAxOCBhdCAxMToyOSBBTSBLb2VuaWcsIENocmlzdGlhbgo+IDxDaHJpc3Rp
YW4uS29lbmlnQGFtZC5jb20+IHdyb3RlOgo+PiBBbSAxNy4xMC4xOCB1bSAxMToxNyBzY2hyaWVi
IHpob3VjbTE6Cj4+PiBbU05JUF0KPj4+Pj4gICAgK3N0cnVjdCBkcm1fc3luY29ial9zaWduYWxf
cHQgewo+Pj4+PiArICAgIHN0cnVjdCBkbWFfZmVuY2VfYXJyYXkgKmJhc2U7Cj4+Pj4gT3V0IG9m
IGN1cmlvc2l0eSwgd2h5IHRoZSBwb2ludGVyIGFuZCBub3QgZW1iZWRkaW5nPyBiYXNlIGlzIGtp
bmRhCj4+Pj4gbWlzbGVhZGluZyBmb3IgYSBwb2ludGVyLgo+Pj4gWWVhaCwgQ2hyaXN0aWFuIGRv
ZXNuJ3QgbGlrZSBzaWduYWxfcHQgbGlmZWN5Y2xlIHNhbWUgYXMgZmVuY2UsIHNvCj4+PiBpdCdz
IGEgcG9pbnRlci4KPj4+IElmIHlvdSBkb24ndCBsaWtlICdiYXNlJyBuYW1lLCBJIGNhbiBjaGFu
Z2UgaXQuCj4+IFdlbGwgSSBuZXZlciBzYWlkIHRoYXQgeW91IGNhbid0IGVtYmVkIHRoZSBmZW5j
ZSBhcnJheSBpbnRvIHRoZSBzaWduYWxfcHQuCj4+Cj4+IFlvdSBqdXN0IG5lZWQgdG8gbWFrZSBz
dXJlIHRoYXQgd2UgZG9uJ3QgYWZmZWN0IHRoZSBkcm1fc3luY29iago+PiBsaWxlY3ljbGUgYXMg
d2VsbCwgZS5nLiB0aGF0IHdlIGRvbid0IGFsc28gbmVlZCB0byBrZWVwIHRoYXQgYXJvdW5kLgo+
IEkgZG9uJ3Qgc2VlIGEgcHJvYmxlbSB3aXRoIHRoYXQsIGFzIGxvbmcgYXMgZHJtX3N5bmNvYmog
a2VlcHMgYQo+IHJlZmVyZW5jZSB0byB0aGUgZmVuY2Ugd2hpbGUgaXQncyBvbiB0aGUgdGltZWxp
bmUgbGlzdC4gV2hpY2ggaXQKPiBhbHJlYWR5IGRvZXMuIEFuZCBlbWJlZGRpbmcgd291bGQgYXZv
aWQgdGhhdCAybmQgc2VwYXJhdGUgYWxsb2NhdGlvbiwKPiBhc2lkZSBmcm9tIG1ha2luZyBiYXNl
IGxlc3MgY29uZnVzaW5nLgpUaGF0J3MgaW5kZWVkIG15IGluaXRpYWwgaW1wbGVtZW50YXRpb24g
Zm9yIHNpZ25hbF9wdC93YWl0X3B0IHdpdGggZmVuY2UgCmJhc2VkLCBidXQgYWZ0ZXIgbG9uZyBh
bmQgbWFueSBkaXNjdXNzaW9ucywgd2UgZ2V0IGN1cnJlbnQgc29sdXRpb24sIGFzIAp5b3Ugc2Vl
LCB0aGUgdmVyc2lvbiBpcyB1cCB0byB2OCA6KS4KCkZvciBoZXJlwqAgd2h5IHRoZSBwb2ludGVy
IGFuZCBub3QgZW1iZWRkaW5nPwpUd28gcmVhc29uczoKMS4gdGhlaXIgbGlmZWN5Y2xlcyBhcmUg
bm90IHNhbWUuCjIuIEl0IGlzIGEgZmVuY2UgYXJyYXkgdXNhZ2UsIHdoaWNoIGFsd2F5cyBuZWVk
cyBzZXBhcmF0ZSBhbGxvY2F0aW9uLCAKc2VlbXMgd2hpY2ggaXMgbWFuZGF0b3J5LgpTbyBpdCBp
cyBhIHBvaW50ZXIuCgpCdXQgdGhlIG5hbWUgaXMgaGlzdG9yaWNhbCBmcm9tIGluaXRpYWwsIGFu
ZCBpbmRlZWQgYmUga2luZGEgbWlzbGVhZGluZyAKZm9yIGEgcG9pbnRlciwgSSB3aWxsIGNoYW5n
ZSBpdCB0byBmZW5jZV9hcnJheSBpbnN0ZWFkIGluIGNvbWluZyB2OS4KClRoYW5rcywKRGF2aWQg
WmhvdQoKPiAtRGFuaWVsCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
