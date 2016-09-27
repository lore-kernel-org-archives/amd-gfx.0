From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 0/3] drm/amdgpu: implement raster configuration
Date: Tue, 27 Sep 2016 09:17:51 +0200
Message-ID: <4120919c-2b50-b78a-406d-f3974ef00f12@vodafone.de>
References: <1474166210-21736-1-git-send-email-ray.huang@amd.com>
 <CAAxE2A7nSCd-_ViLiJ5RZfTC54DNoYCKL2Ny=WgLSDVCEcdVOQ@mail.gmail.com>
 <MWHPR12MB1694E693082763289AA98A51F7CD0@MWHPR12MB1694.namprd12.prod.outlook.com>
 <CAAxE2A7qzNC1mBJ9Q0SbL3A8xmfjhMrYk6Ey4kB3ws9s7VUDeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAAxE2A7qzNC1mBJ9Q0SbL3A8xmfjhMrYk6Ey4kB3ws9s7VUDeg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: "Huan, Alvin" <Alvin.Huan-5C7GfCeVMHo@public.gmane.org>, "Wang, Ken" <Ken.Wang-5C7GfCeVMHo@public.gmane.org>, "Huang,
 Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

QW0gMjcuMDkuMjAxNiB1bSAwMToxMyBzY2hyaWViIE1hcmVrIE9sxaHDoWs6Cj4gT24gTW9uLCBT
ZXAgMjYsIDIwMTYgYXQgMTA6NDIgUE0sIERldWNoZXIsIEFsZXhhbmRlcgo+IDxBbGV4YW5kZXIu
RGV1Y2hlckBhbWQuY29tPiB3cm90ZToKPj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4+
PiBGcm9tOiBNYXJlayBPbMWhw6FrIFttYWlsdG86bWFyYWVvQGdtYWlsLmNvbV0KPj4+IFNlbnQ6
IE1vbmRheSwgU2VwdGVtYmVyIDI2LCAyMDE2IDQ6MzkgUE0KPj4+IFRvOiBIdWFuZywgUmF5Cj4+
PiBDYzogYW1kLWdmeCBtYWlsaW5nIGxpc3Q7IERldWNoZXIsIEFsZXhhbmRlcjsgV2FuZywgS2Vu
OyBIdWFuLCBBbHZpbgo+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCAwLzNdIGRybS9hbWRncHU6IGlt
cGxlbWVudCByYXN0ZXIgY29uZmlndXJhdGlvbgo+Pj4KPj4+IFRoZSBzZXJpZXMgaXMgbWlzc2lu
ZyBhIERSTSB2ZXJzaW9uIGJ1bXAsIHNvIE1lc2EgY2FuJ3QgcmVhbGx5IHVzZSBpdAo+Pj4gZXZl
biBpZiBpdCB3YW50ZWQuCj4+Pgo+PiBXZSBidW1wZWQgaXQgYWxyZWFkeSB0aGlzIGN5Y2xlIGZv
ciBzZXZlcmFsIG90aGVyIHRoaW5ncywgYnV0IEkgY2FuIGFkZCBhIHNwZWNpZmljIGJ1bXAgZm9y
IHRoaXMgYXMgd2VsbCBpZiB0aGF0IGlzIHByZWZlcnJlZC4KPiBPaCwgdGhhdCdzIG5vdCBuZWNl
c3NhcnkuIE9uZSBidW1wIHBlciBjeWNsZSBpcyBPSy4KCkFzIEkgd3JvdGUgaW4gdGhlIG90aGVy
IHRocmVhZCBhcyB3ZWxsLCBidW1waW5nIG9uY2UgcGVyIGN5Y2xlIHN1Y2tzIAp3aGVuIHlvdSB3
YW50IHRvIGJpc2VjdCBzb21ldGhpbmcuCgpXZSBhcmUgYWxzbyBub3Qgc2hvcnQgb24gbnVtYmVy
cywgc28gSSBzdWdnZXN0IHRoYXQgd2UgZXN0YWJsaXNoIHRoYXQgd2UgCmFsd2F5cyBidW1wIHdo
ZW4gd2UgYWRkIGEgbmV3IGludGVyZmFjZSB0byB0aGUga2VybmVsIElPQ1RMLgoKQ2hyaXN0aWFu
LgoKPgo+IE1hcmVrCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
